import 'package:apay/data/constants/errors_code.dart';
import 'package:apay/data/utils/base_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

import '../../../data/constants/banks_name.dart';
import '../../../data/constants/strings.dart';
import '../../../data/utils/exit_utils.dart';
import '../../themes/colors.dart';
import '../../themes/fonts.dart';

class ErrorWithInstructionPage extends StatefulWidget {
  const ErrorWithInstructionPage({super.key});

  @override
  createState() => _ErrorWithInstructionPageState();
}

class _ErrorWithInstructionPageState extends State<ErrorWithInstructionPage> {
  _ErrorWithInstructionPageState();

  late VideoPlayerController _controller;
  late String bankName;
  late String faqUrl;
  late String faqText;

  @override
  void initState() {
    super.initState();
    try {
      bankName = ModalRoute.of(context)?.settings.arguments as String;

    } catch (e) {
      bankName = BanksName.kaspi.name;
    }

    if (bankName == BanksName.kaspi.name) {
      faqText = forChangeLimitInKaspi();
      faqUrl = StringsBase.currentLang == StringsBase.kz
          ? 'https://static-data.object.pscloud.io/pay-manuals/Kaspi_kaz.mp4'
          : 'https://static-data.object.pscloud.io/pay-manuals/Kaspi_rus.mp4';

    } else {
      faqText = forChangeLimitInHomebank();
      faqUrl = StringsBase.currentLang == StringsBase.kz
          ? 'https://static-data.object.pscloud.io/pay-manuals/Halyk_kaz.mp4'
          : 'https://static-data.object.pscloud.io/pay-manuals/Halyk_rus.mp4';
    }

    _controller = VideoPlayerController.networkUrl(Uri.parse(faqUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });

  }

  @override
  Widget build(BuildContext context) {

    double iconPaddingTop = MediaQuery.of(context).size.height * 0.1;
    double iconSize = MediaQuery.of(context).size.width * 0.35;
    double videoHeight = MediaQuery.of(context).size.width * 0.56;

    const ErrorsCode error = ErrorsCode.error_5999;

    return WillPopScope(
        onWillPop: () {
          exitSdk();
          return Future.value(false);
        },
        child: Scaffold(
          body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
            child: Stack(
              children: <Widget>[
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: iconPaddingTop),
                              SvgPicture.asset(
                                'assets/images/pay_failed.svg',
                                height: iconSize,
                                width: iconSize,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                error.message(),
                                style: Fonts.h3(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                error.description(),
                                style: Fonts.bodyRegular(),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    faqText,
                                    style: Fonts.semiBold(),
                                  ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                height: videoHeight,
                                child: _controller.value.isInitialized
                                    ? GestureDetector(
                                        onTap: () => _controller.value.isPlaying ? _controller.pause() : _controller.play(),
                                        child: Stack(
                                          children: <Widget>[
                                             AspectRatio(
                                                    aspectRatio: _controller.value.aspectRatio,
                                                    child: VideoPlayer(_controller),
                                              ),
                                              _controller.value.isPlaying
                                                    ? const SizedBox()
                                                    : Center(
                                                        child: MaterialButton(
                                                          onPressed: () {
                                                            setState(() { _controller.play(); });
                                                          },
                                                          shape: const CircleBorder(),
                                                          color: ColorsSdk.gray15,
                                                          child: const Padding(
                                                            padding: EdgeInsets.all(10),
                                                            child: Icon(
                                                                Icons.play_arrow,
                                                                color: ColorsSdk.iconInversion),
                                                          ),
                                                      )
                                                )]
                                              ))
                                    : Container()
                              ),
                              const SizedBox(height: 200)
                            ],
                          ))),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              error.clickOnTop(context);
                            },
                            child: Text(
                              error.buttonTop(),
                              style: Fonts.h2().copyWith(color: ColorsSdk.textInversion),
                            )),
                          const SizedBox(height: 16,),
                          TextButton(
                            onPressed: () {
                              error.clickOnBottom(context);
                            },
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                                    (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.5);
                                  }
                                  return ColorsSdk.gray5;
                                })),
                            child: Text(
                              error.buttonBottom(),
                              style: Fonts.h2().copyWith(color: ColorsSdk.mainBrand),
                            )),
                        ]
                    )
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
