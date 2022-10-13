import 'package:atm/apiservice.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Singup_page extends StatefulWidget {
  const Singup_page({Key? key}) : super(key: key);

  @override
  State<Singup_page> createState() => _Singup_pageState();
}

class _Singup_pageState extends State<Singup_page> {
  late SharedPreferences prefs;
  String prefRegUsername = "";
  String userName = "";
  bool loginLoeader = false;
  Apiservice apiservice = Apiservice();

  TextEditingController Signupfirstname = TextEditingController();
  TextEditingController Signuplastname = TextEditingController();
  TextEditingController Signupemail = TextEditingController();
  TextEditingController Signupphone = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    prefs = await SharedPreferences.getInstance();
    prefRegUsername = prefs.getString('regUsername').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
      body: ListView(children: [
        Container(
          child: Image.asset(
            "assets/Logo_Atm.png",
            height: 300,
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(2, 2),
            //     blurRadius: 12,
            //     color: Color.fromRGBO(0, 0, 0, 0.16),
            //   )
            // ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            color: Colors.white,
          ),
          child: Center(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 40, left: 20),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20, top: 10),
                      child: const Text(
                        "Create an account to continue!",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "First Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: TextField(
                        controller: Signupfirstname,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter your first name',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //second textfield =-=---=-=-----=-=---=---=--=-=-=--=
                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Last Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: TextField(
                        controller: Signuplastname,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter your last name',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //third text field=-=--=-=-=-=--=----=-=-=-=-=-=--=

                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Email",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: TextField(
                        controller: Signupemail,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Enter your email',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //fourth text field=-=-=---==-=-=-=-=--=--=-==-=-=-=-=-

                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(left: 20),
                        child: const Text(
                          "Phone",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: TextField(
                        controller: Signupphone,
                        cursorColor: Colors.black,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.5),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          hintText: 'Phone number',
                          hintStyle: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 50, right: 20, left: 20),
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
                        ),
                        onPressed: () async {
                          await AuthRepository.validateAndGetOTPForNewRegister(
                              context: context,
                              userFirstName: Signupfirstname.text,
                              userLastName: Signuplastname.text,
                              userEmailAddress: Signupemail.text,
                              userPhone: Signupphone.text);
                        },
                        child: const Text(
                          "Sign up",
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "You Already an account?",
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextButton(
                            onPressed: () {
                              PageNavigator.pop(context: context);
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Color.fromRGBO(63, 81, 181, 1),
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  void ToastMsg(String msg, double fontsize, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(msg),
        duration: const Duration(milliseconds: 1500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
