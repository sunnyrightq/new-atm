import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/repository/profile_repository.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen(
      {Key? key, required this.profileDataModel, required this.isUpdated})
      : super(key: key);

  final ProfileDataModel profileDataModel;
  final Function(bool) isUpdated;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    setData();
    super.initState();
  }

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 45, right: 110),
                              child: IconButton(
                                  onPressed: () {
                                    PageNavigator.pop(context: context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.white,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 20, top: 15),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(right: 240, top: 270),
                        child: const Text(
                          "First Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                          ),
                        )),
                    Container(
                      padding: const EdgeInsets.only(left: 19, right: 19),
                      child: TextFormField(
                        controller: firstNameController,
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
                      height: 15,
                    ),
                    //second textfield =-=---=-=-----=-=---=---=--=-=-=--=
                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(right: 240),
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
                        controller: lastNameController,
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
                      height: 15,
                    ),
                    //third text field=-=--=-=-=-=--=----=-=-=-=-=-=--=

                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(right: 275),
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
                        controller: emailController,
                        cursorColor: Colors.black,
                        readOnly: true,
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
                      height: 15,
                    ),

                    //fourth text field=-=-=---==-=-=-=-=--=--=-==-=-=-=-=-

                    Container(
                        height: 24,
                        margin: const EdgeInsets.only(right: 275),
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
                        controller: phoneController,
                        cursorColor: Colors.black,
                        readOnly: true,
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
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () async {
                        await ProfileRepository.validateAndUpdateProfileData(
                            context: context,
                            userFirstName: firstNameController.text,
                            userLastName: lastNameController.text,
                            isUpdate: widget.isUpdated);
                      },
                      child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(63, 81, 181, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: const Center(
                            child: Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  setData() {
    firstNameController.text =
        widget.profileDataModel.transactionData!.firstName;
    lastNameController.text =
        widget.profileDataModel.transactionData!.userLastName;
    emailController.text = widget.profileDataModel.transactionData!.userEmail;
    phoneController.text =
        widget.profileDataModel.transactionData!.userPhone.replaceAll("-", " ");
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
