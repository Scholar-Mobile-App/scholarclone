import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_requisition_controller.dart';

import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class AddRequisitionScreen extends StatelessWidget {
  AddRequisitionScreen({super.key});
  final AddRequisitionController _controller =
      Get.put(AddRequisitionController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: teacherAppBar(text: "Requisition Form"),
        body: Stack(
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
            ListView(
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
                      Row(
                        children: [
                          const Text("Requisition by "),
                          Text(
                            _controller.userInfo["fullname"] ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      hSizeBox10,
                      dateTimeTextField(
                        title: "Requisition Date",
                        date: _controller.requisitionDate.value,
                        onTap: (value) {
                          _controller.requisitionDate.value = value;
                        },
                        context: context,
                      ),
                      dropDownTextField(
                        title: "Items",
                        key: _controller.itemKey,
                        list: _controller.itemName,
                        onChanged: (value) {
                          for (int i = 0;
                              i < _controller.itemList.length;
                              i++) {
                            if (_controller.itemList[i].title == value) {
                              _controller.itemID.value =
                                  _controller.itemList[i].id!;
                              break;
                            }
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: textField(
                              textInputType: TextInputType.number,
                              title: "Qty",
                              hintText: "Type Here",
                              onChanged: (value) {
                                _controller.qty.value = value;
                              },
                            ),
                          ),
                          wSizeBox20,
                          Expanded(
                            child: textField(
                              title: "Unit",
                              hintText: "Type Here",
                              onChanged: (value) {
                                _controller.unit.value = value;
                              },
                            ),
                          ),
                        ],
                      ),
                      dateTimeTextField(
                        title: "Expected Delivery Date",
                        date: _controller.expectedDeliveryDate.value,
                        onTap: (value) {
                          _controller.expectedDeliveryDate.value = value;
                        },
                        context: context,
                      ),
                      textField(
                        title: "Remarks",
                        hintText: "Type Here",
                        maxLine: 3,
                        onChanged: (value) {
                          _controller.remarks.value = value;
                        },
                      ),
                    ],
                  ),
                ),
                hSizeBox20,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppButton(
                    text: "Save",
                    onTap: () {
                      _controller.callService(context);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
