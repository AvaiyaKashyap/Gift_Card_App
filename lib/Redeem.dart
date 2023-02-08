import 'package:flutter/material.dart';
class redeemPage extends StatefulWidget {
  const redeemPage({Key? key}) : super(key: key);

  @override
  State<redeemPage> createState() => _redeemPageState();
}

class _redeemPageState extends State<redeemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Redeem"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Send ScreenShot of Points in\nInstagram ID : RandomRealmPlays \n (for verify)"),
      ),
    );
  }
}
