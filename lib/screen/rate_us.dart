import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nokasa_user/screen/thank_you.dart';
import 'package:nokasa_user/utils/colors.dart';
import 'package:nokasa_user/widget/green_button.dart';
import 'package:nokasa_user/widget/text/fig_tree_text.dart';
import 'package:nokasa_user/widget/text/heading_text.dart';

class RateUs extends StatefulWidget {
  final String orderId;
  const RateUs({super.key, required this.orderId});

  @override
  State<RateUs> createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  double rating = 0;
  TextEditingController reviewController = TextEditingController();
  bool isActive = false;
  bool isLoading = false;

  void submit() async {
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ThankYou()));
  }

  void textChange(String text) {
    setState(() {
      isActive = text.length > 5 && rating > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // This centers the entire content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centers vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // Centers horizontally
            children: [
              HeadingText(
                text: "You’re all set!",
                fontSize: 40,
              ),
              SizedBox(
                height: 10,
              ),
              FigtreeText(
                text: "How would you rate us?",
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: 20,
              ),
              StarRating(
                rating: rating,
                size: 40,
                onRatingChanged: (rating) => {
                  setState(() {
                    this.rating = rating;
                  })
                },
                color: primaryColor,
                borderColor: primaryColor,
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: reviewController,
                onChanged: textChange,
                maxLength: 200,
                minLines: 5,
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: "Share your experience",
                  hintStyle: GoogleFonts.figtree(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey),
                  filled: true, // This makes the background color visible
                  fillColor: Colors.white, // Sets the background to white
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(20), // Sets the border radius
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: grey2,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GreenButton(
                  onPressed: submit,
                  isActive: isActive,
                  text: "Leave a review",
                  loading: isLoading)
            ],
          ),
        ),
      ),
    );
  }
}
