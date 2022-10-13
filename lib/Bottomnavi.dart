import 'package:atm/Home_pages/Home.dart';
import 'package:atm/Home_pages/Profile.dart';
import 'package:atm/Home_pages/Refer.dart';
import 'package:atm/Home_pages/Transaction.dart';
import 'package:atm/Home_pages/withdraw_tab.dart';
import 'package:flutter/material.dart';

class Bottomnavi extends StatefulWidget {
  const Bottomnavi({Key? key}) : super(key: key);

  @override
  State<Bottomnavi> createState() => _BottomnaviState();
}

class _BottomnaviState extends State<Bottomnavi> {
  static List property = [
    const Transaction(),
    const home(),
    const WithdrawTab(),
    const Refer(),
    const Profile(),
  ];

  int selectedindex = 0;

  void ontap(int indax) {
    setState(() {
      selectedindex = indax;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          currentIndex: selectedindex,
          onTap: ontap,
          selectedItemColor: const Color.fromRGBO(63, 81, 181, 1),
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.assignment,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_balance_wallet,
                  size: 30,
                ),
                label: ""),
            // BottomNavigationBarItem(
            // icon: Icon(Icons.card_giftcard_sharp), label: "Refer"),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
          ]),
      body: property.elementAt(selectedindex),
    );
  }
}
