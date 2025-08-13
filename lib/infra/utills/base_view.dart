

// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class BaseView<Controller> extends GetView<Controller> {
  BaseView({Key? key}) : super(key: key);
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  Widget body(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: [
          annotatedRegion(context),
          isLoading() ?  LoadingWidget() : const SizedBox(),
        ],
      ),
      onWillPop: () async {
        return onBackPressed();
      },
    );
  }

  Widget annotatedRegion(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor(),
        statusBarIconBrightness: statusBarIconBrightness(),
        statusBarBrightness: statusBarBrightness(),
      ),
      child: Material(
        color: Colors.transparent,
        child: pageScaffold(context),
      ),
    );
  }

  Brightness statusBarBrightness() => Brightness.light;

  Brightness statusBarIconBrightness() =>
      statusBarBrightness() == Brightness.light ? Brightness.dark : Brightness.light;

  Widget pageScaffold(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
      extendBody: extendBody(),
      key: setKey(),
      body: body(context),
      appBar: appBar(),
      drawer: appDrawer(),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget showErrorSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(snackBar);
    });

    return Container();
  }

  void showToast(String message) {}


  bool resizeToAvoidBottomInset() => true;

  bool extendBody() => false;

  Color statusBarColor() => Colors.transparent;

  Widget? bottomNavigationBar() {
    return null;
  }
  PreferredSizeWidget? appBar() {
    return null;
  }

  setKey(){
    return globalKey;
  }

  Widget? appDrawer() {
    return null;
  }

  bool isLoading() {
    return false;
  }

  bool onBackPressed() {
    return true;
  }
}



class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Stack(
        children: <Widget>[
          ModalBarrier(
            dismissible: false,
            color: Colors.grey.withOpacity(.3),
          ),
          const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
