import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../data/constants/routes.dart';
import '../../../data/utils/logger.dart';
import '../../ui_components/circular_progress_bar.dart';
import '../dialogs/dialog_exit.dart';
import '../error/error_util.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewPage> {
  _WebViewContainerState();
  bool _isLoading = true;
  bool _isRetry = false;
  String? _action;

  @override
  Widget build(BuildContext context) {
    final Map<String, String?>? data = ModalRoute.of(context)?.settings.arguments as Map<String, String?>?;
    _action = data?['action'];
    _isRetry = data?['is_retry'] == 'true' ? true : false;

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {
            LoggerAirba.log('onPageStarted $url}');
          },
          onPageFinished: (String url) {
            if (_isLoading) {
              setState(() {
                _isLoading = false;
              });
            }

            LoggerAirba.log('onPageFinished $url}');
          },
          onWebResourceError: (WebResourceError error) {
            LoggerAirba.log('3D secure status error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {

            if (request.url.contains('status=auth')
            || request.url.contains('status=success')) {
              LoggerAirba.log('Status success');
              Navigator.pushNamed(
                context,
                routesSuccess,
              );

            } else if (request.url.contains('status=error')) {
              LoggerAirba.log('3D secure status error}');
              try {
                var splitted = request.url.split(RegExp('&'));
                var result = splitted.firstWhere((element) => element.contains('errorCode'));
                var resultSplitted = result.split(RegExp('='));
                openErrorPageWithCondition(
                    int
                        .parse(resultSplitted[1]
                        .replaceAll('errorMsg', '')//todo временный костыль на период, пока не будет исправлено на бэке
                    ),
                    context,
                    '',
                    _isRetry
                ); //todo
              } catch (e) {
                LoggerAirba.log('Parsing error: $e');
                openErrorPageWithCondition(0, context, null, false);
              }
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_action ?? ''));

    return WillPopScope(
        onWillPop: () {
          showDialog<void>(
            context: context,
            builder: (_) => initDialogExit(context),
          );
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                if (kDebugMode) //в РЕЛИЗНОЙ сборке этот вариант вызывает черный экран
                  Expanded(
                      child: WebViewWidget(
                        controller: controller,
                      )),
                if (!kDebugMode) // в ДЕБАГ сборке этот вариант вызывает черный экран
                  WebViewWidget(controller: controller),

                _isLoading ? const Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ProgressDialogPrimary()) : const SizedBox()
              ],
            )));
  }
}