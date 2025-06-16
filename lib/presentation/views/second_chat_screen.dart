import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/presentation/manager/chat_message_provider.dart';
import 'package:chat_app/presentation/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:svg_flutter/svg.dart';
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/const.dart';
import '../manager/background_color_provider.dart';
import '../widgets/camera_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/option_button.dart';
import '../widgets/record_button.dart';

class SecondChatScreen extends StatefulWidget {
  const SecondChatScreen({super.key});

  @override
  State<SecondChatScreen> createState() => _SecondChatScreenState();
}

class _SecondChatScreenState extends State<SecondChatScreen> {
  static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<ChatMessageProvider>(context, listen: false).getMessages();
    });
    Future.delayed(Duration(milliseconds: 100), () {
      Constants.audioPlayer = AudioPlayer();
      Constants.audioRecorder = AudioRecorder();
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Constants.audioPlayer.dispose();
    Constants.audioRecorder.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                padding: EdgeInsets.only(right: 30, left: 30, top: 30),
                height: MediaQuery.of(context).size.height * 0.11,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.purpleColor, AppColors.blueColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            "assets/images/person2.jpg",
                          ),
                          radius: 25,
                        ),
                      ),
                      Text(
                        "Alex",
                        style: TextStyle(
                          fontFamily: "Source Sans Pro",
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.08,
                        width: MediaQuery.of(context).size.width * 0.08,
                        child: ZegoSendCallInvitationButton(
                          margin: EdgeInsets.zero,
                          padding: EdgeInsets.zero,
                          iconSize: Size(MediaQuery.of(context).size.width * 0.08, MediaQuery.of(context).size.width * 0.08),
                          icon: ButtonIcon(
                            icon: SvgPicture.asset(
                              'assets/icons/phone_icon.svg',
                            ),
                          ),
                          isVideoCall: false,
                          resourceID: "chatApp",
                          invitees: [ZegoUIKitUser(id: "123456", name: "Alex")],
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      OptionButton(),
                    ],
                  ),
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
                                        "Maria"
                                    ? true
                                    : false,
                            messageID:
                                chatMessageProvider.chatMessages[index].id,
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  height: MediaQuery.of(context).size.height * 0.1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.purpleColor, AppColors.blueColor],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CameraButton(sender: 'Maria'),
                        CustomTextFormField(
                          controller: controller,
                          sender: 'Maria',
                        ),
                        RecordButton(sender: 'Maria'),
                      ],
                    ),
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
