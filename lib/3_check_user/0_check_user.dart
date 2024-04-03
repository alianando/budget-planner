// ignore_for_file: file_names

import 'package:budget_planner/7_data_wrapper/data_wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../4_log_in.dart/0_log_in.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
  }

  void checkInternetAccess() async {}

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Text('checking login status'),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('encountered problem while checking log in status'),
            ),
          );
        }
        if (snapshot.data == null) {
          return const LogInPage();
        }
        // if (snapshot.data!.displayName == null) {
        //   debugPrint('## user info ${snapshot.data.toString()}');
        //   return AddAdditionalUserInfoPage(user: snapshot.data!);
        // }
        // if (snapshot.data!.email == null) {
        //   debugPrint('## user info ${snapshot.data.toString()}');
        //   return AddAdditionalUserInfoPage(user: snapshot.data!);
        // }
        // if (snapshot.data!.photoURL == null) {
        //   debugPrint('## user info ${snapshot.data.toString()}');
        //   return AddAdditionalUserInfoPage(user: snapshot.data!);
        // }
        else {
          return DataWrapper(user: snapshot.data!);
        }
        // if (snapshot.data!.displayName == null) {
        //   return AddAdditionalUserInfoPage(user: snapshot.data!);
        // }
        // debugPrint('## user info ${snapshot.data.toString()}');
        // return Scaffold(
        //   body: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       const Text('User Log in'),
        //       ElevatedButton(
        //         onPressed: () {
        //           FirebaseAuth.instance.signOut();
        //         },
        //         child: const Text(' - log out - '),
        //       )
        //     ],
        //   ),
        // );
      },
    );
  }
}
