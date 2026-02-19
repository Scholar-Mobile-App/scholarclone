import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/app_image.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';
import 'package:scholar_clone/core/utils/cu.dart';
import 'package:scholar_clone/presentation/students/certificate/certificate_controller.dart';
import 'package:scholar_clone/presentation/students/certificate/certificate_view/certificate_view_screen.dart';
import 'package:scholar_clone/presentation/widgets/app_bar.dart';

class CertificateScreen extends StatelessWidget {
  CertificateScreen({super.key});
  final CertificateController _controller = Get.put(CertificateController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: appbar(
          "Certificate",
          rounded: false,
        ),
        body: _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator.adaptive())
            : _controller.certificateList.isEmpty
                ? CU.getNodataDesign()
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    itemCount: _controller.certificateList.length,
                    separatorBuilder: (context, index) => hSizeBox20,
                    itemBuilder: (context, index) {
                      var data = _controller.certificateList[index];

                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CertificateViewScreen(
                                html: data.certificateHtml,
                              ));
                        },
                        child: Container(
                          padding: const EdgeInsets.only(bottom: 25),
                          alignment: Alignment.bottomCenter,
                          height: 190,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: getMedal(data.certificateNumber!),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Text(
                            data.certificateType ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }

  getMedal(String certificateNumber) {
    if (certificateNumber == "1") {
      return const ExactAssetImage(AppImage.gold);
    } else if (certificateNumber == "2") {
      return const ExactAssetImage(AppImage.silver);
    } else {
      return const ExactAssetImage(AppImage.bronz);
    }
  }
}
