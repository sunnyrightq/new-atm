import 'dart:io';

import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/show_logs.dart';
import 'package:atm/utils/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class KYCScreen extends StatefulWidget {
  const KYCScreen({Key? key}) : super(key: key);

  @override
  State<KYCScreen> createState() => _KYCScreenState();
}

class _KYCScreenState extends State<KYCScreen> {
  int _value = 0;
  File? fontPicture;
  File? backPicture;
  final TextEditingController aadharCardController = TextEditingController();

  Future<void> selectFontImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      fontPicture = File(image.path);
      showLogs(message: "USER PICTURE :: $fontPicture");
    }
    setState(() {});
  }

  Future<void> selectBackImage() async {
    ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      backPicture = File(image.path);
      showLogs(message: "USER PICTURE :: $backPicture");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.only(top: 50, left: 5),
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          onPressed: () {
                            PageNavigator.pop(context: context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10, left: 20),
                        child: const Text(
                          "KYC",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            right: 15, bottom: 10, top: 15, left: 15),
                        margin:
                            const EdgeInsets.only(left: 15, right: 15, top: 40),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 226, 224, 224),
                              blurRadius: 5.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Choose Document type",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Radio(
                                    activeColor:
                                        const Color.fromRGBO(63, 81, 181, 1),
                                    value: 1,
                                    groupValue: _value,
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value as int;
                                      });
                                    }),
                                const Text(
                                  "Aadhar Card",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 25,
                                ),
                                Radio(
                                  activeColor:
                                      const Color.fromRGBO(63, 81, 181, 1),
                                  value: 2,
                                  groupValue: _value,
                                  onChanged: (value) {
                                    setState(
                                      () {
                                        _value = value as int;
                                      },
                                    );
                                  },
                                ),
                                const Text(
                                  "Pan Card",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 24,
              margin: const EdgeInsets.only(
                left: 20,
                top: 10,
              ),
              child: const Text(
                "Document Number",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 19, right: 19),
              child: TextFormField(
                controller: aadharCardController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(63, 81, 181, 1), width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(63, 81, 181, 1), width: 1.5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  hintText: 'Enter document number',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 226, 224, 224),
                      blurRadius: 5.0,
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  const Text(
                    "Upload ID Proof",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const Text(
                    "Lorem Ipsumb is simply dummy text of tha printing and typesetting industry.",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          image: fontPicture != null
                              ? DecorationImage(
                                  image: FileImage(fontPicture!),
                                )
                              : null,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 120,
                              child: IconButton(
                                onPressed: selectFontImage,
                                icon: const Icon(
                                  Icons.camera_enhance_outlined,
                                  size: 40,
                                  color: Color.fromRGBO(63, 81, 181, 1),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                "Front",
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          image: backPicture != null
                              ? DecorationImage(
                                  image: FileImage(backPicture!),
                                )
                              : null,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              width: 120,
                              child: IconButton(
                                  onPressed: selectBackImage,
                                  icon: const Icon(
                                    Icons.camera_enhance_outlined,
                                    size: 40,
                                    color: Color.fromRGBO(63, 81, 181, 1),
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: const Text(
                                "Back",
                                style: TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 50),
                width: 320,
                height: 45,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color(0xff224389),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    if (_value == 0) {
                      showToast(
                          context: context,
                          msg: "Please select document type.",
                          isError: true);
                    } else if (aadharCardController.text.isEmpty) {
                      showToast(
                          context: context,
                          msg: "Please enter valid document number.",
                          isError: true);
                    } else if (_value == 1 && fontPicture == null) {
                      showToast(
                          context: context,
                          msg: "Please select aadhar card font image.",
                          isError: true);
                    } else if (_value == 1 && backPicture == null) {
                      showToast(
                          context: context,
                          msg: "Please select aadhar card back image.",
                          isError: true);
                    } else if (_value == 2 && fontPicture == null) {
                      showToast(
                          context: context,
                          msg: "Please select pan card image.",
                          isError: true);
                    } else {
                      await KYCRepository.updateKYC(
                        isPanCard: _value == 2,
                        context: context,
                        aadharCardNumber: aadharCardController.text,
                        aadharCardFontImage: fontPicture,
                        aadharCardBackImage: backPicture,
                        panCardImage: fontPicture,
                      );
                    }
                  },
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
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
