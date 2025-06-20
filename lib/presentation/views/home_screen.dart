import 'package:audioplayers/audioplayers.dart';
import 'package:chat_app/presentation/views/second_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

import '../../core/utils/const.dart';
import '../manager/background_color_provider.dart';
import '../widgets/custom_title_app_bar.dart';
import 'first_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
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
              CustomTitleAppBar(title: 'Messenger'),
              Expanded(
                child: ListView.builder(
                  itemCount: Constants.chatName.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        index == 0
                            ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FirstChatScreen(),
                              ),
                            )
                            : Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SecondChatScreen(),
                              ),
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(Constants.chatImage[index]),
                                radius: 30,
                              ),
                            ),
                            Text(
                              Constants.chatName[index],
                              style: TextStyle(
                                fontFamily: "Source Sans Pro",
                                fontSize: 25,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
