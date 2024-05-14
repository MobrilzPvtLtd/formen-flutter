// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkError extends StatelessWidget {
  final Function loadData;
  final String message;
  final bool isSmall;

  const NetworkError(
      {required this.loadData, required this.message, this.isSmall = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icon.png",
            package: "flutter_paypal",
            height: 120,
          ),
          SizedBox(
            height: isSmall ? 20 : 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$message",
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF272727),
                      fontWeight: FontWeight.w400)),
              SizedBox(
                width: 5,
              ),
              InkWell(
                onTap: () => loadData(),
                child: Text("Tap to retry".tr,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
