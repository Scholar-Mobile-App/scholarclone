import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/leave/leave_controller.dart';

class LeaveScreen extends StatelessWidget {
  LeaveScreen({super.key});
  final LeaveController _controller = Get.put(LeaveController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DefaultTabController(
        length: _controller.choices.length,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            iconTheme: IconThemeData(color: AppColor.secondaryColor),
            title: TabBar(
              tabs: List.generate(_controller.choices.length, (index) {
                return Obx(
                  () => Tab(
                    text: _controller.choices[index].title,
                    icon: InkWell(
                      onTap: () {
                        _controller.tabController!.index = index;
                      },
                      child: ImageIcon(
                        AssetImage(_controller.choices[index].icon),
                        size: 22,
                        color: _controller.tabIndex.value == index
                            ? AppColor.secondaryColor
                            : AppColor.textColorlight,
                      ),
                    ),
                  ),
                );
              }),
              //  [
              //   Tab(
              //       text: 'Leave',
              //       icon: ImageIcon(
              //         const AssetImage(AppImage.leave),
              //         size: 22,
              //         color: _controller.tabController!.index == 0
              //             ? AppColor.secondaryColor
              //             : AppColor.textColorlight,
              //       )),
              //   Tab(
              //       text: 'Status',
              //       icon: ImageIcon(
              //         const AssetImage(AppImage.status),
              //         size: 22,
              //         color: _controller.tabController!.index == 1
              //             ? AppColor.secondaryColor
              //             : AppColor.textColorlight,
              //       )),
              // ],
              isScrollable: true,
              indicatorPadding: const EdgeInsets.all(8.0),
              indicatorColor: AppColor.secondaryColor,
              indicatorWeight: 2,
              unselectedLabelColor: AppColor.textColorlight,
              labelColor: AppColor.secondaryColor,
              controller: _controller.tabController,
            ),
            systemOverlayStyle: SystemUiOverlayStyle.dark,
          ),
          body: TabBarView(
            controller: _controller.tabController,
            children: [
              leaveTab(),
              statusTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget leaveTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title("From date"),
          hSizeBox10,
          TextField(
            onTap: () {
              _controller.toDateCon.text = "";

              _controller.selectDate(
                Get.context!,
                _controller.fromDateCon,
                DateTime.now(),
              );
            },
            readOnly: true,
            controller: _controller.fromDateCon,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12.0),
              filled: true,
              fillColor: Colors.white,
              hintStyle:
                  TextStyle(fontSize: 14, color: AppColor.textColorlight),
              hintText: 'Select from date',
              errorText: _controller.fromDateError.value.isEmpty
                  ? null
                  : _controller.fromDateError.value,
              errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
              suffixIcon: const Icon(Icons.date_range),
            ),
          ),
          hSizeBox20,
          title("To date"),
          hSizeBox10,
          TextField(
            onTap: () {
              _controller.fromDateCon.text.isEmpty
                  ? log("plaease seleect")
                  : _controller.selectDate(
                      Get.context!,
                      _controller.toDateCon,
                      _controller.toFromDate!,
                    );
            },
            controller: _controller.toDateCon,
            readOnly: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12.0),
              filled: true,
              fillColor: Colors.white,
              hintStyle: TextStyle(
                fontSize: 14,
                color: AppColor.textColorlight,
              ),
              hintText: 'Select from date',
              errorText: _controller.toDateError.value.isEmpty
                  ? null
                  : _controller.toDateError.value,
              errorStyle: const TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
              suffixIcon: const Icon(Icons.date_range),
            ),
          ),
          hSizeBox20,
          title("Reason of leave :"),
          hSizeBox10,
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: DropdownButtonHideUnderline(
                child: Obx(
                  () => DropdownButton<Item>(
                    isExpanded: true,
                    value: _controller.selectedItem.value,
                    hint: Text(
                      "Select Leave Reason",
                      style: TextStyle(
                          fontSize: 14, color: AppColor.textColorlight),
                    ),
                    onChanged: (Item? newValue) {
                      _controller.selectedItem(newValue!);
                    },
                    items: _controller.users
                        .map((item) => DropdownMenuItem<Item>(
                              value: item,
                              child: Text(item.name),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          hSizeBox20,
          title("Description of leave :"),
          hSizeBox10,
          TextFormField(
            controller: _controller.description,
            maxLines: 6,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.secondaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColor.secondaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(12.0)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(12.0),
              filled: true,
              fillColor: Colors.white,
              hintStyle:
                  TextStyle(fontSize: 14, color: AppColor.textColorlight),
              hintText: 'Enter Description',
              errorText: _controller.descriptionError.value.isEmpty
                  ? null
                  : _controller.descriptionError.value,
              errorStyle: const TextStyle(fontSize: 14, color: Colors.red),
            ),
          ),
          hSizeBox20,
          title("Upload your attachments :"),
          hSizeBox10,
          Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: GestureDetector(
                  onTap: () async {
                    _modalBottomSheetMenu();
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    height: 80,
                    width: 65,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      children: <Widget>[
                        _roundedRectBorderWidget(),
                      ],
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    _controller.profileImage.value.path.isNotEmpty
                        ? "attachment.jpg"
                        : "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(color: Colors.black, fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              elevation: 1,
              color: CU.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: InkWell(
                  onTap: () {
                    if (_controller.valid()) {
                      _controller.callService();
                      log(_controller.profileImage.value.path.toString());
                    }
                  },
                  child: const Center(
                      child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Apply Leave',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                  ))),
            ),
          ),
        ],
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

  _modalBottomSheetMenu() async {
    return await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12.0), topLeft: Radius.circular(12.0)),
        ),
        context: Get.context!,
        builder: (builder) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  "Select Option",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () async {
                  Get.back();
                  await _controller.picImage(false);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.photo_camera,
                        size: 22,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: const Text(
                          "Camera",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              InkWell(
                onTap: () async {
                  Get.back();
                  await _controller.picImage(true);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.image,
                        size: 22,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 12),
                        child: const Text(
                          "Gallary",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _roundedRectBorderWidget() {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          color: CU.textColorhint),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Obx(
          () => Container(
            width: 55.0,
            height: 55.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: _controller.profileImage.value.path.isNotEmpty
                    ? FileImage(_controller.profileImage.value)
                    : const ExactAssetImage(AppImage.upload) as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget statusTab() {
    return Obx(
      () => _controller.isLoading.value
          ? const Center(child: CircularProgressIndicator.adaptive())
          : _controller.leaveList.isEmpty
              ? CU.getNodataDesign()
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: _controller.leaveList.length,
                  separatorBuilder: (context, index) => hSizeBox10,
                  itemBuilder: (context, index) {
                    var data = _controller.leaveList[index];

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        data.title!,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                hSizeBox8,
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              DateFormat("yyyy-MM-dd").format(
                                                  DateTime.parse(data.applyDate
                                                      .toString())),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Text(
                                              " Apply Date",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: CU.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        hSizeBox4,
                                        Row(
                                          children: [
                                            Text(
                                                "${DateFormat("dd-MM").format(DateTime.parse(data.fromDate.toString()))} - ${DateFormat("dd-MM").format(DateTime.parse(data.toDate.toString()))}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.black)),
                                            Text(
                                              "  Fromdate to To-Date",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: CU.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: data.status == null ||
                                              data.status == ""
                                          ? Image.asset(
                                              AppImage.pending,
                                              height: 22,
                                            )
                                          : data.status == "Approved" ||
                                                  data.status == "Approve"
                                              ? Image.asset(
                                                  AppImage.approve,
                                                  height: 22,
                                                )
                                              : Image.asset(
                                                  AppImage.reject,
                                                  height: 22,
                                                ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          data.status == ""
                                              ? "Pending"
                                              : data.status!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: data.status == ""
                                                ? CU.primaryColor
                                                : CU.secondaryColor,
                                          ),
                                        ),
                                        Text("Status",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 8,
                                                color: CU.textColorlight)),
                                      ],
                                    ),
                                  ],
                                ),
                                hSizeBox8,
                                Row(
                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "NOTE :",
                                      style: TextStyle(
                                        color: CU.secondaryColor,
                                        fontSize: 8,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        data.message!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 10),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            height: 1,
                            color: CU.textColorlight,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            child: data.status == ""
                                ? const Padding(
                                    padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
                                    child: Text(
                                      "Cancel Request :",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      data.replyOn.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: CU.secondaryColor,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
