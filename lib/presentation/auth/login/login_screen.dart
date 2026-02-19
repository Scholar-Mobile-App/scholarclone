import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';

import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () {
            FocusScope.of(context).unfocus();
            if (_controller.isPasswordScreen.value) {
              _controller.isPasswordScreen.value = false;

              return Future.value(false);
            } else {
              SystemNavigator.pop();
              return Future.value(true);
            }
          },
          child: SingleChildScrollView(
            child: SizedBox(
              height: Get.height,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(AppImage.loginBg),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: Get.height * 0.55,
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(80)),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Visibility(
                      visible: _controller.isPasswordScreen.value,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top, left: 4),
                        child: Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: AppColor.secondaryColor,
                                size: 30,
                              ),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                _controller.isPasswordScreen.value = false;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          const Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                            ),
                          ),
                          Card(
                            elevation: 2,
                            margin: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 24, 16, 2),
                                        child: Text(
                                          _controller.isPasswordScreen.value
                                              ? "OTP"
                                              : "Mobile Number",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: AppColor.textColorDark,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            16, 2, 16, 8),
                                        child: Text(
                                          _controller.isPasswordScreen.value
                                              ? "Please enter your OTP"
                                              : "Please enter your 10 digit mobile number",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: AppColor.textColorlight,
                                          ),
                                        ),
                                      ),
                                      if (!_controller.isPasswordScreen.value)
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              16, 2, 16, 8),
                                          child: textField(
                                              title: "Select To Login",
                                              list: [
                                                "Student/Parents",
                                                "Teacher/Staff",
                                                "Admin/Trustee/Principal"
                                              ],
                                              isdropDown: true,
                                              intialValue: _controller
                                                  .selectedLogin.value,
                                              onChanged: (value) {
                                                _controller.selectedLogin
                                                    .value = value!;
                                              }),
                                        ),
                                      _controller.isPasswordScreen.value
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12, left: 8, top: 12),
                                              child: TextField(
                                                autofocus: false,
                                                inputFormatters: <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(
                                                      6),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                onChanged: (val) {
                                                  _controller
                                                      .passwordError.value = "";
                                                },
                                                controller:
                                                    _controller.txtPassword,
                                                obscureText: !_controller
                                                    .passwordVisible.value,
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: AppColor.textColor,
                                                    fontSize: 22),
                                                decoration: InputDecoration(
                                                  hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColor
                                                          .textColorhint,
                                                      fontSize: 22),
                                                  hintText: '000000',
                                                  errorText: _controller
                                                      .passwordError.value,
                                                  errorMaxLines: 10,
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 12,
                                                  left: 8,
                                                  top: 12,
                                                  right: 8),
                                              child: TextField(
                                                onChanged: (text) {
                                                  _controller.txtMobileError
                                                      .value = "";
                                                },
                                                controller:
                                                    _controller.txtMobile,
                                                keyboardType:
                                                    TextInputType.number,
                                                inputFormatters: <TextInputFormatter>[
                                                  LengthLimitingTextInputFormatter(
                                                      10),
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                style: TextStyle(
                                                  height: 1.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColor.textColor,
                                                  fontSize: 22,
                                                ),
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIcon: _controller
                                                          .isCallChkMobile.value
                                                      ? Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                            left: 16,
                                                            bottom: 12,
                                                            right: 12,
                                                          ),
                                                          child:
                                                              const CircularProgressIndicator(),
                                                        )
                                                      : null,
                                                  hintStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        AppColor.textColorhint,
                                                    fontSize: 22,
                                                  ),
                                                  hintText: '0000000000',
                                                  errorText: null,
                                                  errorMaxLines: 10,
                                                ),
                                              ),
                                            ),
                                      if (_controller.txtMobileError.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                            _controller.txtMobileError.value,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, bottom: 36),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  left: 30, right: 15),
                                              child: Material(
                                                color: AppColor.secondaryColor,
                                                elevation: 4.0,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                clipBehavior: Clip.hardEdge,
                                                child: InkWell(
                                                  onTap: () {
                                                    if (_controller
                                                        .isPasswordScreen
                                                        .value) {
                                                      if (_controller
                                                          .isValidated()) {
                                                        _controller.verifyOTP();
                                                      }
                                                    } else {
                                                      _controller.sendOTP(
                                                          _controller
                                                              .txtMobile.text);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 32),
                                                    child: Center(
                                                      child:
                                                          _controller.isLoading
                                                                  .value
                                                              ? const Center(
                                                                  child: CircularProgressIndicator
                                                                      .adaptive(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  _controller.selectedLogin.value ==
                                                                              "Teacher" ||
                                                                          _controller.selectedLogin.value ==
                                                                              "Admin"
                                                                      ? "Login"
                                                                      : _controller
                                                                              .isPasswordScreen
                                                                              .value
                                                                          ? "Login"
                                                                          : 'Next',
                                                                  style:
                                                                      const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        14.0,
                                                                  ),
                                                                ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Container(
                                      //                                    decoration: BoxDecoration(
                                      //                                      borderRadius: BorderRadius.only
                                      //                                        (bottomLeft: Radius.circular(20))
                                      //                                    ),
                                      alignment: Alignment.bottomLeft,
                                      child: Image.asset(
                                        AppImage.loginvector,
                                        fit: BoxFit.fill,
                                        height: 100,
                                        width: 156,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Visibility(
                                  visible: false,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Material(
                                        color: AppColor.primaryColor,
                                        elevation: 4.0,
                                        borderRadius: BorderRadius.circular(50),
                                        clipBehavior: Clip.hardEdge,
                                        child: InkWell(
                                          onTap: () {
                                            //                                                    Navigator.push(
                                            //                                                        context,
                                            //                                                        MaterialPageRoute(
                                            //                                                            builder: (BuildContext context) =>
                                            //                                                                NewsScreen()));
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 32),
                                            child: Center(
                                              child: Text(
                                                'School '
                                                'Login',
                                                style: TextStyle(
                                                  color:
                                                      AppColor.secondaryColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  textField({
    String? title,
    Function(String?)? onChanged,
    String Function(String?)? validator,
    bool isdropDown = false,
    List? list,
    String? intialValue,
  }) =>
      isdropDown
          ? Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(
                      color: AppColor.secondaryColor,
                      fontSize: 12,
                    ),
                  ),
                  DropdownButton<String>(
                    isExpanded: true,
                    onChanged: onChanged,
                    value: intialValue,
                    underline: Container(
                      width: double.infinity,
                      color: Colors.grey,
                      height: 1,
                      child: const Text(""),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: list!
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              e,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            )
          : TextFormField(
              cursorColor: AppColor.secondaryColor,
              validator: validator,
              onSaved: onChanged,
              decoration: InputDecoration(
                labelText: title,
                labelStyle: TextStyle(
                  color: AppColor.secondaryColor,
                  fontSize: 16,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                disabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                ),
              ),
            );
}
