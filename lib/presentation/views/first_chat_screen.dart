import 'package:chat_app/presentation/manager/chat_message_provider.dart';
import 'package:chat_app/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../core/utils/app_colors.dart';
import '../manager/background_color_provider.dart';
import '../widgets/camera_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/option_button.dart';
import '../widgets/record_button.dart';

class FirstChatScreen extends StatefulWidget {
  const FirstChatScreen({super.key});

  @override
  State<FirstChatScreen> createState() => _FirstChatScreenState();
}

class _FirstChatScreenState extends State<FirstChatScreen> {
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
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
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
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/images/person.png"),
                        radius: 25,
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
                            sender:
                                chatMessageProvider.chatMessages[index].sender,
                            isUser:
                                chatMessageProvider
                                            .chatMessages[index]
                                            .sender ==
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
              Form(
                key: formKey,
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  height: MediaQuery.of(context).size.height * 0.1,
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
                      CameraButton(sender: 'Alex'),
                      CustomTextFormField(
                        controller: controller,
                        sender: 'Alex',
                      ),
                      RecordButton(sender: 'Alex'),
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
