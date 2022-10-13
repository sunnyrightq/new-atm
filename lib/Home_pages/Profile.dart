import 'package:atm/First_pages/Login_page.dart';
import 'package:atm/Profile_page/Banck_Account.dart';
import 'package:atm/Profile_page/Edit_profile.dart';
import 'package:atm/kyc/You_verifyd.dart';
import 'package:atm/kyc/kyc.dart';
import 'package:atm/models/kyc/kyc_status_model.dart';
import 'package:atm/models/profile/profile_data_model.dart';
import 'package:atm/repository/kyc_repository.dart';
import 'package:atm/repository/profile_repository.dart';
import 'package:atm/repository/referral_repository.dart';
import 'package:atm/utils/loading_view.dart';
import 'package:atm/utils/local_storage/shared_preferences.dart';
import 'package:atm/utils/page_navigator.dart';
import 'package:atm/utils/type_strings.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileDataModel? profileDataModel;
  KycStatusModel? kycStatusModel;

  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: profileDataModel == null
          ? const Center(child: LoadingView())
          : SingleChildScrollView(
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
                            // Container(
                            //   alignment: Alignment.centerLeft,
                            //   padding: const EdgeInsets.only(
                            //     top: 50,
                            //   ),
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
                                padding:
                                    const EdgeInsets.only(top: 20, left: 15),
                                child: const Text(
                                  "Setting",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              margin: const EdgeInsets.only(
                                  top: 30, left: 20, right: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 5.0,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 15),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(30),
                                          child: Image.asset(
                                              "assets/children.png",
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 8, right: 10),
                                      child: Text(
                                        "${profileDataModel!.transactionData!.firstName} ${profileDataModel!.transactionData!.userLastName}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          top: 5, right: 10),
                                      child: Text(
                                        profileDataModel!
                                            .transactionData!.userPhone,
                                        style: const TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                      ),
                                    ),
                                    const Divider(
                                      height: 30,
                                      thickness: 0.10,
                                      indent: 8,
                                      endIndent: 8,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      "Invested Balance: ${getINRTypeValue(rupees: double.parse((profileDataModel!.totalCapital ?? 0).toString()))}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Color.fromRGBO(63, 81, 181, 1),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      PageNavigator.pushPage(
                        context: context,
                        page: EditProfileScreen(
                          profileDataModel: profileDataModel!,
                          isUpdated: (v) async {
                            if (v) {
                              await getProfileData();
                              PageNavigator.pop(context: context);
                            }
                          },
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.person,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 10),
                              child: const Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BankAccountScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.account_balance_rounded,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Bank Account",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await ReferralRepository.getReferralCode(
                          context: context);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.reply,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Refer a Friend",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      kycStatusModel =
                          await KYCRepository.getKycStatus(context: context);
                      if (kycStatusModel!.kycStatus == "Approved") {
                        PageNavigator.pushPage(
                          context: context,
                          page: YouVerifiedScreen(
                            status: kycStatusModel!.kycStatus ?? "--",
                          ),
                        );
                      } else if (kycStatusModel!.kycStatus == "Pending") {
                        PageNavigator.pushPage(
                          context: context,
                          page: YouVerifiedScreen(
                            status: kycStatusModel!.kycStatus ?? "--",
                          ),
                        );
                      } else if (kycStatusModel!.kycStatus == "Rejected") {
                        PageNavigator.pushPage(
                            context: context, page: const KYCScreen());
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.newspaper,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "KYC Document",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 80),
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.feed_outlined,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Team and Conditions",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.report,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "About",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      await LocalStorage.clearStorage();
                      PageNavigator.pushAndRemoveUntilPage(
                          context: context, page: const LoginScreen());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 5, right: 5, top: 10),
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 226, 224, 224),
                            blurRadius: 40.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: const Icon(
                              Icons.logout,
                              color: Color.fromRGBO(63, 81, 181, 1),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 15),
                              child: const Text(
                                "Logout",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
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
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await ReferralRepository.getReferralCode(
                            context: context);
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => My_profile()));
                      },
                      child: const Text(
                        "INVITE AND EARN",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  getProfileData() async {
    profileDataModel = await ProfileRepository.getProfileData(context: context);
    changeState();
  }

  void changeState() {
    if (mounted) {
      setState(() {});
    }
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
