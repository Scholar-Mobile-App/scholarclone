import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

import 't_requisition_controller.dart';

import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';

class InventoryRequisitionScreen extends StatelessWidget {
  InventoryRequisitionScreen({super.key});
  final InventoryRequisitionController _controller =
      Get.put(InventoryRequisitionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Requisition Details",
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.addRequisition,
                arguments: [
                  _controller.data,
                  _controller.userInfo,
                ],
              );
            },
            child: const Text(
              "Add",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
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
          Obx(
            () => _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.requisitionList.isEmpty
                    ? CU.getNodataDesign()
                    : Stack(
                        children: [
                          Container(
                            width: Get.width,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.elliptical(Get.width / 2, 30),
                                bottomRight:
                                    Radius.elliptical(Get.width / 2, 30),
                              ),
                            ),
                          ),
                          ListView.separated(
                            itemCount: _controller.requisitionList.length,
                            separatorBuilder: (context, index) => hSizeBox10,
                            itemBuilder: (context, index) {
                              var requisition =
                                  _controller.requisitionList[index];
                              return Container(
                                padding: const EdgeInsets.all(15),
                                margin: const EdgeInsets.only(
                                    top: 15, left: 15, right: 15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 3,
                                    color: (requisition.requisitionStatus ==
                                            "APPROVED")
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "By Requisition : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.blue,
                                            fontSize: 8,
                                          ),
                                        ),
                                        Text(
                                          requisition.requisitionBy!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Date : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition.requisitionDate
                                                        .toString(),
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Item : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition.itemName!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.deepPurple,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Approved By : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition
                                                        .requisitionApprovedBy!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.green,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Approved Remark : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition
                                                            .requisitionApprovedRemarks ??
                                                        "-",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.deepPurple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Approved Date : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition
                                                            .requisitionApprovedDate ??
                                                        "-",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.deepPurple,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        (requisition.requisitionStatus ==
                                                "APPROVED")
                                            ? Container(
                                                child: Image.asset(
                                                  AppImage.approve,
                                                  height: 30,
                                                ),
                                              )
                                            : Container(
                                                child: Image.asset(
                                                  AppImage.reject,
                                                  height: 30,
                                                ),
                                              ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Req.No : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.blue,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition.requisitionNo!,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              const Text(
                                                "Expected Date : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.blue,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Text(
                                                DateFormat('yyyy-MM-dd').format(
                                                    DateTime.parse(requisition
                                                        .expectedDeliveryTime
                                                        .toString())),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Qty : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.purple,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      Text(
                                                        requisition.itemQty
                                                                .toString() ??
                                                            "-",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              Colors.deepPurple,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Unit : ",
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.purple,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                      Text(
                                                        requisition.itemUnit
                                                                .toString() ??
                                                            "-",
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color:
                                                              Colors.deepPurple,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Status : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition
                                                        .requisitionStatus!,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: (requisition
                                                                  .requisitionStatus! ==
                                                              "APPROVED")
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  const Text(
                                                    "Approved Qty : ",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.purple,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  Text(
                                                    requisition.approvedQty ??
                                                        "-",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: Colors.deepPurple,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}
