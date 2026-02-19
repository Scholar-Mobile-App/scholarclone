import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/height_weight/height_weight_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class HeightWeightScreen extends StatelessWidget {
  HeightWeightScreen({super.key});
  final HeightWeightController _controller = Get.put(HeightWeightController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Height Weight",
          rounded: false,
        ),
        body: _controller.isLoading.value
            ? const CircularProgressIndicator.adaptive()
            : _controller.heightWeightList.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _controller.heightWeightList.length,
                    itemBuilder: (context, index) {
                      var data = _controller.heightWeightList[index];
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
                            ]),
                        child: Column(
                          children: [
                            textContainer(
                              title: "Doctor Name",
                              content: data.doctorName ?? "",
                            ),
                            textContainer(
                              title: "Doctor Contact",
                              content: data.doctorContact ?? "",
                            ),
                            textContainer(
                                title: "Date", content: data.date ?? ""),
                            textContainer(
                              title: "Height",
                              content: data.height ?? "",
                            ),
                            textContainer(
                              title: "Weight",
                              content: data.weight ?? "",
                              divider: false,
                            ),
                          ],
                        ),
                      );
                    },
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
