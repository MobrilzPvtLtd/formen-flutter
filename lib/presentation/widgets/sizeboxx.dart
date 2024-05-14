import 'package:flutter/material.dart';

class SizBoxH extends StatelessWidget {
  final double size;
  const SizBoxH({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * size,
    );
  }
}

class SizBoxW extends StatelessWidget {
  final double size;
  const SizBoxW({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * size,
    );
  }
}
