import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

import 'consent_controller.dart';

class ConsentScreen extends StatelessWidget {
  ConsentScreen({super.key});
  final ConsentController _controller = Get.put(ConsentController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Consent",
          rounded: false,
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.consentList.isEmpty
                ? CU.getNodataDesign()
                : ListView.builder(
                    physics: const ClampingScrollPhysics(),
                    itemCount: _controller.consentList.length,
                    itemBuilder: (context, index) {
                      var data = _controller.consentList[index];
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
                              title: "Title",
                              content: data.title ?? "-",
                            ),
                            textContainer(
                              title: "Consent Date",
                              content: data.consentDate ?? "-",
                            ),
                            textContainer(
                              title: "Accountable Status",
                              content: data.accountableStatus ?? "-",
                            ),
                            textContainer(
                              title: "Consent Status",
                              content: data.consentStatus ?? "-",
                            ),
                            textContainer(
                              title: "Amount",
                              content: data.amount ?? "-",
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
