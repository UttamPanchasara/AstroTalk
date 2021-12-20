import 'package:flutter/material.dart';

import 'base_view.dart';

abstract class BaseStatefulWidgetState<T extends StatefulWidget>
    extends State<T> implements BaseView {
  @override
  void onError(String errorMessageKey) {
    // do nothing
  }

  @override
  void showError(String errorMessage) {
    // SnackBar, To be implemented
  }

  @override
  void hideProgress() {
    // To be implemented
  }

  @override
  void showProgress() {
    // To be implemented
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double screenHeight(BuildContext context,
      {double dividedBy = 1, double reducedBy = 0.0}) {
    return screenSize(context).height / dividedBy;
  }

  double screenWidth(BuildContext context, {double dividedBy = 1}) {
    return screenSize(context).width / dividedBy;
  }

  double screenHeightExcludingToolbar(BuildContext context,
      {double dividedBy = 1}) {
    return screenHeight(context,
        dividedBy: dividedBy, reducedBy: kToolbarHeight);
  }

  double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  void pushAndRemoveUntil(Widget nextPage) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => nextPage), (r) => false);
  }

  void pushAndReplace(Widget nextPage) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => nextPage));
  }

  Future<dynamic> push(Widget nextPage) {
    return Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return nextPage;
        },
        transitionDuration: const Duration(milliseconds: 400),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(curve: Curves.easeIn, parent: animation);
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  void setState(fn) {
    // this is to avoid memory leak,
    // avoid setState() call if already disposed
    if (mounted) {
      super.setState(fn);
    }
  }
}
