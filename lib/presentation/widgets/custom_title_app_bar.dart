import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

import '../../core/utils/app_colors.dart';

class CustomTitleAppBar extends StatelessWidget {
  const CustomTitleAppBar({
    super.key,
    required this.title,
    this.hasBackButton = false,
  });

  final String title;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.purpleColor, AppColors.blueColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child:
          hasBackButton
              ? Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: MediaQuery.of(context).size.width * 0.25,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child:SvgPicture.asset("assets/icons/back_arrow_icon.svg",
                        height: 20,),
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: "Source Sans Pro",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
              : Center(
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: "Source Sans Pro",
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
    );
  }
}
