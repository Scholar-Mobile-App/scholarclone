import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/admin/admission_confirmation/create/create_admission_confirmation_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_drop_down.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class CreateAdmissionConfirmationScreen extends StatelessWidget {
  CreateAdmissionConfirmationScreen({super.key});

  final CreateAdmissionConfirmationController _controller =
      Get.put(CreateAdmissionConfirmationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(_controller.isEdit
          ? "Update Admission Confirmation"
          : "Create Admission Confirmation"),
      body: Obx(
        () => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            hSizeBox20,
            textFieldController(
              _controller.enquiryNumber.value,
              title: "Enquiry Number",
              hintText: "Enquiry Number",
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
              _controller.age.value,
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
              dropdownList: _controller.fileNameList,
              selectedValue: _controller.selectFileName,
              onChanged: (value) {
                _controller.selectFileName.value =
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
              dropdownList: _controller.fileNameList,
              selectedValue: _controller.selectFileName,
              onChanged: (value) {
                _controller.selectFileName.value =
                    value ?? const DropDownModel(id: 0, name: "");
              },
            ),
            hSizeBox20,
            AppDropDown(
              title: "Previous Standard",
              dropdownList: _controller.fileNameList,
              selectedValue: _controller.selectFileName,
              onChanged: (value) {
                _controller.selectFileName.value =
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
            // AppDropDown(
            //   title: "File Name",
            //   dropdownList: _controller.fileNameList,
            //   selectedValue: _controller.selectFileName,
            //   onChanged: (value) {
            //     _controller.selectFileName.value =
            //         value ?? const DropDownModel(id: 0, name: "");
            //   },
            // ),
            // hSizeBox20,
            // Row(
            //   children: [
            //     Expanded(
            //       child: filePickField(
            //         context: context,
            //         title: "Upload File",
            //         imageFile:
            //             XFile(_controller.file.value.path.replaceAll("*", "")),
            //         onTap: (value) {
            //           if (value != null) {
            //             _controller.file.value = value;
            //           }
            //         },
            //       ),
            //     ),
            //     if (_controller.file.value.path.isNotEmpty) ...[
            //       wSizeBox10,
            //       GestureDetector(
            //         onTap: () {
            //           _controller.file.value = XFile("");
            //         },
            //         child: Container(
            //           height: 30,
            //           width: 30,
            //           decoration: BoxDecoration(
            //             color: AppColor.redColor,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: const Icon(
            //             Icons.clear,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ),
            //     ]
            //   ],
            // ),
            // AppDropDown(
            //   title: "To Place",
            //   dropdownList: _controller.toPlaceList,
            //   selectedValue: _controller.selectToPlace,
            //   onChanged: (value) {
            //     _controller.selectToPlace.value =
            //         value ?? const DropDownModel(id: 0, name: "");
            //   },
            // ),
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
