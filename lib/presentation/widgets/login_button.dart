import 'package:flutter/material.dart';

import '../../core/utils/app_colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.onTap});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (onTap),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor, // Shadow color
              blurRadius: 1.0, // Softness of the shadow
              spreadRadius: 2.0, // Size of the shadow
              offset: Offset(0, 2.0), // Position of the shadow (x, y)
            ),
          ],
          gradient: LinearGradient(
            colors: [
              AppColors.purpleColor,
              AppColors.blueColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child:  Center(
          child: Text(
            "Login",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: "Source Sans Pro",
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
