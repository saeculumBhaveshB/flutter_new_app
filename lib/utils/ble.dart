import 'dart:async';

import 'package:convert/convert.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:permission_handler/permission_handler.dart';

class Ble {
  late final StreamSubscription<List<int>> _valueSubscription;
  final String serviceUUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String charUUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  BluetoothDevice? targetDevice;
  final key = encrypt.Key.fromUtf8("SmartBinSecret!!");
  BluetoothCharacteristic? _characteristic;
  String binId = "1";
  String authToken = "NK_${DateTime
      .now()
      .millisecondsSinceEpoch}";
  String deviceToken = "";
  List<num> weights = [];

  String getBinId(){
    return binId;
  }
  // Connect to SmartBin
  Future<bool> connectToSmartBin() async {
    try {
      if (!await FlutterBluePlus.isSupported) {
        print("Bluetooth not supported");
        return false;
      }

      if (Platform.isAndroid) {
        Map<Permission, PermissionStatus> statuses = await [
          Permission.bluetoothScan,
          Permission.bluetoothConnect,
          Permission.location,
        ].request();

        if (!statuses.values.every((status) => status.isGranted)) {
          print("Permissions not granted");
          return false;
        }
      }

      if (!kIsWeb && Platform.isAndroid) {
        await FlutterBluePlus.turnOn();
      }

      // Wait until Bluetooth is ON
      await FlutterBluePlus.adapterState
          .where((state) => state == BluetoothAdapterState.on)
          .first;

      // Start scanning for SmartBin
      await FlutterBluePlus.startScan(
        withNames: ["SmartBin"],
        timeout: const Duration(seconds: 10),
      );

      await for (final results in FlutterBluePlus.scanResults) {
        for (final result in results) {
          if (result.device.platformName == "SmartBin") {
            targetDevice = result.device;
            await FlutterBluePlus.stopScan();
            await Future.delayed(Duration(seconds: 2));
            await targetDevice!.connect();

            final services = await targetDevice!.discoverServices();
            for (final service in services) {
              if (service.uuid.toString() == serviceUUID) {
                for (final c in service.characteristics) {
                  if (c.uuid.toString() == charUUID) {
                    _characteristic = c;
                    await c.setNotifyValue(true);
                    _valueSubscription =
                        c.onValueReceived.listen(_handleValueChange);
                    return true;
                  }
                }
              }
            }

            return false;
          }
        }
      }

      return false;
    } catch (e) {
      print("Connection error: $e");
      return false;
    }
  }

  // Encrypt text using AES ECB
  String encryptText(String text) {
    final encrypter =
    encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.ecb));
    final encrypted = encrypter.encrypt(text, iv: encrypt.IV.fromLength(16));
    return encrypted.base16;
  }

  // Decrypt AES hex string
  String decryptText(String hexText) {
    try {
      final encryptedBytes = Uint8List.fromList(hex.decode(hexText));
      final encrypted = encrypt.Encrypted(encryptedBytes);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.ecb,
            padding: null), // disable default PKCS7
      );

      // Decrypt without padding, manually remove zeros
      final decryptedRaw = encrypter.decryptBytes(encrypted);
      final decryptedStr = utf8.decode(decryptedRaw).replaceAll(
          RegExp(r'\x00+$'), '');

      return decryptedStr;
    } catch (e) {
      print("Decryption error: $e");
      return "";
    }
  }


  // Send encrypted command to device
  Future<void> sendCommand(String command) async {
    if (_characteristic == null) return;
    final encrypted = encryptText(command);
    await _characteristic!.write(utf8.encode(encrypted),
        withoutResponse: false);
  }

  // Handle incoming data
  void _handleValueChange(List<int> valueBytes) {
    final encryptedStr = utf8.decode(valueBytes);
    final decrypted = decryptText(encryptedStr);

    print("Received encrypted: $encryptedStr");
    print("Decrypted: $decrypted");

    // Check if it's a SESSION command response
    if (decrypted.startsWith("SESSION:")) {
      print("Received SESSION command response");
      return; // Just acknowledge receipt, no need to parse as JSON
    }

    try {
      final jsonData = jsonDecode(decrypted);
      print("Parsed JSON: $jsonData");

      // Handle the response based on statusCode
      if (jsonData['statusCode'] == 200) {
        if (jsonData.containsKey('weight')) {
          final weightVal = double.tryParse(jsonData['weight'].toString());
          if (weightVal != null) {
            weights.add(weightVal);
            print("Weight received: $weightVal");
          }
        }
        else if(jsonData.containsKey('deviceId')){
          print('device id is ${jsonData['deviceId']}');
          binId=jsonData['deviceId'];
        }
      } else {
        print("Error response: ${jsonData['error']}");
      }
    } catch (e) {
      print("Error parsing response: $e");
      print(decrypted);
    }
  }

  // Start weighing session
  Future<void> startWeighing(String userId) async {
    weights.clear(); // clear previous session weights
    await sendCommand("SESSION:$userId|$binId");
    await sendJson("START");
  }

  Future<void> sendJson(String text) async {
    final jsonData = jsonEncode({
      "action": text,
      "userId": "123" // Keep as string to match ESP's expectation
    });
    final encrypted = encryptText(jsonData);
    await _characteristic!.write(utf8.encode(encrypted),
        withoutResponse: false);
  }

  // Stop weighing and return the collected weights
  Future<List<num>> stopWeighing() async {
    await sendJson("STOP");
    await disconnect();
    return weights;
  }


  Future<void> disconnect() async {
    if (targetDevice != null) {
      await targetDevice!.disconnect();
      targetDevice = null;
      _valueSubscription.cancel();
      _characteristic = null;
    }
  }
}