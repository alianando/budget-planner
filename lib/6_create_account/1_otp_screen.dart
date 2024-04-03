// ignore_for_file: file_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '2_add_additional_user_info.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late TextEditingController otpController;

  bool emailSent = false;

  @override
  void initState() {
    super.initState();
    otpController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  void verifyOtp() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.toString(),
      );

      FirebaseAuth.instance.signInWithCredential(credential).then((value) {
        if (value.user == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Could not log in, Please try agian later'),
          ));
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
          return;
        }
        // Navigator.of(context)
        //   ..pop()
        //   ..pop();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddAdditionalUserInfoPage(user: value.user!),
          ),
        );
      });
    } catch (ex) {
      debugPrint('## error at verify otp');
      debugPrint('## ${ex.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Otp'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 200),
              const Text('Enter the otp sent to your numner'),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: otpController,
                // defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                // validator: (s) {
                //   return s == '2222' ? null : 'Pin is incorrect';
                // },
                // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => debugPrint(
                  'Otp : ${otpController.text.toString()}',
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () => verifyOtp(),
                child: const Text('Confirm'),
              )
            ],
          ),
        ),
      ),
    );
  }

  static final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: FontWeight.w600,
    ),
    decoration: BoxDecoration(
      border: Border.all(
          // color: Color.fromRGBO(234, 239, 243, 1),
          color: Colors.blue),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  static final focusedPinTheme = defaultPinTheme.copyDecorationWith(
    border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
    borderRadius: BorderRadius.circular(8),
  );

  final submittedPinTheme = defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration?.copyWith(
      color: const Color.fromRGBO(234, 239, 243, 1),
    ),
  );
}
