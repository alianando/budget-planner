import 'package:budget_planner/14_more/rate_app.dart';
import 'package:budget_planner/14_more/show_video.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../1_constants/1_models/data.dart';

class MorePage extends StatelessWidget {
  final Data data;
  const MorePage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Options'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const ShowVideo();
                }));
              },
              leading: const Icon(Icons.video_camera_front),
              title: const Text('Tutorials'),
              contentPadding: const EdgeInsets.only(left: 25),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              onTap: () {
                final newD = Data(
                  userName: data.userName,
                );
                final newDataJson = newD.toJson();

                FirebaseFirestore.instance
                    .collection('db')
                    .doc(data.userName)
                    .set(newDataJson);
              },
              leading: const Icon(Icons.clear),
              title: const Text('Clear Wallet'),
              contentPadding: const EdgeInsets.only(left: 25),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const FeedbackScreen();
                }));
              },
              leading: const Icon(Icons.rate_review),
              title: const Text('Rate App'),
              contentPadding: const EdgeInsets.only(left: 25),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
              },
              leading: const Icon(Icons.logout),
              title: const Text('Log out'),
              contentPadding: const EdgeInsets.only(left: 25),
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       // const Text('More Options'),
      //       const SizedBox(height: 100),
      //       const Divider(),
      //       ListTile(
      //         title: const Text('Clear Wallet'),
      //         onTap: () async {
      //           final newD = Data(
      //             userName: data.userName,
      //           );
      //           final newDataJson = newD.toJson();

      //           FirebaseFirestore.instance
      //               .collection('db')
      //               .doc(data.userName)
      //               .set(newDataJson);
      //         },
      //       ),
      //       const Divider(),
      //       ListTile(
      //         title: const Text('Log out'),
      //         onTap: () async {
      //           await FirebaseAuth.instance.signOut();
      //         },
      //       ),
      //       const Divider(),
      //     ],
      //   ),
      // ),
    );
  }
}
