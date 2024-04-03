// ignore_for_file: file_names, unused_element

import 'dart:io';

import 'package:budget_planner/1_constants/1_firebase_constants.dart';
import 'package:budget_planner/2_providers/1_create_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddAdditionalUserInfoPage extends StatefulWidget {
  final User user;
  const AddAdditionalUserInfoPage({super.key, required this.user});

  @override
  State<AddAdditionalUserInfoPage> createState() =>
      _AddAdditionalUserInfoPageState();
}

class _AddAdditionalUserInfoPageState extends State<AddAdditionalUserInfoPage> {
  @override
  void initState() {
    super.initState();
    getExistingUserNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add additional User information'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 50),
              const BuildProfileWidget(),
              const SizedBox(height: 50),
              const _BuildUNameEditor(),
              const SizedBox(height: 50),
              const _BuildEmailEditor(),
              const SizedBox(height: 50),
              const _BuildPasswordField(),
              const SizedBox(height: 50),
              _BuildButton(widget.user),
            ],
          ),
        ),
      ),
    );
  }

  void getExistingUserNames() async {
    final provider = Provider.of<CreateUserProvider>(context, listen: false);
    DocumentSnapshot<Map<String, dynamic>> result = await FirebaseFirestore
        .instance
        .collection(userNameCol)
        .doc(userNameDoc)
        .get();
    List<String> resultList = [];
    for (final val in result.data()!['values']) {
      resultList.add(val.toString());
    }
    provider.updateExistingUserName(resultList);
    debugPrint('## existing user names ${resultList.toString()}');
  }
}

class _BuildUNameEditor extends StatelessWidget {
  const _BuildUNameEditor();

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          onChanged: (value) => provider.updateName(value),
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.person),
            hintText: 'User name',
            errorText: provider.userNameErrorTxt,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildEmailEditor extends StatelessWidget {
  const _BuildEmailEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(builder: (context, provider, child) {
      return TextFormField(
        onChanged: (value) => provider.updateEmail(value),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.email),
          hintText: 'Email',
          errorText: provider.emailErrorTxt,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      );
    });
  }
}

class BuildProfileWidget extends StatelessWidget {
  const BuildProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade200,
              child: CircleAvatar(
                radius: 55,
                backgroundImage: provider.photoUrl != ''
                    ? FileImage(File(provider.photoUrl))
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
                    child: Icon(Icons.edit, color: Colors.black, size: 30),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _pickFile(BuildContext context) async {
    final provider = Provider.of<CreateUserProvider>(context, listen: false);
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
      provider.addProfileUrl(file.path!);
      File image = File(file.path!);

      final User user = FirebaseAuth.instance.currentUser!;
      debugPrint('### ${file.name}');
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child('profileImg/${file.name}');
      UploadTask uploadTask = ref.putFile(image);
      uploadTask.then((res) async {
        String url = await res.ref.getDownloadURL();
        if (url.isNotEmpty) {
          debugPrint('## could not print');
          user.updatePhotoURL(url);
        }
      });
    }
  }
}

class _BuildPasswordField extends StatelessWidget {
  const _BuildPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(builder: (context, provider, child) {
      return TextFormField(
        onChanged: (value) => provider.updatePassword(value),
        obscureText: !provider.showPassword,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.password_outlined),
          suffixIcon: InkWell(
            child: provider.showPassword == true
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility),
            onTap: () => provider.updateShowPassword(),
          ),
          hintText: 'Password',
          errorText: provider.passwordError,
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      );
    });
  }
}

class _BuildButton extends StatelessWidget {
  final User user;
  const _BuildButton(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateUserProvider>(builder: (context, provider, child) {
      return ElevatedButton(
        onPressed: () {
          if (provider.userNameErrorTxt != null || provider.userName.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please provider a correct userName'),
            ));
            return;
          }
          if (provider.emailErrorTxt != null || provider.email.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please provider a correct email'),
            ));
            return;
          }
          if (provider.passwordError != null || provider.password.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Please provider a correct password'),
            ));
            return;
          }

          EasyLoading.show(status: 'loading...');
          final newUser = FirebaseAuth.instance.currentUser!;
          // if (provider.photoUrl.isNotEmpty) {
          //   newUser.updatePhotoURL(provider.photoUrl);
          // }
          FirebaseFirestore.instance
              .collection(userNameCol)
              .doc(userNameDoc)
              .update({
            'values': FieldValue.arrayUnion(
              [provider.userName],
            )
          });

          newUser.updateDisplayName(provider.userName);
          newUser.verifyBeforeUpdateEmail(provider.email);
          newUser.updatePassword(provider.password);
          FirebaseAuth.instance.signInWithEmailAndPassword(
            email: provider.email,
            password: provider.password,
          );
          EasyLoading.dismiss();
          Navigator.of(context)
            ..pop()
            ..pop()
            ..pop();
        },
        child: Text(provider.buttonTxt),
      );
    });
  }
}
