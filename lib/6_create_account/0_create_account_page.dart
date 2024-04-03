// ignore_for_file: file_names

import 'package:budget_planner/6_create_account/1_otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  late TextEditingController phoneController;

  bool loading = false;
  String? data;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    loadFromJson();
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void sendOtp() async {
    setState(() {
      loading = true;
    });
    if (data == null) {
      setState(() {
        loading = true;
      });
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: data,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (emailSent == false) {
    //   Scaffold(
    //     appBar: AppBar(),
    //     body: Center(
    //       child: Column(
    //         children: [
    //           const SizedBox(height: 100),
    //           const Center(
    //             child: Text('A email with further instraction have been send.'),
    //           ),
    //           const SizedBox(height: 50),
    //           OutlinedButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: const Text('Go back'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              InternationalPhoneNumberInput(
                height: 60,
                controller: phoneController,
                inputFormatters: const [],
                formatter: MaskedInputFormatter('### ### ## ##'),
                initCountry: CountryCodeModel(
                  name: "Bangladesh",
                  dial_code: "+880",
                  code: "BD",
                ),
                betweenPadding: 23,
                onInputChanged: (phone) {
                  data = '${phone.dial_code}${phone.rawNumber}';
                  debugPrint('## phone: $data');
                  debugPrint('## ------------------------------');
                },
                loadFromJson: loadFromJson,
                dialogConfig: DialogConfig(
                  backgroundColor: const Color(0xFF444448),
                  searchBoxBackgroundColor: const Color(0xFF56565a),
                  searchBoxIconColor: const Color(0xFFFAFAFA),
                  countryItemHeight: 55,
                  flatFlag: true,
                  topBarColor: const Color(0xFF1B1C24),
                  selectedItemColor: const Color(0xFF56565a),
                  selectedIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset(
                      "assets/check.png",
                      width: 20,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  textStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  searchBoxTextStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  titleStyle: const TextStyle(
                      color: Color(0xFFFAFAFA),
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                  searchBoxHintStyle: TextStyle(
                      color: const Color(0xFFFAFAFA).withOpacity(0.7),
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
                countryConfig: CountryConfig(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 2, color: const Color(0xFF3f4046)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  flatFlag: true,
                  noFlag: false,
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                validator: (number) {
                  if (number.number.isEmpty) {
                    return "The phone number cannot be left emptyssss";
                  }
                  return null;
                },
                phoneConfig: PhoneConfig(
                  focusedColor: const Color(0xFF6D59BD),
                  enabledColor: const Color(0xFF6D59BD),
                  errorColor: const Color(0xFFFF5494),
                  labelStyle: null,
                  labelText: null,
                  floatingLabelStyle: null,
                  focusNode: null,
                  radius: 8,
                  hintText: "Phone Number",
                  borderWidth: 2,
                  backgroundColor: Colors.transparent,
                  decoration: null,
                  popUpErrorText: true,
                  autoFocus: false,
                  showCursor: false,
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  errorTextMaxLength: 2,
                  errorPadding: const EdgeInsets.only(top: 14),
                  errorStyle: const TextStyle(
                      color: Color(0xFFFF5494), fontSize: 12, height: 1),
                  textStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.5),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () async {
                  sendOtp();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Verify phone number',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String> loadFromJson() async {
    return await rootBundle.loadString('assets/countries/country_list_en.json');
  }
}
