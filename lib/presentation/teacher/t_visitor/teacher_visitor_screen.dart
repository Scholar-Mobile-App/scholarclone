import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

import '../../../core/utils/cu.dart';
import 'teacher_visitor_controller.dart';

import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/routes/app_routes.dart';

class TeacherVisitorScreen extends StatelessWidget {
  TeacherVisitorScreen({super.key});
  final TeacherVisitorController _controller =
      Get.put(TeacherVisitorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(
        text: "Visitor Details",
        actions: [
          TextButton(
            onPressed: () {
              Get.toNamed(
                AppRoutes.addVisitor,
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
            Column(
              children: [
                searchAndFilterBox(),
                _controller.isLoading.value
                    ? const Expanded(
                        child:
                            Center(child: CircularProgressIndicator.adaptive()))
                    : _controller.visitorList.isEmpty
                        ? CU.getNodataDesign()
                        : Expanded(
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: _controller.visitorList.length,
                              separatorBuilder: (context, index) => hSizeBox10,
                              itemBuilder: (context, index) {
                                var visitor = _controller.visitorList[index];
                                return Container(
                                  padding: const EdgeInsets.all(15),
                                  margin: const EdgeInsets.only(
                                      top: 15, left: 15, right: 15),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.grey.shade100,
                                          spreadRadius: 1,
                                        )
                                      ]),
                                  child: Row(
                                    children: [
                                      if (visitor.visitorPhoto!.isNotEmpty)
                                        Container(
                                          height: Get.width * 0.18,
                                          width: Get.width * 0.18,
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  visitor.visitorPhoto!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )
                                      else
                                        Container(
                                          height: Get.width * 0.18,
                                          width: Get.width * 0.18,
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage(AppImage.profile),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            visitor.name ?? "",
                                            style: TextStyle(
                                              color: CU.tprimaryColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Contact : ",
                                                style: TextStyle(
                                                  color: CU.tprimaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                visitor.contact ?? "",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Email : ",
                                                style: TextStyle(
                                                  color: CU.tprimaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                visitor.email ?? "",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Coming From : ",
                                                style: TextStyle(
                                                  color: CU.tprimaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                visitor.comingFrom ?? "",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Relation : ",
                                                style: TextStyle(
                                                  color: CU.tprimaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                visitor.relation ?? "",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Purpose : ",
                                                style: TextStyle(
                                                  color: CU.tprimaryColor,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.45,
                                                child: Text(
                                                  visitor.purpose ?? "",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Meet Date/Time : ",
                                                    style: TextStyle(
                                                      color: CU.tprimaryColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    visitor.updatedAt ?? "",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "To-Meet : ",
                                                    style: TextStyle(
                                                      color: CU.tprimaryColor,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    visitor.staffName ?? "",
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
              ],
            )
          ],
        ),
      ),
    );
  }

  searchAndFilterBox() => Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.grey.shade100,
                spreadRadius: 1,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: dateRangeTimeTextField(
                  context: Get.context!,
                  title: "From Date",
                  date: _controller.fromDate.value,
                  onTap: (val) {
                    _controller.fromDate.value = val;
                    _controller.callService();
                  }),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: dateRangeTimeTextField(
                context: Get.context!,
                title: "To Date",
                date: _controller.toDate.value,
                onTap: (val) {
                  _controller.toDate.value = val;
                  _controller.callService();
                },
              ),
            ),
          ],
        ),
      );
}
