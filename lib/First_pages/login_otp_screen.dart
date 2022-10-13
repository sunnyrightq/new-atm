import 'dart:async';

import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Home_pages/CustomShape.dart';

class LoginOTPScreen extends StatefulWidget {
  const LoginOTPScreen({Key? key, required this.email}) : super(key: key);

  final String email;

  @override
  State<LoginOTPScreen> createState() => _LoginOTPScreenState();
}

class _LoginOTPScreenState extends State<LoginOTPScreen> {
  final TextEditingController otpController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomShape(),
                  child: Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: const Color.fromRGBO(63, 81, 181, 1),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        top: 40,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: const Text(
                        "Verify Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: const Text(
                        "Enter Code that we have sent to your email",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: Text(
                        widget.email,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
              child: PinCodeTextField(
                appContext: context,
                autoFocus: true,
                length: 6,
                obscureText: true,
                obscuringCharacter: '*',
                blinkWhenObscuring: true,
                animationType: AnimationType.scale,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                autoDismissKeyboard: true,
                autoDisposeControllers: true,
                autoUnfocus: true,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                ),
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: false,
                enablePinAutofill: true,
                errorAnimationController: errorController,
                controller: otpController,
                keyboardType: TextInputType.number,
                onCompleted: (v) {},
                onChanged: (value) {},
                beforeTextPaste: (text) {
                  return true;
                },
              )),
          const SizedBox(
            height: 60,
          ),
          TextButton(
              onPressed: () async {
                await AuthRepository.validateAndGetLoginOTP(
                    context: context, userEmailAddress: widget.email);
              },
              child: const Text(
                "Resend Code",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color.fromRGBO(63, 81, 181, 1),
                ),
              )),
          const SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 320,
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  const Color.fromRGBO(63, 81, 181, 1),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
              onPressed: () async {
                if (otpController.text.isEmpty) {
                  showToast(context: context, msg: "Enter OTP!");
                } else if (otpController.text.length != 6) {
                  showToast(context: context, msg: "Enter valid OTP!");
                } else {
                  await AuthRepository.login(
                      context: context,
                      userEmailAddress: widget.email,
                      otp: otpController.text);
                }
              },
              child: const Text(
                "VERIFY",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
