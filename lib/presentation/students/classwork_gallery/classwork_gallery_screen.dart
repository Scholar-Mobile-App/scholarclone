import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/classwork_gallery/classwork_gallery_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_text_field.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class ClassworkGalleryScreen extends StatelessWidget {
  ClassworkGalleryScreen({super.key});
  final ClassworkGalleryController _con = Get.put(ClassworkGalleryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: teacherAppBar(text: 'Classwork Gallery'),
      body: Column(
        children: [
          hSizeBox20,
          Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: dateRangeTimeWRT(
                        context: Get.context!,
                        title: "From Date",
                        date: _con.fromDate.value.isEmpty
                            ? ""
                            : _con.fromDate.value,
                        onTap: (val) {
                          if (val != null) {
                            _con.fromDate.value = val.toString();
                            _con.callService();
                          }
                        }),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: dateRangeTimeWRT(
                      context: Get.context!,
                      title: "To Date",
                      date: _con.toDate.value.isEmpty ? "" : _con.toDate.value,
                      onTap: (val) {
                        if (val != null) {
                          _con.toDate.value = val.toString();
                          _con.callService();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => _con.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : _con.classworkList.isEmpty
                      ? CU.getNodataDesign()
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: _con.classworkList.length,
                          separatorBuilder: (context, index) => hSizeBox10,
                          itemBuilder: (context, index) {
                            var data = _con.classworkList[index];

                            return Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0)),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data.title ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          hSizeBox4,
                                          Text(
                                            data.createdAt == null
                                                ? "-"
                                                : DateFormat('dd-MM-yyyy')
                                                    .format(data.createdAt!),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        if (!CU
                                            .isEmptyOrNull(data.filePath ?? ""))
                                          Transform.rotate(
                                            angle: 2.3,
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.link,
                                                size: 25,
                                                color: CU.secondaryColor,
                                              ),
                                              onPressed: () async {
                                                downloadExport(
                                                  context: Get.context!,
                                                  fileUrl: data.filePath!,
                                                  filename: "classwork",
                                                );
                                              },
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
