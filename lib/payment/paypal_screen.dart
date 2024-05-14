// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_string_interpolations, avoid_print

import 'package:dating/core/config.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../paypal/flutter_paypal.dart';

paypalPayment(
    {required String amt,
      required String clientId,
      required String secretKey,
      var function,
      context
    }) {
  Navigator.pop(context);
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) {
        print('++++++++++++++clintid:---${clientId}');
        print('--------------secretekey:----${secretKey}');
        return UsePaypal(
          sandboxMode: true,
          clientId:
          "${clientId}",
          secretKey:
          "${secretKey}",
          returnURL:
          "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token=EC-35S7886705514393E",
          cancelURL: "${Config.baseUrl}paypal/cancle.php",
          transactions: [
            {
              "amount": {
                "total": amt,
                "currency": "USD",
                "details": {
                  "subtotal": amt,
                  "shipping": '0',
                  "shipping_discount": 0
                }
              },
              "description": "The payment transaction description.",
              "item_list": {
                "items": [
                  {
                    "name": "A demo product",
                    "quantity": 1,
                    "price": amt,
                    "currency": "USD"
                  }
                ],
              }
            }
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) {
            // Get.back();
            function(params);
            Fluttertoast.showToast(msg: 'SUCCESS PAYMENT : $params'.tr,timeInSecForIosWeb: 4);
          },
          onError: (error) {
            Fluttertoast.showToast(msg: error.toString(),timeInSecForIosWeb: 4);
          },
          onCancel: (params) {
            Fluttertoast.showToast(msg: params.toString(),timeInSecForIosWeb: 4);
          },
        );
      },
    ),
  );
}
