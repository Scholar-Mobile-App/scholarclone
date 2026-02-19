import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'infirmary_controller.dart';

class InfirmaryScreen extends StatelessWidget {
  InfirmaryScreen({super.key});
  final InfirmaryController _controller = Get.put(InfirmaryController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Infirmary",
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
                : _controller.infirmaryList.isEmpty
                    ? CU.getNodataDesign()
                    : ListView.separated(
                        itemCount: _controller.infirmaryList.length,
                        separatorBuilder: (context, index) => hSizeBox10,
                        itemBuilder: (context, index) {
                          var data = _controller.infirmaryList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 15),
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
                                  title: "Medical Case No",
                                  content: data.medicalCaseNo ?? "",
                                ),
                                textContainer(
                                  title: "Doctor Name",
                                  content: data.doctorName ?? "",
                                ),
                                textContainer(
                                  title: "Doctor Contact",
                                  content: data.doctorContact ?? "",
                                ),
                                textContainer(
                                  title: "Open Date",
                                  content: data.date ?? "",
                                ),
                                textContainer(
                                  title: "Complaint",
                                  content: data.complaint ?? "",
                                ),
                                textContainer(
                                  title: "Symptoms",
                                  content: data.symptoms ?? "",
                                ),
                                textContainer(
                                  title: "Disease",
                                  content: data.disease ?? "",
                                ),
                                textContainer(
                                  title: "Treatment",
                                  content: data.treatments ?? "",
                                ),
                                textContainer(
                                  title: "Medical Case Date",
                                  content: data.medicalCloseDate ?? "",
                                ),
                                textContainer(
                                  title: "Health Center",
                                  content: data.healthCenter ?? "",
                                  divider: false,
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
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
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
