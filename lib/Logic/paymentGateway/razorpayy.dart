import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayClass {
  Razorpay _razorpay = Razorpay();

  openCheckout(
      {required String key,
        required String amount,
        required String number,
        required String name}) async {
    var options = {
      'key': key,
      'amount': (double.parse(amount.toString()) * 100).toString(),
      'name': name,
      'description': '',
      'timeout': 300,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': number, 'name': name},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  initiateRazorPay(
      {required Function handlePaymentSuccess,
        required Function handlePaymentError,
        required Function handleExternalWallet}) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  desposRazorPay() {
    _razorpay.clear();
  }
}
