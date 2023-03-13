import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/config.dart';
import '../resources/strings_manager.dart';

class ViewPdfView extends StatelessWidget {
  const ViewPdfView({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  Widget build(BuildContext context) {
    Uri uri = Uri.parse("${Config.baseUrl}/generate-pdf/$uuid");

    debugPrint(uri.toString());

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pdf),
        actions: [
          IconButton(
              onPressed: () async {
                await Share.share(uri.toString());
              },
              icon: const Icon(Icons.share)),
        ],
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: uri,
        ),
        onReceivedServerTrustAuthRequest: (controller, challenge) async {
          return ServerTrustAuthResponse(
            action: ServerTrustAuthResponseAction.PROCEED,
          );
        },
      ),
    );
  }
}
