import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/chat_box_color_provider.dart';
import '../widgets/change_button.dart';
import '../widgets/custom_title_app_bar.dart';
import '../widgets/test_chat_bubble.dart';

class ChangeChatBoxScreen extends StatefulWidget {
  const ChangeChatBoxScreen({super.key});

  @override
  State<ChangeChatBoxScreen> createState() => _ChangeChatBoxScreenState();
}

class _ChangeChatBoxScreenState extends State<ChangeChatBoxScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/pattern.png',
            fit: BoxFit.cover,
            color: Colors.grey[300],
            width: double.infinity,
            height: double.infinity,
          ),

          Column(
            children: [
              CustomTitleAppBar(
                title: "Change ChatBox",
                hasBackButton: true,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 215,
                  mainAxisSpacing: 20,
                ),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.07),
                            blurRadius: 1.0,
                            spreadRadius: 2.0,
                            offset: Offset(
                              0,
                              2.0,
                            ), // Position of the shadow (x, y)
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child:Consumer<ChatBoxColorProvider>(
                        builder: (context, chatBoxColorProvider, child) {
                          return  Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child:
                                TestChatBubble(color: chatBoxColorProvider.chatBoxColors[index]),
                              ),
                              Consumer<ChatBoxColorProvider>(
                                builder: (context, value, child) {
                                  return ChangeButton(
                                    onTap: () {
                                      value.changeChatBoxColor(chatBoxColorProvider.chatBoxColors[index]);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
