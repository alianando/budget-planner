// ignore_for_file: file_names

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User user = FirebaseAuth.instance.currentUser!;

  Future<bool> updateCurrentUser() async {
    user = FirebaseAuth.instance.currentUser!;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: FutureBuilder<bool>(
              future: updateCurrentUser(),
              builder: (context, data) {
                return Column(
                  children: [
                    const SizedBox(height: 50),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade200,
                          child: CircleAvatar(
                            radius: 55,
                            backgroundImage: user.photoURL != null
                                ? NetworkImage(user.photoURL!)
                                : null,
                          ),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 1,
                          child: InkWell(
                            onTap: () async {
                              _pickFile(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 0.5,
                                  // color: Colors.white,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                    50,
                                  ),
                                ),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(2, 4),
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(0.5),
                                child: Icon(Icons.edit,
                                    color: Colors.black, size: 30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    // const _BuildUNameEditor(),
                    // const SizedBox(height: 50),
                    // const _BuildEmailEditor(),
                    // const SizedBox(height: 50),
                    // const _BuildPasswordField(),
                    // const SizedBox(height: 50),
                    // _BuildButton(widget.user),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _pickFile(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.image,
    );
    if (result == null) return;

    final file = result.files.first;

    debugPrint(file.name);
    debugPrint(file.path);
    debugPrint(file.size.toString());

    if (file.path != null) {
      File image = File(file.path!);

      final User user = FirebaseAuth.instance.currentUser!;
      debugPrint('### ${file.name}');
      //passing your path with the filename to Firebase Storage Reference
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('profileImg/${file.name}');
      UploadTask uploadTask = ref.putFile(image);
      // String url = '';
      uploadTask.then((res) async {
        String url = await res.ref.getDownloadURL();
        if (url.isNotEmpty) {
          debugPrint('## could not print');
          user.updatePhotoURL(url);
        }
      });
    }
    EasyLoading.dismiss();
    setState(() {
      // user = FirebaseAuth.instance.currentUser!;
    });
    // if (context.mounted) {
    //   Navigator.of(context).pop();
    // }
  }
}
