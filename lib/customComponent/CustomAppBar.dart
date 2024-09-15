import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      title: Center(
        child: ClipOval(
          child: Image.asset(
            "assets/ic_logo_border.png",
            height: 50,
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 146, 73, 249),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
 
}
