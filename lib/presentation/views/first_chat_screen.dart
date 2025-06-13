import 'package:chat_app/presentation/manager/chat_message_provider.dart';
import 'package:chat_app/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../core/model/chat_message.dart';
import '../../core/utils/app_colors.dart';
import '../manager/background_color_provider.dart';
import '../widgets/option_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirstChatScreen extends StatefulWidget {
  const FirstChatScreen({super.key});

  @override
  State<FirstChatScreen> createState() => _FirstChatScreenState();
}

class _FirstChatScreenState extends State<FirstChatScreen> {
  // String? messageText;
  // String? receiver;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void getMessages() async {
    await for (var snapshot in _firestore.collection('messages').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Consumer<BackgroundColorProvider>(
            builder: (context, backgroundColorProvider, child) {
              return Image.asset(
                backgroundColorProvider.selectedBackground,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
            },
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.purpleColor, AppColors.blueColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/person.png"),
                        radius: 20,
                      ),
                    ),
                    Text(
                      'Maria',
                      style: TextStyle(
                        fontFamily: "Source Sans Pro",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset('assets/icons/phone_icon.svg'),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    OptionButton(),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('messages').snapshots(),
                builder: (context, snapshot) {
                  List<ChatMessage> messages = [];
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final messagesData = snapshot.data!.docs;
                  for (var message in messagesData) {
                    messages.add(
                      ChatMessage(
                        text: message.get('text'),
                        receiver: message.get('receiver'),
                        time: DateTime.now(),
                        isDeleted: false,
                        isDeleting: false,
                      ),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Text(
                          messages[index].text,);
                      },
                    ),
                  );
                },
              ),
              Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.purpleColor, AppColors.blueColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/camera_icon.svg'),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(13),
                          ),
                          child: Consumer<ChatMessageProvider>(
                            builder: (context, chatMessageProvider, child) {
                              return TextField(
                                controller: controller,
                                // onChanged: (value) {
                                //   messageText = value;
                                // },
                                onEditingComplete: () {
                                  chatMessageProvider.addMessage(
                                    ChatMessage(
                                      text: controller.text,
                                      time: DateTime.now(),
                                      receiver: "Alex",
                                    ),
                                  );
                                  _firestore.collection('messages').add({
                                    'text': controller.text,
                                    'time': DateTime.now(),
                                    'receiver': "Alex",
                                  });
                                  controller.clear();

                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "write something...",
                                  hintStyle: TextStyle(
                                    fontFamily: "Source Sans Pro",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SvgPicture.asset('assets/icons/record_icon.svg'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/*
Consumer<ChatMessageProvider>(
                builder: (context, chatMessageProvider, child) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: chatMessageProvider.chatMessages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ChatBubble(
                            messageIndex: index,
                            message: chatMessageProvider.chatMessages[index],
                            receiver:
                                chatMessageProvider
                                    .chatMessages[index]
                                    .receiver,
                            isUser:
                                chatMessageProvider
                                            .chatMessages[index]
                                            .receiver ==
                                        "Alex"
                                    ? true
                                    : false,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
 */