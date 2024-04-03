// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../10_profile/1_profile_page.dart';
import '../../1_constants/2_helper.dart';
import '../../1_constants/theme.dart';

class CustomAppBar extends StatelessWidget {
  final User user;
  final int totalAmount;
  const CustomAppBar({
    super.key,
    required this.user,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 123, 255),
      child: Column(
        children: [
          SafeArea(child: Container()),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(width: 15),
              SizedBox(width: 15),
            ],
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => ProfilePage(user: user)),
                            );
                          },
                          child: Row(
                            children: [
                              _BuildProfile(user.photoURL),
                              const SizedBox(width: 5),
                              Text(user.displayName ?? 'you'),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // const Icon(Icons.remove_red_eye),
                        const SizedBox(width: 10),
                        const Icon(Icons.notifications),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(height: 5),
                    // Text(
                    //   'Tk $totalAmount',
                    //   style: const TextStyle(
                    //     fontSize: 32,
                    //     color: Colors.redAccent,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    Text(
                      getAmountString(totalAmount),
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: (totalAmount < 0)
                            ? Colors.redAccent
                            : CTheme.primaryColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BuildProfile extends StatelessWidget {
  final String? url;
  const _BuildProfile(this.url);

  @override
  Widget build(BuildContext context) {
    if (url == null) {
      return const CircleAvatar(
        radius: 10,
        child: Icon(Icons.person, size: 15),
      );
    }
    return CircleAvatar(
      radius: 10,
      child: Image.network(
        url!,
        height: 15,
        width: 15,
      ),
    );
  }
}
