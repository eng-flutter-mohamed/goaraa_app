import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({
    super.key,
    required this.heightCustom,
    this.child, required this.paddingVal,
    
     // متغير child من نوع Widget اختياري
  });

  final double heightCustom;
  final Widget? child; // child يمكن أن يكون null
  final double ? paddingVal;
  @override
  Widget build(BuildContext context) {
    

    return Container(
      padding: EdgeInsets.only(top:paddingVal!),
      height: heightCustom,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 146, 73, 249),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: child, // استخدام child هنا
    );
  }
}
