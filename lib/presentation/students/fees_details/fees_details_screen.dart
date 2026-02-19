import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_color.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/fees_details/view_receipt/receipt_view_screen.dart';
import 'package:scholar_clone/presentation/students/fees_details/fees_details_controller.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';
import 'package:scholar_clone/presentation/widgets/app_button.dart';
import 'package:scholar_clone/presentation/widgets/download_manager.dart';

class FeesDetailsScreen extends StatelessWidget {
  FeesDetailsScreen({super.key});

  final FeesDetailsController _controller = Get.put(FeesDetailsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Fees",
          rounded: false,
        ),
        body: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 30,
                    bottom: 100,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                      bottomLeft: Radius.circular(50),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          text: "Pending Fees",
                          onTap: () {
                            _controller.tabIndex.value = 0;
                          },
                          textColor: _controller.tabIndex.value == 0
                              ? null
                              : Colors.black,
                          color: _controller.tabIndex.value == 0
                              ? AppColor.tprimaryColor
                              : Colors.white,
                        ),
                      ),
                      wSizeBox20,
                      Expanded(
                        child: AppButton(
                          text: "Paid Fees",
                          onTap: () {
                            _controller.tabIndex.value = 1;
                          },
                          textColor: _controller.tabIndex.value == 1
                              ? null
                              : Colors.black,
                          color: _controller.tabIndex.value == 1
                              ? AppColor.tprimaryColor
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -60,
                  right: 20,
                  left: 20,
                  child: Container(
                    width: Get.width,
                    padding: const EdgeInsets.all(20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _controller.tabIndex.value == 0
                              ? "Total Pending Fees"
                              : "Total Paid Fees",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.textColor,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          _controller.tabIndex.value == 0
                              ? "\u{20B9}${(_controller.convertCurrencyTransaction(_controller.unPaidAmount.value.toString()))}"
                              : "\u{20B9}${_controller.convertCurrencyTransaction(_controller.paidAmount.value.toString())}",
                          style: TextStyle(
                            color: _controller.tabIndex.value == 0
                                ? Colors.red
                                : Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            hBox(60),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 20,
                    bottom: 15,
                  ),
                  child: Text(
                    "Fees Summary",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColor.textColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: _controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : _controller.tabIndex.value == 0
                      ? _controller.unPaidList.isEmpty
                          ? CU.getNodataDesign()
                          : pendingFees()
                      : _controller.paidList.isEmpty
                          ? CU.getNodataDesign()
                          : paidFees(),
            )
          ],
        ),
      ),
    );
  }

  ListView pendingFees() {
    return ListView.separated(
      separatorBuilder: (context, index) => hSizeBox16,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      shrinkWrap: true,
      itemCount: _controller.unPaidList.length,
      itemBuilder: (context, index) {
        var data = _controller.unPaidList[index];
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
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.month ?? "--",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: CU.textColor,
                        fontSize: 12,
                      ),
                    ),
                    hSizeBox10,
                    if (data.paynow != null && data.paynow != "")
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.all(8.0),
                        ),
                        onPressed: () {
                          launchURL(data.paynow ?? "");
                        },
                        child: const Text(
                          "Pay Now",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                  ],
                ),
              ),
              Text(
                "\u{20B9}${data.remain ?? "00"}.00",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: CU.textColor,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ListView paidFees() {
    return ListView.separated(
      separatorBuilder: (context, index) => hSizeBox16,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      shrinkWrap: true,
      itemCount: _controller.paidList.length,
      itemBuilder: (context, index) {
        var data = _controller.paidList[index];
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
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "\u{20B9}${data.paidAmount ?? "00"}.00",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: CU.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              hSizeBox14,
              d(),
              textContainer(
                title: "Rec. No",
                content: data.receiptNo!,
              ),
              textContainer(
                title: "Payment Date",
                content:
                    "${data.receiptdate!.day.toString().padLeft(2, "0")}/${data.receiptdate!.month.toString().padLeft(2, "0")}/${data.receiptdate!.year.toString()}",
              ),
              textContainer(
                title: "Payment Mode",
                content: data.paymentMode!,
              ),
              textContainer(
                title: "Bank Name",
                content: data.bankName ?? "--",
              ),
              textContainer(
                title: "Bank Branch",
                content: data.bankBranch ?? "--",
              ),
              textContainer(
                title: "Cheque/ DD No.",
                content: data.chequeNo ?? "--",
              ),
              hSizeBox14,
              d(),
              hSizeBox14,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      onPressed: () {
                        Get.to(
                          () => ReceiptViewScreen(
                            htmltext: data.feesHtml ??
                                "<center><h1>No Data Found</h1></center>",
                            userInfo: _controller.userInfo,
                            receiptID: data.receiptNo!,
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                      ),
                      child: const Text(
                        "View Receipt",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  d() => Container(
        width: Get.width,
        height: 0.3,
        color: Colors.grey,
      );

  textContainer({
    required String title,
    required String content,
  }) =>
      Column(
        children: [
          hSizeBox14,
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
}
