import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'add_admin_inward_controller.dart';

class AddAdminInwardScreen extends StatelessWidget {
  AddAdminInwardScreen({super.key});

  final AddAdminInwardController _controller =
      Get.put(AddAdminInwardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_controller.isEdit ? "Update Inward" : "Add Inward"),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            hSizeBox20,
            AppDropDown(
              title: "To Place",
              dropdownList: _controller.toPlaceList,
              selectedValue: _controller.selectToPlace,
              onChanged: (value) {
                _controller.selectToPlace.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            dateTimeTextField(
              title: "Inward Date",
              date: _controller.outwardDate.value,
              onTap: (value) {
                _controller.outwardDate.value = value;
              },
              context: context,
            ),
            textFieldController(
              _controller.outwardNumber.value,
              title: "Inward Number",
              hintText: "Inward Number",
            ),
            textFieldController(
              _controller.subject.value,
              title: "Subject",
              hintText: "Subject",
            ),
            textFieldController(
              _controller.description.value,
              title: "Description",
              hintText: "Description",
            ),
            AppDropDown(
              title: "File Name",
              dropdownList: _controller.fileNameList,
              selectedValue: _controller.selectFileName,
              onChanged: (value) {
                _controller.selectFileName.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            Row(
              children: [
                Expanded(
                  child: filePickField(
                    context: context,
                    title: "Upload File",
                    imageFile:
                        XFile(_controller.file.value.path.replaceAll("*", "")),
                    onTap: (value) {
                      if (value != null) {
                        _controller.file.value = value;
                      }
                    },
                  ),
                ),
                if (_controller.file.value.path.isNotEmpty) ...[
                  wSizeBox10,
                  GestureDetector(
                    onTap: () {
                      _controller.file.value = XFile("");
                    },
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: AppColor.redColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.clear,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]
              ],
            ),
            hSizeBox30,
            AppButton(
              color: const Color(0xff5C4AC7),
              text: _controller.isEdit ? "Update" : "Save",
              loader: _controller.isLoading.value,
              onTap: () {
                _controller.isEdit
                    ? _controller.callUpdateService()
                    : _controller.callService();
              },
            ),
            hSizeBox30,
          ],
        ),
      ),
    );
  }
}
