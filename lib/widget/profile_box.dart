import 'package:flutter/material.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBox extends StatefulWidget {
  final String heading;
  final String subHeading;
  final Widget next;
  final bool isContact;
  const ProfileBox({
    super.key,
    required this.heading,
    required this.subHeading,
    required this.next,
    this.isContact = false,
  });

  @override
  State<ProfileBox> createState() => _ProfileBoxState();
}

class _ProfileBoxState extends State<ProfileBox> {
  void openCall() async {
    final Uri launchUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: '+916363005509',
      queryParameters: {'text': 'Hello, I need assistance with your services!'},
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  void push() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => widget.next));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.heading,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        widget.subHeading,
        style: TextStyle(
          color: grey2,
        ),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
      onTap: widget.isContact ? openCall : push,
    );
  }
}
