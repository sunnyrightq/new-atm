import 'package:atm/First_pages/Singup_page.dart';
import 'package:atm/repository/auth_repository.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(63, 81, 181, 1),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 40),
              child: Image.asset(
                "assets/Logo_Atm.png",
                height: MediaQuery.of(context).size.height / 3,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 3),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 40, left: 20),
                    //padding: EdgeInsets.only(left: MediaQuery.of(context).size.width),
                    child: const Text(
                      "Login",
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
                      "Login to your account?",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 24,
                    margin: const EdgeInsets.only(left: 20),
                    child: const Text(
                      "E-mail",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 19, right: 19),
                    child: TextField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.5),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: 'Enter your E-mail',
                        hintStyle: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  TextButton(
                    onPressed: () async {
                      await AuthRepository.validateAndGetLoginOTP(
                          context: context,
                          userEmailAddress: emailController.text);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(63, 81, 181, 1),
                      ),
                      child: const Center(
                        child: Text(
                          "GET VERIFICATION CODE",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Singup_page(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Color.fromRGBO(63, 81, 181, 1),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
