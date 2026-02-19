import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:scholar_clone/core/utils/cu.dart';

import '../../core/utils/constant_sizebox.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.textColor,
    this.loader = false,
  });

  final String? text;
  final Function()? onTap;
  final bool loader;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: Get.width * 0.5,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: textColor != null ? 0 : 5,
          backgroundColor: color ?? CU.tprimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onTap,
        child: FittedBox(
          child: loader == true
              ? Center(
                  child: CircularProgressIndicator.adaptive(
                  backgroundColor: textColor ?? Colors.white,
                ))
              : Text(
                  text ?? "",
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}

dateTimeTextField({
  DateTime? date,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String? title,
  String error = "",
  Function(dynamic)? onTap,
  required BuildContext context,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();

            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: initialDate ?? date,
              firstDate: firstDate ?? DateTime(1950, 8),
              lastDate: lastDate ?? DateTime(2101),
            );
            if (picked != null && picked != date) {
              onTap!(picked);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    date == null
                        ? "dd/mm/yyyy"
                        : "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}",
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );

monthTextField({
  DateTime? date,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String? title,
  String error = "",
  Function(dynamic)? onTap,
  required BuildContext context,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () async {
            FocusScope.of(context).unfocus();

            final DateTime? picked = await showMonthPicker(
              context: context,
              initialDate: initialDate ?? date,
              firstDate: firstDate ?? DateTime(1950, 8),
              lastDate: lastDate ?? DateTime(2101),
            );
            if (picked != null && picked != date) {
              onTap!(picked);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    date == null
                        ? "mm/yyyy"
                        : DateFormat("MMM-yyyy").format(date),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                const Icon(
                  Icons.calendar_today,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );

filePickField({
  XFile? imageFile,
  String? title,
  String error = "",
  Function(dynamic)? onTap,
  required BuildContext context,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: Colors.black,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black12,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  imageFile != null
                      ? imageFile.path.split('/').last.isEmpty
                          ? "Choose"
                          : imageFile.path.split('/').last
                      : "Choose",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (imageFile!.path.isEmpty)
                SizedBox(
                  height: 25,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      side: const BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text("Camera"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    ImagePicker()
                                        .pickImage(
                                          source: ImageSource.camera,
                                        )
                                        .then(onTap!);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.image),
                                  title: const Text("Gallery"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    ImagePicker()
                                        .pickImage(
                                          source: ImageSource.gallery,
                                        )
                                        .then(onTap!);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Choose File",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                )
            ],
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );

dropDownTextField({
  String? title,
  List<String>? list,
  String error = "",
  Key? key,
  Function(String?)? onChanged,
}) {
  log("--------");
  log(list.toString());

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      hSizeBox10,
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              color: Colors.black12,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: DropdownButtonFormField(
            isExpanded: true,
            key: key,
            items: list!.map((String? category) {
              return DropdownMenuItem(
                value: category ?? "",
                child: Text(category!),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: onChanged!,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Select",
              hintStyle: TextStyle(color: Colors.black87),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      error.isEmpty ? Text(error) : const SizedBox(),
    ],
  );
}

timeField({
  String? title,
  TimeOfDay? time,
  String error = "",
  Function(dynamic)? onTap,
  required BuildContext context,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? "",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () async {
            showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            ).then(onTap!);
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              border: Border.all(
                color: Colors.black,
              ),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Text(
              time == null
                  ? "hh/mm/ss"
                  : "${time.hour}:${time.minute} ${time.period.toString().split(".")[1]}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );
