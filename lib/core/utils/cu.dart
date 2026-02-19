import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/local_storage.dart';
import 'package:scholar_clone/presentation/widgets/count_down.dart';
import 'package:scholar_clone/routes/app_routes.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import 'CS.dart';

String appVersionP = "1.1";
String syear = "2021";

class CU {
  static const String appVersion = "1.1";
  static const String iOSAppId = "id1560473797";
  static String email = "jorjoto.social@gmail.com";
  static ProgressDialog? progressDialog;
  static String dateFormate = 'dd-MM-yyyy';
  static String severFormate = 'yyyy-MM-dd';
  static String defaultToken = "52AKs05yGEUjRmck7syo9AQmkdrzfIYigogpyJthG6A=";
  static Color primaryColor = const Color(0xFFf4e022);
  static Color secondaryColor = const Color(0xFF3f98d3);
  static Color greenColor = const Color(0xFF8eba49);
  static Color redColor = const Color(0xFFe52726);
  static Color heliotropeColor = const Color(0xFFb668f3);
  static Color yellowlightColor = const Color(0xFFbab233);
  static Color textColorDark = const Color(0xFF2a3338);
  static Color textColor = const Color(0xFF65665a);
  static Color textColorlight = const Color(0xFF9f9f9f);
  static Color textColorhint = const Color(0xFFdddddd);
  static Color textSubjectName = const Color(0xFFe52826);
  static Color bgColor = const Color(0xFFf5f5f5);
  static Color errorColor = const Color(0xFFd84747);
  static Color pink = const Color(0xFFfd95c6);
  static Color blue = const Color(0xFFad73fb);
  static List<Color> primaryGradientColor = [primaryColor, secondaryColor];

  static List<Color> nAGradientColor = [Colors.blueGrey, Colors.grey];
  //Teacher
  static Color tprimaryColor = Colors.blue;

  static String tcKeySubject = "Subject";
  static String tcKeySelectDepartment = "SelectDepartment";
  static String tcKeyAskQuestions = "AskQuestions";

  static showProgressDialog(BuildContext context) {
    progressDialog = ProgressDialog(context: context);
    progressDialog!.show(
      msg: 'Please Wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      msgColor: Colors.black,
      msgFontSize: 19,
      msgFontWeight: FontWeight.w600,
    );
    progressDialog!.show();
  }

  static hideProgressDialog(context) async {
    log("hideProgressDialog()");
    progressDialog = null;
    Navigator.of(context).pop();
    log("hideProgressDialog() =>");
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
    } on SocketException catch (_) {
      return false;
    }
  }

  static showNoInternetDialog(BuildContext context, body) {
    showDialog(
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
              elevation: 0.0,
              backgroundColor: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: Image.asset(
                                  "assets/no_internet.png",
                                  height: 120,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(top: 8),
                              child: const Text(
                                "No Internet Connection",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 24, left: 20, right: 20),
                              alignment: Alignment.center,
                              child: Text(
                                CS.NoInernetError,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: CU.textColorlight, fontSize: 12),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Material(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    color: CU.secondaryColor,
                                    clipBehavior: Clip.hardEdge,
                                    child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          body();
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 36, vertical: 12),
                                            child: const Text(CS.RETRY,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                )))))
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        barrierDismissible: false,
        context: context);
  }

  static showMaintenanceDiloag(BuildContext context, message, body) {
    showDialog(
        builder: (context) => WillPopScope(
              onWillPop: () {
                SystemNavigator.pop();
                return Future.value(true);
              },
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                insetPadding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 24.0),
                elevation: 0.0,
                backgroundColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 16.0, right: 16.0, bottom: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: Image.asset(
                                    AppImage.warning,
                                    height: 120,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 8),
                                child: const Text(
                                  "Maintenance",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 24),
                                alignment: Alignment.center,
                                child: Text(
                                  message,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CU.textColorlight, fontSize: 12),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Material(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      color: CU.secondaryColor,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            body();
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 36,
                                                      vertical: 12),
                                              child: const Text(CS.RETRY,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0,
                                                  )))))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
        barrierDismissible: false,
        context: context);
  }

  static showToast(BuildContext context, message) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  static showDiloag(BuildContext context, message) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
      elevation: 0.0,
      backgroundColor: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16.0, right: 16.0, bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Image.asset(
                          AppImage.warning,
                          height: 120,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 8, bottom: 24),
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CU.textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Material(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          color: CU.secondaryColor,
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 12),
                              child: const Text(
                                CS.cancel,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  static showUpdateDiloag(
      BuildContext context, updateVersionText, isComplusory) async {
    if (!kReleaseMode) {
      isComplusory = "0";
    } else {
      isComplusory = "0";
    }
    await showDialog(
        builder: (context) => WillPopScope(
            onWillPop: () {
              if (isComplusory == "1") {
                SystemNavigator.pop();
                return Future.value(true);
              } else {
                Navigator.of(context).pop();
                return Future.value(false);
              }
            },
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 24.0),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                        image: AssetImage(AppImage.update))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 120, right: 16.0, bottom: 50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(top: 8),
                                child: const Text(
                                  "What's New",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(top: 8, bottom: 36),
                                alignment: Alignment.center,
                                child: Text(
                                  updateVersionText,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: CU.textColorlight, fontSize: 12),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Material(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                      ),
                                      color: CU.secondaryColor,
                                      clipBehavior: Clip.hardEdge,
                                      child: InkWell(
                                          onTap: () async {
                                            PackageInfo packageInfo =
                                                await PackageInfo
                                                    .fromPlatform();
                                            StoreRedirect.redirect(
                                                androidAppId:
                                                    packageInfo.packageName,
                                                iOSAppId: CU.iOSAppId);
                                          },
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 36,
                                                      vertical: 12),
                                              child: const Text(CS.Update,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.0,
                                                  )))))
                                ],
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            )),
        barrierDismissible: isComplusory == "0",
        context: context);
  }

  static showAuthenticationFail(BuildContext context, message) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.grey[800],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, 15.0),
                    blurRadius: 15.0,
                  ),
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.0, -10.0),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, top: 16.0, right: 16.0, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.asset(
                        "assets/logo.png",
                        height: 100,
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        message,
                        style: TextStyle(color: CU.primaryColor, fontSize: 14),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          child: Container(
                              width: 200,
                              height: 70,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: CU.primaryGradientColor),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF6078ea).withOpacity(.3),
                                    offset: const Offset(0.0, 8.0),
                                    blurRadius: 8.0,
                                  )
                                ],
                              ),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                      onTap: () {
                                        Get.back();
                                        logout(context);
                                      },
                                      child: const Center(
                                          child: Text('OK',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.0,
                                              )))))),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  static Future<String> showPinDiloag(
      BuildContext context, String otp, Function callService) async {
    TextEditingController controller = TextEditingController();
    int pinLength = 6;
    if (!isEmptyOrNull(otp) && otp.length == 6) {
      Future.delayed(const Duration(milliseconds: 200), () {
        controller.text = otp;
      });
    }
    bool hasError = false;
    bool isCall = false;

    return await showDialog(
        builder: (context) => Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 0.0,
              backgroundColor: Colors.grey[800],
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0,
                          ),
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, top: 16.0, right: 16.0, bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Center(
                              child: Image.asset(
                                "assets/logo.png",
                                height: 100,
                              ),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: Text(
                                "Please enter otp received on your mobile",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: CU.primaryColor),
                              ),
                            ),
                            Center(
                              child: PinCodeTextField(
                                autofocus: false,
                                pinBoxHeight: 60,
                                pinBoxRadius: 20,
                                pinBoxColor: Colors.black,
                                highlightColor: Colors.black,
                                defaultBorderColor: CU.primaryColor,
                                hasTextBorderColor: hasError
                                    ? CU.secondaryColor
                                    : CU.primaryColor,
                                maxLength: pinLength,
                                hasError: hasError,
                                maskCharacter: "\u2022",
                                highlight: true,
                                pinBoxWidth:
                                    (MediaQuery.of(context).size.width - 160) /
                                        6,
                                onTextChanged: (text) {
                                  hasError = false;

                                  if (text.length == pinLength && !isCall) {
                                    isCall = true;
                                    Future.delayed(
                                        const Duration(milliseconds: 300), () {
                                      log("****************************************");
                                      log(text);
                                      Navigator.of(context).pop(text);
                                    });
                                  }
                                },
                                controller: controller,
                                wrapAlignment: WrapAlignment.start,
                                pinBoxDecoration: ProvidedPinBoxDecoration
                                    .underlinedPinBoxDecoration,
                                pinTextStyle: const TextStyle(fontSize: 25),
                                pinTextAnimatedSwitcherTransition:
                                    ProvidedPinBoxTextAnimation
                                        .scalingTransition,
                                pinTextAnimatedSwitcherDuration:
                                    const Duration(milliseconds: 300),
                              ),
                            ),
                            Visibility(
                              visible: hasError,
                              child: const Text(
                                "Wrong OTP!",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: CountDownWidget(
                                    startSeconds: 60,
                                    onTick: (timer) {
                                      print(
                                          'onTapCallback：current is ${timer.tick}s');
                                    },
                                    verifyStr: "",
                                    onTapCallback: () {
                                      Navigator.of(context).pop();
                                      callService();
                                      print('send =>');
                                    },
                                    enableTS: const TextStyle(
                                        color: Color(0xff000000)),
                                    disableTS: const TextStyle(
                                        color: Color(0xff999999)),
                                  ),
                                ),
                                InkWell(
                                  child: Container(
                                      width: 200,
                                      height: 70,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: CU.primaryGradientColor),
                                        borderRadius:
                                            BorderRadius.circular(6.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF6078ea)
                                                .withOpacity(.3),
                                            offset: const Offset(0.0, 8.0),
                                            blurRadius: 8.0,
                                          )
                                        ],
                                      ),
                                      child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                              onTap: () {
                                                if (controller.text.length ==
                                                        pinLength &&
                                                    !isCall) {
                                                  isCall = true;
                                                  Future.delayed(
                                                      const Duration(
                                                          milliseconds: 300),
                                                      () {
                                                    log("****************************************");
                                                    log(controller.text);
                                                    Navigator.of(context)
                                                        .pop(controller.text);
                                                  });
                                                } else {
                                                  Fluttertoast.showToast(
                                                      msg: "Please enter otp",
                                                      toastLength:
                                                          Toast.LENGTH_SHORT,
                                                      gravity:
                                                          ToastGravity.BOTTOM,
                                                      backgroundColor:
                                                          CU.primaryColor,
                                                      textColor: Colors.white,
                                                      fontSize: 12.0);
                                                }
                                              },
                                              child: const Center(
                                                  child: Text('OK',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18.0,
                                                      )))))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
        barrierDismissible: false,
        context: context);
  }

  static Widget loadImage(
      {required url,
      double? height,
      double? width,
      isShowLoader = false,
      isShimmerEffect = false,
      color,
      bgcolor,
      boxFit,
      errorIcon}) {
    // url = "";
    return Container(
      color: bgcolor ?? Colors.transparent,
//      color: Colors.transparent,
      child: CachedNetworkImage(
          imageUrl: url,
          height: height,
          width: width,
          fit: boxFit ?? BoxFit.fill,
          color: color,
          placeholder: (context, url) {
            if (isShimmerEffect) {
              return CU.shimmerEffect(height: height!, width: width!);
            } else if (isShowLoader) {
              return CU.getCircularProgressIndicator(
                  height: height!, width: width!);
            } else {
              return placebackground(height: height!, width: width!);
            }
          },
          errorWidget: (context, url, error) => placebackground(
              icon: errorIcon, height: height!, width: width!, color: color)),
    );
  }

  static Widget shimmerEffect({double? height, double? width}) {
    return Shimmer.fromColors(
      baseColor: const Color(0x10000000),
      highlightColor: Colors.white10,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  static Widget placebackground(
      {String? icon,
      double? height,
      double? width,
      Color? logocolor,
      Color? color,
      BoxFit? boxFit}) {
    return Container(
      color: color != null ? bgColor : Colors.transparent,
      height: height,
      width: width,
      child: Stack(
        children: <Widget>[
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 20.0,
                minWidth: 20.0,
                maxHeight: 60.0,
                maxWidth: 60.0,
              ),
              child: Image.asset(
                icon ?? AppImage.logo,
                color: logocolor,
                height: height ?? double.infinity,
                width: width ?? width,
                fit: boxFit,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void logout(context) {
    LocalStorage.clearLocalData();
    Get.offNamedUntil(AppRoutes.splash, (route) => false);

    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const SplashScreen()),
    //     (Route<dynamic> route) => false);
  }

  static Widget getCircularProgressIndicator({double? height, double? width}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      height: height,
      width: width,
      child: const Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }

  static Widget getAppbar(String title,
      {actions, titleWidget, bool rounded = true, bottom}) {
    return AppBar(
//      iconTheme: new IconThemeData(color: Colors),
      iconTheme: IconThemeData(color: CU.secondaryColor),
//      gradient: LinearGradient(colors: primaryGradientColor),
      centerTitle: true,
      elevation: rounded ? null : 0,
      backgroundColor: CU.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(rounded ? 20 : 0),
        ),
      ),
      title: titleWidget ??
          Text(
            title,
            style: TextStyle(color: textColorDark),
          ),
      actions: actions,
      bottom: bottom, systemOverlayStyle: SystemUiOverlayStyle.dark,
    );
  }

  static Widget teacherAppbar(
      {String? title,
      List<Widget>? actions,
      Widget? titleWidget,
      PreferredSizeWidget? bottom,
      Widget? leading}) {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      leading: leading,
      backgroundColor: CU.tprimaryColor,
      title: titleWidget ??
          Text(
            title!,
            style: const TextStyle(color: Colors.white),
          ),
      actions: actions,
      bottom: bottom,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  static Widget nodata(msg) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: Image.asset(
            "assets/nodatafound.png",
            height: 140,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 12),
          alignment: Alignment.center,
          child: Text(
            "Sorry! no data found",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: CU.textColor),
          ),
        ),
      ],
    );
  }

  static Widget getApp(String title) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 0.0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: const Row(
        children: <Widget>[
          Text("adfsdfgsdfg"),
        ],
      ),
    );
  }

  static Future<void> launchURL(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  static void openEmailInquiryApp() {
    openEmailApp(email, "Scholar Clone Inquiry", "");
  }

  static void openEmailFeedBackApp() {
    openEmailApp(email, "Feed Back", "");
  }

  static Future<void> shareImageNText(String shareUrl, String shareText) async {
    // var request = await HttpClient().getUrl(Uri.parse(ShareUrl));
    // var response = await request.close();
    // Uint8List bytes = await consolidateHttpClientResponseBytes(response);
    // await Share.file('Share', 'amlog.jpg', bytes, 'image/*', text: ShareText);
  }

  static void shareText(String shareText) {
    // Share.text('Text', ShareText, 'text/plain');
  }

  static void openEmailApp(email, subject, body) {
    launchURL("mailto:$email?subject=$subject&body=$body" as Uri);
  }

  static Widget getRateDialogue(BuildContext context, String url) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.grey[800],
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.black54,
            height: 175,
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // To make the card compact
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 24),
                  child: Text(
                    "Rate This App",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                Center(
                  child: Container(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => CU.launchURL(url as Uri),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Image.asset(
                              "build/flutter_assets/packages/cupertino_icons/assets/ic_happy.png",
                              width: 75,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => CU.openEmailFeedBackApp(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Image.asset(
                              "build/flutter_assets/packages/cupertino_icons/assets/ic_sad.png",
                              width: 75,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // static void setHomeData(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('HomeData', data);
  // }

  // static Future<Map<String, dynamic>> getHomeData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return jsonDecode(prefs.getString('HomeData') ?? "");
  // }

  static bool isEmptyOrNull(String str) {
    return str.isEmpty;
  }

  static getDeviceState() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo data = await deviceInfoPlugin.androidInfo;
        return <String, dynamic>{
          CS.deviceId: data.id,
          CS.deviceName: data.model,
          CS.deviceVersion: data.version.sdkInt.toString(),
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo data = await deviceInfoPlugin.iosInfo;
        return <String, dynamic>{
          CS.deviceId: data.identifierForVendor,
          CS.deviceName: data.model,
          CS.deviceVersion: data.systemVersion,
        };
      }
    } on PlatformException {
      return <String, dynamic>{'Error:': 'Failed to get platform version.'};
    }
  }

  // static void setToken(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('Token', data);
  // }

  // static Future<String> getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('Token') ?? "";
  //   return CU.isEmptyOrNull(token) ? defaultToken : token;
  // }

  // static void setUsersInfo(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('UsersInfo', data);
  // }

  // static Future<List<dynamic>> getUsersInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String strUserInfo = prefs.getString('UsersInfo') ?? "";
  //   return CU.isEmptyOrNull(strUserInfo) ? null : jsonDecode(strUserInfo);
  // }

  // static void setUserInfo(data) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('UserInfo', data);
  // }

  // static Future<Map<String, dynamic>> getUserInfo() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String strUserInfo = prefs.getString('UserInfo') ?? "";
  //   return CU.isEmptyOrNull(strUserInfo) ? null : jsonDecode(strUserInfo);
  // }

  static bool isValidateEmail(String value) {
    String p =
        "[a-zA-Z0-9+._%-+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";
    RegExp regExp = RegExp(p);

    if (regExp.hasMatch(value)) {
      return true;
    }
    return false;
  }

  static bool isImage(String url) {
    if (isEmptyOrNull(url)) return false;
    String ex = CU.getFileExtensionOfURL(url).toLowerCase();
    return ex == "jpg" || ex == "png" || ex == "jepg";
  }

  static String getFileNameOfURL(String url) {
    return url.substring(url.lastIndexOf("/") + 1);
  }

  static String getFileExtensionOfURL(String url) {
    return url.substring(url.lastIndexOf(".") + 1);
  }

  static getNodataDesign({msg = "Sorry! no data found"}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              AppImage.nodatafound,
              height: 140,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 12),
            alignment: Alignment.center,
            child: Text(
              msg,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: CU.textColor),
            ),
          ),
        ],
      ),
    );
  }
}

List<Color> colorsList = [
  CU.primaryColor,
  CU.secondaryColor,
  Colors.orange,
  CU.heliotropeColor,
  CU.yellowlightColor
];
String packageName = "";
String buildNumber = "";
String shareMessage =
    "Hi, i'm recommending you User the School Online Education"; //EDUCATION
String shareAppUrl =
    "https://play.google.com/store/apps/details?id=com.dnk.triz&hl=en_IN";
FirebaseMessaging? fcm;
