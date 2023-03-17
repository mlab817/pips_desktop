import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pips/app/dep_injection.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../app/config.dart';
import '../resources/sizes_manager.dart';
import '../resources/strings_manager.dart';

class ViewPdfView extends StatefulWidget {
  const ViewPdfView({Key? key, required this.uuid}) : super(key: key);

  final String uuid;

  @override
  State<ViewPdfView> createState() => _ViewPdfViewState();
}

class _ViewPdfViewState extends State<ViewPdfView> {
  final Dio _dio = instance<Dio>();
  final GlobalKey _webViewKey = GlobalKey();
  InAppWebViewController? _controller;
  double _progress = 0;
  Uri? _uri;

  // download the file
  Future<String> _downloadFile() async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/profile-${widget.uuid}.pdf';
    final originalUrl = await _controller?.getOriginalUrl();

    if (originalUrl != null) {
      await _dio.download(originalUrl.toString(), filePath);
    } else {
      await _dio.download(_uri.toString(), filePath);
    }
    return filePath;
  }

  Future<void> _shareFile() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            widthFactor: 0.5,
            heightFactor: 0.5,
            child: CircularProgressIndicator(),
          );
        });

    final filePath = await _downloadFile();

    List<XFile> files = [];

    final fileToShare = XFile(filePath);

    files.add(fileToShare);

    if (mounted) Navigator.pop(context);

    await Share.shareXFiles(
      files,
      subject: 'Share PDF',
    );
  }

  Future<void> _initializeWebView() async {
    await _controller?.loadUrl(urlRequest: URLRequest(url: _uri!));
  }

  @override
  void initState() {
    super.initState();

    _uri = Uri.parse("${Config.baseUrl}/generate-pdf/${widget.uuid}");

    Future.delayed(Duration.zero, () {
      _initializeWebView();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.pdf),
        actions: [
          IconButton(
            onPressed: _shareFile,
            icon: Icon(UniversalPlatform.isAndroid
                ? Icons.share
                : CupertinoIcons.share),
          ),
        ],
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              InAppWebView(
                key: _webViewKey,
                initialUrlRequest: URLRequest(
                  url: _uri,
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    useOnLoadResource: true,
                    // useShouldOverrideUrlLoading: true,
                  ),
                ),
                // shouldOverrideUrlLoading: (controller, navigationAction) async {
                //   return NavigationActionPolicy.ALLOW;
                // },
                onWebViewCreated: (controller) {
                  _controller = controller;
                },
                onProgressChanged: (controller, progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onReceivedServerTrustAuthRequest:
                    (controller, challenge) async {
                  return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED,
                  );
                },
              ),
              _progress < 1.0 ? _buildProgressIndicator() : Container(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildProgressIndicator() {
    debugPrint(_progress.toString());
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: LinearProgressIndicator(
          value: _progress,
        ),
      ),
    );
  }
}
