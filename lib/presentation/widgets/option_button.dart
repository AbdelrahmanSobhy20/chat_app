import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../manager/chat_message_provider.dart';
import '../views/change_background_screen.dart';
import '../views/change_chat_box_screen.dart';
import '../views/home_screen.dart';

class OptionButton extends StatefulWidget {
  const OptionButton({super.key});

  @override
  State<OptionButton> createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton> {
  @override
  Widget build(BuildContext context) {
    return
      Consumer<ChatMessageProvider>(builder: (context, chatMessageProvider, child) {
        return GestureDetector(
          onTapDown: (TapDownDetails details) async {
            final selected = await showMenu(
              context: context,
              position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                0,
                0,
              ),
              items: [
                PopupMenuItem(
                  value: 'Change Background',
                  child: Text('Change Background'),
                ),
                PopupMenuItem(
                  value: 'Change Chat Box',
                  child: Text('Change Chat Box'),
                ),
                PopupMenuItem(value: 'Delete Chat', child: Text('Delete Chat')),
              ],
            );

            if (selected == 'Change Background') {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangeBackgroundScreen()),
              );
            } else if (selected == 'Change Chat Box') {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ChangeChatBoxScreen()),
              );
            } else if (selected == 'Delete Chat') {
              setState(() {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
                chatMessageProvider.chatMessages.clear();
              });
            }
          },
          child: SvgPicture.asset('assets/icons/options_icon.svg'),
        );
      });

  }
}
