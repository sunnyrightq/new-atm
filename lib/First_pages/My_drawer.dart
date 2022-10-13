import 'package:flutter/material.dart';

class my_drawer extends StatefulWidget {
  my_drawer({Key? key}) : super(key: key);

  @override
  State<my_drawer> createState() => _my_drawerState();
}

class _my_drawerState extends State<my_drawer> {
  @override
  Widget build(BuildContext context) {
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Color.fromRGBO(228, 230, 234, 1),
      ),
      margin: EdgeInsets.only(top: 50),
      accountName: Text(
        "User Name",
        style: TextStyle(
          fontSize: 18,
          color: Color.fromRGBO(63, 81, 181, 1),
        ),
      ),
      accountEmail: Text(""),
      currentAccountPicture: CircleAvatar(
        child: ClipOval(
          child: Image.asset("assets/children.png"),
        ),
      ),
    );
  }
}
