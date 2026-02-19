import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/presentation/auth/sign_up/sign_up_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class SignUpSreen extends StatelessWidget {
  SignUpSreen({super.key});
  final SignUpController _controller = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar("Sign Up"),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                roleContainer(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        blurRadius: 5,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: form(),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        FocusScope.of(context).unfocus();
                        if (_controller.selectedIndex.value == 0) {
                          _controller.callServiceStudent();
                        } else {
                          _controller.callServiceTeacherAndAdmin();
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  form() => Column(
        children: [
          textField(
              title: "First Name",
              onChanged: (value) {
                _controller.firstName.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter First Name";
                } else if (!RegExp("^[a-zA-Z]+\$").hasMatch(value)) {
                  return "The first name format is invalid";
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          textField(
              title: "Last Name",
              onChanged: (value) {
                _controller.lastName.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Last Name";
                } else if (!RegExp("^[a-zA-Z]+\$").hasMatch(value)) {
                  return "The first name format is invalid";
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: textField(
                    title: "Gender",
                    list: ["Male", "Female"],
                    isdropDown: true,
                    intialValue: _controller.selectedGender.value,
                    onChanged: (value) {
                      _controller.selectedGender.value = value;
                    }),
              ),
              Expanded(
                child: birthDatePicker(title: "BirthDate"),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          textField(
              title: "Email",
              onChanged: (value) {
                _controller.email.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Email Address";
                } else if (!RegExp(
                        "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$")
                    .hasMatch(value)) {
                  return "Enter Email valid Address";
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          textField(
              title: "Mobile",
              onChanged: (value) {
                _controller.mobile.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Mobile Number";
                } else if (value.length < 10 || value.length > 10) {
                  return "The mobile must be 10 digits.";
                } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                  return "The mobile must be a number.";
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          textField(
              title: "Institude Name",
              onChanged: (value) {
                _controller.institudeName.value = value;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Institude Name";
                }
                return null;
              }),
          const SizedBox(
            height: 15,
          ),
          if (_controller.selectedIndex.value == 0)
            standardDropDown(
              list: _controller.standardList,
              intialValue: _controller.selectedStandard,
              onChanged: (value) {
                _controller.selectedStandard = value;
              },
            ),
          const SizedBox(
            height: 15,
          ),
        ],
      );

  standardDropDown({
    Function(dynamic)? onChanged,
    List<StandardModel>? list,
    StandardModel? intialValue,
  }) =>
      Padding(
        padding: const EdgeInsets.only(right: 5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Standard",
              style: TextStyle(
                color: AppColor.secondaryColor,
                fontSize: 12,
              ),
            ),
            DropdownButton<StandardModel>(
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
                    (e) => DropdownMenuItem<StandardModel>(
                      value: e,
                      child: Text(
                        "${e.name} - ${e.shortName}",
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
      );

  Widget roleContainer() {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
      ),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_controller.userType.length, (index) {
          return circleContainer(
            title: _controller.userType[index]["type"],
            onTap: () {
              _controller.selectedIndex.value = index;
            },
            index: index,
          );
        }),
      ),
    );
  }

  textField({
    String? title,
    Function(dynamic)? onChanged,
    String? Function(String?)? validator,
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

  Widget circleContainer({
    String? title,
    Function()? onTap,
    int? index,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: index == _controller.selectedIndex.value
                  ? const Color(0xff2D587A)
                  : Colors.transparent,
            ),
            child: CircleAvatar(
              radius: 45,
              backgroundColor: index == _controller.selectedIndex.value
                  ? const Color(0xff014251)
                  : Colors.transparent,
              child: CircleAvatar(
                radius: index == _controller.selectedIndex.value ? 39 : 45,
                backgroundColor: const Color(0xff3EB1B6),
                backgroundImage:
                    AssetImage(_controller.userType[index!]["image"]),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        )
      ],
    );
  }

  birthDatePicker({String? title, Function? onChanged}) => GestureDetector(
        onTap: () => _selectDate(Get.context!),
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
            Container(
              height: 33,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${_controller.selectedDate.value.day.toString().padLeft(2, "0")}/${_controller.selectedDate.value.month.toString().padLeft(2, "0")}/${_controller.selectedDate.value.year}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_today,
                    size: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      );

  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );

    _controller.selectedDate.value = picked!;
  }
}

class StandardModel {
  StandardModel({
    this.id,
    this.gradeId,
    this.name,
    this.shortName,
    this.sortOrder,
    this.medium,
    this.subInstituteId,
    this.courseDuration,
    this.nextGradeId,
    this.nextStandardId,
    this.schoolStream,
    this.title,
    this.shift,
  });

  final int? id;
  final int? gradeId;
  final String? name;
  final String? shortName;
  final int? sortOrder;
  final String? medium;
  final int? subInstituteId;
  final String? courseDuration;
  final dynamic nextGradeId;
  final dynamic nextStandardId;
  final dynamic schoolStream;
  final String? title;
  final String? shift;

  factory StandardModel.fromJson(Map<String, dynamic> json) => StandardModel(
        id: json["id"],
        gradeId: json["grade_id"],
        name: json["name"],
        shortName: json["short_name"],
        sortOrder: json["sort_order"],
        medium: json["medium"],
        subInstituteId: json["sub_institute_id"],
        courseDuration: json["course_duration"],
        nextGradeId: json["next_grade_id"],
        nextStandardId: json["next_standard_id"],
        schoolStream: json["school_stream"],
        title: json["title"],
        shift: json["shift"],
      );
}
