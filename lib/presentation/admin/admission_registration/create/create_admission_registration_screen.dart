import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/standard.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import 'create_admission_registration_controller.dart';

class CreateAdmissionRegistrationScreen extends StatelessWidget {
  CreateAdmissionRegistrationScreen({super.key});

  final CreateAdmissionRegistrationController _controller =
      Get.put(CreateAdmissionRegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_controller.isEdit
          ? "Update Admission Registration"
          : "Create Admission Registration"),
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
              selectedValue: _controller.previousStandard,
              onChanged: (value) {
                _controller.previousStandard.value =
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
              title: "Status",
              dropdownList: _controller.statusList,
              selectedValue: _controller.status,
              onChanged: (value) {
                _controller.status.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            AppDropDown(
              title: "Admission Standard",
              dropdownList: standardList,
              selectedValue: _controller.admissionStandard,
              onChanged: (value) {
                _controller.admissionStandard.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            textFieldController(
              _controller.stopTransport.value,
              title: "Stop for Transport",
              hintText: "Stop for Transport",
            ),
            textFieldController(
              _controller.councilerName.value,
              title: "Counciler Name",
              hintText: "Counciler Name",
            ),
            textFieldController(
              _controller.lastExamName.value,
              title: "Last Exam Name",
              hintText: "Last Exam Name",
            ),
            textFieldController(
              _controller.lastExamPercentage.value,
              title: "Last Exam Percentage",
              hintText: "Last Exam Percentage",
            ),
            textFieldController(
              _controller.fatherEducation.value,
              title: "Father Education Qualification",
              hintText: "Father Education Qualification",
            ),
            textFieldController(
              _controller.fatherOccupation.value,
              title: "Father Occupation",
              hintText: "Father Occupation",
            ),
            textFieldController(
              _controller.motherEducation.value,
              title: "Mother Education Qualification",
              hintText: "Mother Education Qualification",
            ),
            textFieldController(
              _controller.motherOccupation.value,
              title: "Mother Occupation",
              hintText: "Mother Occupation",
            ),
            textFieldController(
              _controller.annualIncome.value,
              title: "Annual Income",
              hintText: "Annual Income",
            ),
            textFieldController(
              _controller.admissionDocketNo.value,
              title: "Admission Docket No.",
              hintText: "Admission Docket No.",
            ),
            textFieldController(
              _controller.registrationNo.value,
              title: "Registration No.",
              hintText: "Registration No.",
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
            hSizeBox30,
            AppButton(
              color: const Color(0xff5C4AC7),
              text: _controller.isEdit ? "Update" : "Save",
              loader: _controller.isLoading.value,
              onTap: () {
                _controller.callUpdateService();
              },
            ),
            hSizeBox30,
          ],
        ),
      ),
    );
  }
}
