import 'package:flutter/material.dart';

class Customcolumn extends StatelessWidget {
  const Customcolumn(
      {super.key,
      required this.paddingVal,
      this.title,
      this.subTitle,
      this.logoImage,
      this.chaled,
      required this.CustCross,
      required this.CustMain,
      required this.flex});

  final double paddingVal;
  final int flex;
  final String? title;
  final String? subTitle;
  final Widget? chaled;
  final Widget? logoImage;
  final MainAxisAlignment CustMain;
  final CrossAxisAlignment CustCross;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingVal),
      child: Column(
        mainAxisAlignment: CustMain,
        crossAxisAlignment: CustCross,
        children: [
          Expanded(
            flex: flex,
            child: Center(
              child: logoImage,
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(child: chaled),
          ),
       
        ],
      ),
    );
  }
}
