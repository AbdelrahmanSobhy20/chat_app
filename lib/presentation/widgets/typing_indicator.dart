import 'package:flutter/material.dart';
import '../../core/utils/app_colors.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 8),
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/person.png"),
          radius: 16,
        ),
        SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Maria",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: "Source Sans Pro",
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  _dot(),
                  SizedBox(width: 8),
                  _dot(),
                  SizedBox(width: 8),
                  _dot(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _dot() => Container(
    width: 15,
    height: 15,
    decoration: BoxDecoration(color: AppColors.lightBlueColor, shape: BoxShape.circle),
  );
}
