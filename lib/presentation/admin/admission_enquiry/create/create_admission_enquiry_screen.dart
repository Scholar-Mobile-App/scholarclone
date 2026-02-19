import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/standard.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'create_admission_enquiry_controller.dart';

class CreateAdmissionEnquiryScreen extends StatelessWidget {
  CreateAdmissionEnquiryScreen({super.key});

  final CreateAdmissionEnquiryController _controller =
      Get.put(CreateAdmissionEnquiryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_controller.isEdit
          ? "Update Admission Enquiry"
          : "Create Admission Enquiry"),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            hSizeBox20,
            textFieldController(
              _controller.enquiryNumber.value,
              title: "Enquiry Number",
              hintText: "Enquiry Number",
              isOnlyRead: true,
            ),
            textFieldController(
              _controller.firstName.value,
              title: "First Name",
              hintText: "First Name",
            ),
            textFieldController(
              _controller.middleName.value,
              title: "Middle Name",
              hintText: "Middle Name",
            ),
            textFieldController(
              _controller.lastName.value,
              title: "Last Name",
              hintText: "Last Name",
            ),
            textFieldController(
              _controller.mobile.value,
              title: "Mobile",
              hintText: "Mobile",
            ),
            textFieldController(
              _controller.email.value,
              title: "Email",
              hintText: "Email",
            ),
            dateTimeTextField(
              title: "Date of Birth",
              date: _controller.dob.value,
              onTap: (value) {
                _controller.dob.value = value;
              },
              context: context,
            ),
            textFieldController(
              _controller.age.value,
              title: "Age",
              hintText: "Age",
            ),
            textFieldController(
              _controller.address.value,
              title: "Address",
              hintText: "Address",
            ),
            textFieldController(
              _controller.previousSchoolName.value,
              title: "Previous School Name",
              hintText: "Previous School Name",
            ),
            AppDropDown(
              title: "Previous Standard",
              dropdownList: standardList,
              selectedValue: _controller.selectPreviousStandard,
              onChanged: (value) {
                _controller.selectPreviousStandard.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            textFieldController(
              _controller.sourceEnquiry.value,
              title: "Source of Enquiry",
              hintText: "Source of Enquiry",
            ),
            textFieldController(
              _controller.remark.value,
              title: "Remark",
              hintText: "Remark",
            ),
            dateTimeTextField(
              title: "Followup Date",
              date: _controller.followupDate.value,
              onTap: (value) {
                _controller.followupDate.value = value;
              },
              context: context,
            ),
            AppDropDown(
              title: "Category",
              dropdownList: categoryList,
              selectedValue: _controller.selectCategory,
              onChanged: (value) {
                _controller.selectCategory.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            const Text(
              "Gender",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Obx(
              () {
                return Row(
                  children: _controller.genderOptions.map((gender) {
                    return Row(
                      children: [
                        Radio<String>(
                          value: gender,
                          groupValue: _controller.selectedGender.value,
                          onChanged: (value) {
                            _controller.selectGender(value!);
                          },
                          visualDensity: const VisualDensity(horizontal: -4),
                        ),
                        Text(gender),
                        wSizeBox20,
                      ],
                    );
                  }).toList(),
                );
              },
            ),
            AppDropDown(
              title: "Send SMS",
              dropdownList: _controller.smsList,
              selectedValue: _controller.sendSMS,
              onChanged: (value) {
                _controller.sendSMS.value =
                    value ?? const DropDownModel(id: 2, name: "");
              },
            ),
            hSizeBox20,
            AppDropDown(
              title: "Admission Standard",
              dropdownList: standardList,
              selectedValue: _controller.selectAdmissionStandard,
              onChanged: (value) {
                _controller.selectAdmissionStandard.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox30,
            AppButton(
              color: const Color(0xff5C4AC7),
              text: _controller.isEdit ? "Update" : "Save",
              loader: _controller.isLoading.value,
              onTap: () {
                _controller.isEdit
                    ? _controller.updateAdmissionEnquiry()
                    : _controller.createAdmissionEnquiry();
              },
            ),
            hSizeBox30,
          ],
        ),
      ),
    );
  }
}
