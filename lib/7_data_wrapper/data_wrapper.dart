import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

import '../1_constants/1_models/data.dart';
import '../8_root/root.dart';

class DataWrapper extends StatelessWidget {
  final User user;
  const DataWrapper({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    /// returns a stream, and build a widget.
    return StreamBuilder(
      /// got from firebase documnetation
      /// where ever the value changes in the database
      /// new value is returend.
      stream: FirebaseFirestore.instance
          .collection('db')
          .doc(user.displayName)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'Something went wrong while fetching transaction data',
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Loading();
        }
        if (snapshot.data!.data() == null) {
          FirebaseFirestore.instance
              .collection('db')
              .doc(user.displayName)
              .set({'userName': user.displayName});
          return const CreateData();
        }

        final Data data = Data.fromJson(snapshot.data!.data()!);
        final Logger logger = Logger();
        // debugPrint('## ${data.dailyTransactions.length}');
        // logger.d(data.toString());
        logger.d(data.toJson());
        return Root(data: data);
      },
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}

class CreateData extends StatelessWidget {
  const CreateData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        ),
        SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
        ),
        const Text('Setting up your wallet')
      ],
    ));
  }
}
