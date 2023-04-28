import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pips/app/config.dart' as LocalConfig;
import 'package:pips/app/dep_injection.dart';
import 'package:pips/common/resources/sizes_manager.dart';
import 'package:pips/common/resources/strings_manager.dart';
import 'package:share_plus/share_plus.dart';
import 'package:universal_platform/universal_platform.dart';

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
  late Uri _uri;
  PDFDocument? _document;

  bool _loadingPdf = true;

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

  Future<void> _loadDocument() async {
    setState(() {
      _loadingPdf = true;
    });

    _document = await PDFDocument.fromURL(_uri.toString());

    setState(() {
      _loadingPdf = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _uri = WebUri("${LocalConfig.Config.baseUrl}/generate-pdf/${widget.uuid}");

    _loadDocument();
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (UniversalPlatform.isAndroid) {
      if (!_loadingPdf) {
        if (_document != null) {
          return PDFViewer(
            document: _document!,
            showPicker: false,
            zoomSteps: 1,
            scrollDirection: Axis.vertical,
          );
        }

        return Center(
          child: Column(
            children: [
              const Text(AppStrings.failedToLoadDocument),
              const SizedBox(
                height: AppSize.md,
              ),
              ElevatedButton(
                onPressed: _loadDocument,
                child: const Text(AppStrings.tryAgain),
              ),
            ],
          ),
        );
      }

      return const Center(child: CircularProgressIndicator());
    }

    return Column(children: <Widget>[
      Expanded(
        child: Stack(
          children: [
            InAppWebView(
              key: _webViewKey,
              initialUrlRequest: URLRequest(url: WebUri(_uri.toString())),
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
                  (InAppWebViewController controller,
                      URLAuthenticationChallenge challenge) async {
                return ServerTrustAuthResponse(
                  action: ServerTrustAuthResponseAction.PROCEED,
                );
              },
            ),
            _progress < 1.0 ? _buildProgressIndicator() : Container(),
          ],
        ),
      ),
    ]);
  }

  Widget _buildProgressIndicator() {
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
