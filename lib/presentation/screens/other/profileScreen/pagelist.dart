import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class Loream extends StatefulWidget {
  String title;
  String discription;
  Loream({Key? key,required this.title,required this.discription}) : super(key: key);
  @override
  State<Loream> createState() => _LoreamState();
}

class _LoreamState extends State<Loream> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).indicatorColor,
          ),
        ),
        title: Text(
         widget.title,
          style: Theme.of(context).textTheme.bodyLarge
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height / 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 20),
                child: Column(children: [
                  (widget.discription.isNotEmpty)
                      ? HtmlWidget(
                    widget.discription,
                    textStyle: TextStyle(
                        color: Theme.of(context).indicatorColor,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        fontFamily: 'Gilroy Normal'),
                  )
                      : Text(
                    "",
                    style: TextStyle(
                        color: Theme.of(context).indicatorColor,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        fontFamily: 'Gilroy Normal'),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
