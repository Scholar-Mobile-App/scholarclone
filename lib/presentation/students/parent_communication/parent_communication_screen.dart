import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/parent_communication/parent_communication_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class ParentCommunicationScreen extends StatelessWidget {
  ParentCommunicationScreen({super.key});

  final ParentCommunicationController _controller =
      Get.put(ParentCommunicationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Parent Communication"),
      backgroundColor: Colors.grey.shade100,
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              title("Subject"),
              hSizeBox10,
              TextField(
                controller: _controller.subjectCon,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColor.secondaryColor, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.secondaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColor.textColorlight,
                  ),
                  hintText: 'Enter subject',
                  errorText: _controller.subjectError.isEmpty
                      ? null
                      : _controller.subjectError.value,
                  errorStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
              hSizeBox20,
              title("Ask question"),
              hSizeBox10,
              TextFormField(
                controller: _controller.questionCon,
                maxLines: 6,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.secondaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.secondaryColor,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(12.0),
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: AppColor.textColorlight,
                  ),
                  hintText: 'Enter question',
                  errorText: _controller.questionError.isEmpty
                      ? null
                      : _controller.questionError.value,
                  errorStyle: const TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                  ),
                ),
              ),
              hSizeBox20,
              InkWell(
                onTap: () {
                  if (_controller.valid()) {
                    _controller.callService();
                  }
                },
                borderRadius: BorderRadius.circular(50),
                child: Ink(
                  decoration: BoxDecoration(
                    color: AppColor.secondaryColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const SizedBox(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              hSizeBox20,
              Expanded(
                child: _controller.isLoading.value == true
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : _controller.communicationList.isEmpty
                        ? CU.getNodataDesign()
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: _controller.communicationList.length,
                            separatorBuilder: (context, index) => hSizeBox10,
                            itemBuilder: (context, index) {
                              var data = _controller.communicationList[index];

                              return Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey.shade100,
                                      spreadRadius: 1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            data.title ?? "",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          DateFormat("yyyy-MM-dd HH:mm").format(
                                              DateTime.parse(
                                                  data.createdAt.toString())),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    hSizeBox6,
                                    Text(
                                      data.message ?? "",
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Reply : ",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: 10,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            data.reply.toString(),
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 3),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Reply By: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              data.replyBy ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Reply On: ",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                                fontSize: 10,
                                              ),
                                            ),
                                            Text(
                                              data.replyOn ?? "",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text title(String text) {
    return Text(
      text,
      style: TextStyle(
        color: AppColor.secondaryColor,
        fontSize: 14,
      ),
    );
  }
}
