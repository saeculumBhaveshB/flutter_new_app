import 'package:flutter/material.dart';
import 'package:nokasa_user/models/user.dart';
import 'package:nokasa_user/resources/auth_methods.dart';
import 'package:nokasa_user/screen/past_order/orders.dart';
import 'package:nokasa_user/screen/profile/edit_profile.dart';
import 'package:nokasa_user/screen/profile/edit_upiId.dart';
import 'package:nokasa_user/widget/custom_app_bar.dart';
import 'package:nokasa_user/widget/profile_box.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String upiId = "enter upiId";
  void getUserDeails() async {
    User data = await AuthMethods().getUserDetails();
    if (data.upiID.isNotEmpty) {
      setState(() {
        upiId = data.upiID;
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserDeails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ProfileBox(
                heading: "Profile",
                subHeading: "Edit profile details",
                next: EditProfile()),
            ProfileBox(heading: "UPI", subHeading: upiId, next: EditUpiid()),
            ProfileBox(
                heading: "Orders", subHeading: "Order history", next: Orders()),
            ProfileBox(
              heading: "Help",
              subHeading: "Inquire about any service",
              next: EditProfile(),
              isContact: true,
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await AuthMethods().signOut(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE74C3C), // Red color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18), // Rounded corners
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 4,
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
