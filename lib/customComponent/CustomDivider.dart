import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class Customdivider extends StatelessWidget {
  const Customdivider({super.key, required this.padding});
final double padding;
  @override
  Widget build(BuildContext context) {
    
   return  Padding(
     padding: EdgeInsets.symmetric(horizontal: padding),
     child: Row(children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('OR'.tr,style: TextStyle(fontSize: 11.sp),),
                          
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                      ]),
   );
  }
  
}