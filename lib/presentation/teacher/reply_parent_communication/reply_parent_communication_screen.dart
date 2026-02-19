import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/teacher/reply_parent_communication/reply_parent_communication_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';

class ReplyParentCommunicationScreen extends StatelessWidget {
  ReplyParentCommunicationScreen({super.key});
  final ReplyParentCommunicationController _controller =
      Get.put(ReplyParentCommunicationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: "Parent Teacher Communication"),
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
            _controller.isLoading.value
                ? const CircularProgressIndicator.adaptive()
                : _controller.dataList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        itemCount: _controller.dataList.length,
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20,
                        ),
                        separatorBuilder: (context, index) => hSizeBox20,
                        itemBuilder: (context, index) {
                          var data = _controller.dataList[index];

                          return Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date : ${data.parentCommDate ?? ""}",
                                  style: const TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                hSizeBox10,
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      data.studentName ?? "",
                                      style: TextStyle(
                                        color: CU.tprimaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    wSizeBox10,
                                    Text(
                                      "${data.standardName ?? ""} - ${data.divisionName ?? ""}",
                                      style: const TextStyle(
                                        color: Colors.indigo,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                hSizeBox6,
                                Text(
                                  "+91${data.mobile ?? ""}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                hSizeBox10,
                                Text(
                                  data.message ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  color: Colors.black38,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  height: 1,
                                ),
                                data.reply!.text != ""
                                    ? Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text(
                                                "Reply By : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Text(
                                                data.replyBy ?? "",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.deepPurple,
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          ),
                                          hSizeBox4,
                                          Row(
                                            children: [
                                              const Text(
                                                "Reply On : ",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                  fontSize: 10,
                                                ),
                                              ),
                                              Text(
                                                "${data.replyOn ?? ""}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          textFieldController(
                                            data.reply!,
                                            title: "",
                                            hintText: "Enter Your Message...",
                                            maxLine: 3,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              height: 25,
                                              child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.grey[300],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  side: const BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _controller.callServiceReply(
                                                    data,
                                                    context,
                                                  );
                                                },
                                                child: const Text(
                                                  "Replay",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                Text(
                                  data.reply!.text,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
          ],
        ),
      ),
    );
  }
}
