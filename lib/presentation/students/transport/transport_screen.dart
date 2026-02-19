import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/transport/transport_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class TransportScreen extends StatelessWidget {
  TransportScreen({super.key});
  final TransportController _controller = Get.put(TransportController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Transport",
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
                : _controller.trasportList.isEmpty
                    ? CU.getNodataDesign()
                    : Column(
                        children: [
                          Flexible(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(20),
                              itemCount: _controller.trasportList.length,
                              itemBuilder: (context, index) {
                                var data = _controller.trasportList[index];
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
                                    children: [
                                      textContainer(
                                        title: "From Shift",
                                        content: data.fromShift ?? "",
                                      ),
                                      textContainer(
                                        title: "From Bus",
                                        content: data.fromBus ?? "",
                                      ),
                                      textContainer(
                                        title: "From",
                                        content: data.fromStopName ?? "",
                                      ),
                                      textContainer(
                                        title: "To Shift",
                                        content: data.toShift ?? "",
                                      ),
                                      textContainer(
                                        title: "To Bus",
                                        content: data.toBus ?? "",
                                      ),
                                      textContainer(
                                        title: "TO",
                                        content: data.toStopName ?? "",
                                        divider: false,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          if ((_controller.trasportList).isNotEmpty &&
                              (_controller.trasportList.first.gpsLink ?? "")
                                  .isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _controller.launchGPS(_controller.trasportList.first.gpsLink ?? "");
                              }
                              ,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    shape: BoxShape.circle),
                                child: Icon(Icons.gps_fixed),
                              ),
                            )
                        ],
                      ),
          ],
        ),
      ),
    );
  }

  textContainer({
    String? title,
    String? content,
    bool divider = true,
    Color color = Colors.black,
  }) =>
      Column(
        children: [
          hSizeBox16,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title!,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  content!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          if (divider)
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: Get.width,
              height: 0.3,
              color: Colors.grey,
            )
        ],
      );
}
