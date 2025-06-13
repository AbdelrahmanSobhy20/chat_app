import 'package:flutter/material.dart';

class TestChatBubble extends StatelessWidget {
  const TestChatBubble({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.24,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(
        vertical:  35,
        horizontal: 12 ,
      ),
      constraints: BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: color,
        borderRadius:
       BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        )

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Hi",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
