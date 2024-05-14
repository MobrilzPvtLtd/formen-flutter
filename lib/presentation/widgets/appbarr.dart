import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

PreferredSize appbarr(context,String title,{Widget? traling}){
  return PreferredSize(preferredSize: const Size.fromHeight(60), child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset("assets/Image/appmainLogo1.png",height: 50,width: 50,),
              const SizedBox(width: 10,),
              Text(title,style: Theme.of(context).textTheme.headlineSmall,),
              const Spacer(),
              traling ?? const SizedBox(),
              const SizedBox(width: 10,),
            ],
          ),
        ],
      ),
    ),
  ));
}