import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/cu.dart';

appbar(String title, {actions, titleWidget, bool rounded = true, bottom}) {
  return AppBar(
//      iconTheme: new IconThemeData(color: Colors),
    iconTheme: IconThemeData(color: AppColor.secondaryColor),
//      gradient: LinearGradient(colors: primaryGradientColor),
    centerTitle: true,
    elevation: rounded ? null : 0,
    backgroundColor: AppColor.primaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(rounded ? 20 : 0),
      ),
    ),
    title: titleWidget ??
        Text(
          title,
          style: TextStyle(color: AppColor.textColorDark),
        ),
    actions: actions,
    bottom: bottom, systemOverlayStyle: SystemUiOverlayStyle.dark,
  );
}

AppBar teacherAppBar({
  required String text,
  List<Widget>? actions,
}) {
  return AppBar(
    centerTitle: true,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    elevation: 0,
    backgroundColor: CU.tprimaryColor,
    title: Text(
      text,
      style: const TextStyle(color: Colors.white),
    ),
    actions: actions,
    // systemOverlayStyle: SystemUiOverlayStyle.light,
  );
}
