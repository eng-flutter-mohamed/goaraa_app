import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Containarhomecust extends StatelessWidget {
  const Containarhomecust(
      {super.key, this.ImageHome, required this.laboleHome});
  final AssetImage? ImageHome;
  final String laboleHome;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffd1c4e9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 4,
            child: SizedBox(
              child: CircleAvatar(
                backgroundImage: ImageHome,
                radius: 500.w,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              laboleHome.tr,
              style:  TextStyle(
                color: Colors.white,
                fontSize: 20.w,
              ),
              maxLines: 1,
                overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
