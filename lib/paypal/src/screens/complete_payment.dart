// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../PaypalServices.dart';
import '../errors/network_error.dart';

class CompletePayment extends StatefulWidget {
  final Function onSuccess, onCancel, onError;
  final PaypalServices services;
  final String url, executeUrl, accessToken;
  const CompletePayment({
    super.key,
    required this.onSuccess,
    required this.onError,
    required this.onCancel,
    required this.services,
    required this.url,
    required this.executeUrl,
    required this.accessToken,
  });

  @override
  _CompletePaymentState createState() => _CompletePaymentState();
}

class _CompletePaymentState extends State<CompletePayment> {
  bool loading = true;
  bool loadingError = false;

  complete() async {
    final uri = Uri.parse(widget.url);
    final payerID = uri.queryParameters['PayerID'];
    if (payerID != null) {
      Map params = {
        "payerID": payerID,
        "paymentId": uri.queryParameters['paymentId'],
        "token": uri.queryParameters['token'],
      };
      setState(() {
        loading = true;
        loadingError = false;
      });

      Map resp = await widget.services
          .executePayment(widget.executeUrl, payerID, widget.accessToken);
      if (resp['error'] == false) {
        params['status'] = 'success';
        params['data'] = resp['data'];
        await widget.onSuccess(params);
        setState(() {
          loading = false;
          loadingError = false;
        });
        Navigator.pop(context);
      } else {
        if (resp['exception'] != null && resp['exception'] == true) {
          widget.onError({"message": resp['message']});
          setState(() {
            loading = false;
            loadingError = true;
          });
        } else {
          await widget.onError(resp['data']);
          Navigator.of(context).pop();
        }
      }
      //return NavigationDecision.prevent;
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    super.initState();
    complete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: loading
            ? Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SpinKitFadingCube(
                        color: Color(0xFFEB920D),
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
            : loadingError
                ? Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: NetworkError(
                              loadData: complete,
                              message: "Something went wrong,".tr),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text("Payment Completed".tr),
                  ),
      ),
    );
  }
}
