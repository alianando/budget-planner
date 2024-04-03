import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 1;
  late TextEditingController messageCon;

  @override
  void initState() {
    super.initState();
    messageCon = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    messageCon.dispose();
  }

  void resetFeedback() {
    setState(() {
      messageCon.clear();
      rating = 0;
    });
  }

  void saveRating() async {
    final user = FirebaseAuth.instance.currentUser;
    String userName = user!.displayName!;
    String message = messageCon.text;
    // debugPrint('## $message, ${rating}');
    FirebaseFirestore.instance.collection("feedback").doc(userName).set({
      'user': userName,
      'rating': rating,
      'message': message,
    }, SetOptions(merge: true));
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Thank you for your feedback'),
    ));
    resetFeedback();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Give Feedback",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => resetFeedback(),
            child: const Icon(Icons.clear, color: Colors.black, size: 25.0),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (newVal) {
                setState(() {
                  rating = newVal;
                });
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: TextFormField(
              controller: messageCon,
              maxLines: 4,
              textInputAction: TextInputAction.done,
              validator: (value) {
                if (value == null) {
                  return 'please add a message';
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Enter your feedback",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: const BorderSide(color: Colors.greenAccent),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () => saveRating(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Submit'),
            ),
          )
        ],
      ),
    );
  }
}
