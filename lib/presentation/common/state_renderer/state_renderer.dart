import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pips/presentation/resources/assets_manager.dart';
import 'package:pips/presentation/resources/strings_manager.dart';

import '../../resources/sizes_manager.dart';

enum StateRendererType {
  // POPUP STATES
  POPUP_LOADING_STATE,
  POPUP_ERROR_STATE,
  POPUP_SUCCESS,
  // FULL SCREEN STATES
  FULL_SCREEN_LOADING_STATE,
  FULL_SCREEN_ERROR_STATE,
  CONTENT_SCREEN_STATE, // THE UI OF THE SCREEN
  EMPTY_SCREEN_STATE // EMPTY VIEW WHEN WE RECEIVE NO DATA FROM API SIDE FOR LIST SCREEN
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer(
      {Key? key,
      required this.stateRendererType,
      String? message,
      String? title,
      this.retryActionFunction})
      : message = message ?? AppStrings.loading,
        title = title ?? AppStrings.empty,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.POPUP_LOADING_STATE:
        return _getPopupDialog(context, [
          _getAnimated(AssetsManager.loadingJson),
        ]);
      case StateRendererType.POPUP_ERROR_STATE:
        return _getPopupDialog(context, [
          _getAnimated(AssetsManager.animErrorJson),
          _getMessage(context, message),
          _getRetryButton(context, AppStrings.tryAgain),
        ]);
      case StateRendererType.POPUP_SUCCESS:
        return _getPopupDialog(
            context, [_getAnimated(AssetsManager.animSuccessJson)]);
      case StateRendererType.FULL_SCREEN_LOADING_STATE:
        return _getItemsInColumn([
          _getAnimated(AssetsManager.loadingJson),
          _getMessage(context, message),
        ]); // TODO: show loading
      case StateRendererType.FULL_SCREEN_ERROR_STATE:
        return _getItemsInColumn([
          _getAnimated(AssetsManager.animErrorJson),
          _getMessage(context, message),
        ]); // TODO: add image, message, retry action
      case StateRendererType.CONTENT_SCREEN_STATE:
        return Container();
      case StateRendererType.EMPTY_SCREEN_STATE:
        return _getItemsInColumn([
          _getAnimated(AssetsManager.animEmptyJson),
          _getMessage(context, message)
        ]); // TODO: add image, message
      default:
        return Container();
    }
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s0_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(AppSize.s14),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26,
                blurRadius: AppSize.s12,
                offset: Offset(AppSize.s0, AppSize.s12))
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getAnimated(String animationName) {
    return SizedBox(
      height: AppSize.s100,
      width: AppSize.s100,
      child: Lottie.asset(animationName),
    );
  }

  Widget _getMessage(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: Text(
          message,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  Widget _getRetryButton(BuildContext context, String buttonTitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.md),
        child: SizedBox(
          width: AppSize.s60,
          child: ElevatedButton(
              onPressed: () {
                if (stateRendererType ==
                    StateRendererType.FULL_SCREEN_ERROR_STATE) {
                  retryActionFunction
                      ?.call(); // to call the API function again to retry
                } else {
                  Navigator.of(context)
                      .pop(); // popup state error so we need to dismiss the dialog
                }
              },
              child: Text(buttonTitle)),
        ),
      ),
    );
  }
}
