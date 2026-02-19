import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'hostel_controller.dart';

class HostelScreen extends StatelessWidget {
  HostelScreen({super.key});
  final HostelController _controller = Get.put(HostelController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Hostel Details",
          rounded: false,
        ),
        body: Stack(
          children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                color: CU.primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
            _controller.isLoading.value
                ? const Center(child: CircularProgressIndicator.adaptive())
                : _controller.hostelDetails == null
                    ? CU.getNodataDesign()
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          var data = _controller.hostelDetails;
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
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
                              children: [
                                textContainer(
                                  title: "Admission Category",
                                  content: "-",
                                ),
                                textContainer(
                                  title: "Hostel",
                                  content: data?.hostelName ?? "-",
                                ),
                                textContainer(
                                  title: "Room No",
                                  content: data?.roomName ?? "-",
                                ),
                                textContainer(
                                  title: "Bed No",
                                  content: data?.bedNo ?? "-",
                                ),
                                textContainer(
                                  title: "Locker No",
                                  content: data?.lockerNo ?? "-",
                                ),
                                textContainer(
                                  title: "Table No",
                                  content: data?.tableNo ?? "-",
                                ),
                                textContainer(
                                  title: "Bedsheet No",
                                  content: data?.bedsheetNo ?? "-",
                                  divider: false,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ],
        ),
      ),
    );
  }

  textContainer({
    required String title,
    required String content,
    bool divider = true,
  }) =>
      Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              SizedBox(
                width: Get.width * 0.45,
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (divider)
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: Get.width,
              height: 0.3,
              color: Colors.grey,
            )
        ],
      );
}
