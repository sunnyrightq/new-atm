import 'package:atm/repository/referral_repository.dart';
import 'package:flutter/material.dart';

class Refer extends StatefulWidget {
  const Refer({Key? key}) : super(key: key);

  @override
  State<Refer> createState() => _ReferState();
}

class _ReferState extends State<Refer> {
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
                    color: const Color(0xff224389),
                  ),
                ),
                Column(
                  children: [
                    // Container(
                    //   padding: const EdgeInsets.only(top: 60, left: 5),
                    //   alignment: Alignment.centerLeft,
                    //   child: IconButton(
                    //     onPressed: () {},
                    //     icon: const Icon(
                    //       Icons.arrow_back_ios_new,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    SafeArea(
                      child: Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: const Text(
                            "Refer & Earn",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 80, left: 20),
                          child: Image.asset("assets/refer_image1.png",
                              height: 110),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 40, bottom: 20),
                          child: Image.asset("assets/refer_image2.png",
                              height: 85),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 50),
              child: const Text(
                "Refer & Earn",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                "*upto ₹1OOO every month",
                style: TextStyle(
                  color: Color.fromARGB(221, 82, 76, 76),
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
              child: const Text(
                "It is a long estabilshed fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 50),
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => My_profile()));
                  await ReferralRepository.getReferralCode(context: context);
                },
                child: const Text(
                  "INVITE AND EARN",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                )),
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
