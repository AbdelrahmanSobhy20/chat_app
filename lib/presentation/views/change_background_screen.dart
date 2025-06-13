import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../manager/background_color_provider.dart';
import '../widgets/change_button.dart';
import '../widgets/custom_title_app_bar.dart';

class ChangeBackgroundScreen extends StatefulWidget {
  const ChangeBackgroundScreen({super.key});

  @override
  State<ChangeBackgroundScreen> createState() => _ChangeBackgroundScreenState();
}

class _ChangeBackgroundScreenState extends State<ChangeBackgroundScreen> {
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
                title: "Change Background",
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
                            offset: Offset(0, 2.0),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Consumer<BackgroundColorProvider>(
                        builder: (context, backgroundColorProvider, child) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Image.asset(
                                  backgroundColorProvider.backgrounds[index],
                                  fit: BoxFit.cover,
                                  width: 125,
                                  height: 125,
                                ),
                              ),
                              Consumer<BackgroundColorProvider>(
                                builder: (
                                  context,
                                  backgroundColorProvider,
                                  child,
                                ) {
                                  return ChangeButton(
                                    onTap: () {
                                      backgroundColorProvider
                                          .changeBackgroundColor(
                                            backgroundColorProvider
                                                .backgrounds[index],
                                          );
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        },
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
