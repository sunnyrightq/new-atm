import 'package:atm/Bottomnavi.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class YouVerifiedScreen extends StatefulWidget {
  const YouVerifiedScreen({Key? key, this.status}) : super(key: key);
  final String? status;

  @override
  State<YouVerifiedScreen> createState() => _YouVerifiedScreenState();
}

class _YouVerifiedScreenState extends State<YouVerifiedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      padding: const EdgeInsets.only(top: 70, left: 20),
                      child: Text(
                        "You're ${widget.status}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 30),
              child: Text(
                "You're ${widget.status}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: Text(
                "Your KYC have been ${widget.status} and you can invest ATM",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 120),
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
              onPressed: () {
                PageNavigator.pushAndRemoveUntilPage(
                  context: context,
                  page: const Bottomnavi(),
                );
              },
              child: const Text(
                "CONTINUE",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
