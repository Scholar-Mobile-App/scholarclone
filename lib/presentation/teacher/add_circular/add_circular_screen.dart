import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/add_circular/add_circular_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class AddCircularScreen extends StatelessWidget {
  AddCircularScreen({super.key});
  final AddCircularController _controller = Get.put(AddCircularController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: CU.tprimaryColor,
        title: const Text(
          "Add Circular",
          style: TextStyle(color: Colors.white),
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Obx(
        () => Stack(
          children: [
            Container(
              width: Get.width,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.elliptical(Get.width / 2, 30),
                  bottomRight: Radius.elliptical(Get.width / 2, 30),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 10,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        dropDownTextField(
                          title: "Select Standard",
                          list: _controller.stdName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.stdName.length;
                                i++) {
                              if (_controller.standardModel!.data![i].stdName ==
                                  value) {
                                _controller.stdId.value =
                                    _controller.standardModel!.data![i].stdId!;
                                _controller.selectStandard.value = _controller
                                    .standardModel!.data![i].stdName!;
                                _controller.divName.value = [];
                                _controller.callServiceDivision();

                                break;
                              }
                            }
                          },
                        ),
                        dropDownTextField(
                          title: "Select Division",
                          list: _controller.divName,
                          onChanged: (value) {
                            for (int i = 0;
                                i < _controller.divisionModel!.data!.length;
                                i++) {
                              if (_controller.divisionModel!.data![i].divName ==
                                  value) {
                                _controller.divId.value =
                                    _controller.divisionModel!.data![i].divId!;
                                _controller.selectDivision.value = _controller
                                    .divisionModel!.data![i].divName!;
                                break;
                              }
                            }
                          },
                        ),
                        dateTimeTextField(
                          title: "Submission Date",
                          date: _controller.selectedDate.value,
                          onTap: (value) {
                            _controller.selectedDate.value = value;
                          },
                          context: context,
                        ),
                        textField(
                          title: "Enter Title",
                          hintText: "Type Here",
                          onChanged: (value) {
                            _controller.title.value = value;
                          },
                        ),
                        dropDownTextField(
                          title: "Type",
                          list: ["Circular", "Event"],
                          onChanged: (value) {
                            "Circular" == value
                                ? _controller.type.value = 1
                                : _controller.type.value = 2;
                            _controller.selectType.value = value!;
                          },
                        ),
                        textField(
                          title: "Enter Message",
                          hintText: "Type Here",
                          maxLine: 3,
                          onChanged: (value) {
                            _controller.message.value = value;
                          },
                        ),
                        // filePickField(
                        //   context: context,
                        //   title: "HomeWork Image",
                        //   imageFile: _controller.imageFile.value,
                        //   onTap: (value) {
                        //     _controller.imageFile.value = value;

                        //     log("123 ${_controller.imageFile.value.path}");
                        //   },
                        // ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Attachment",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 10,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      _controller.imageFile != null
                                          ? _controller.imageFile
                                                  .split('/')
                                                  .last
                                                  .isEmpty
                                              ? "Choose"
                                              : _controller.imageFile
                                                  .split('/')
                                                  .last
                                          : "Choose",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25,
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        side: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                      ),
                                      onPressed: () {
                                        _controller.pickPhotos();
                                      },
                                      child: const Text(
                                        "Choose File",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  hSizeBox20,
                  AppButton(
                    text: "Submit",
                    loader: _controller.isLoading.value,
                    onTap: () {
                      _controller.callService();
                    },
                  ),
                  hSizeBox30
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
