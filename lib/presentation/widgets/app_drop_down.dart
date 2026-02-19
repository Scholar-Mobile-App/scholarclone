import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';

class AppDropDown extends StatelessWidget {
  final String? title;
  final String? hintText;
  final EdgeInsets? margin;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
  final Rx<DropDownModel> selectedValue;
  final Function(DropDownModel?)? onChanged;
  final List<DropDownModel> dropdownList;

  const AppDropDown({
    super.key,
    this.title,
    this.focusNode,
    required this.dropdownList,
    this.hintText,
    required this.selectedValue,
    this.width,
    this.height,
    this.onChanged,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title ?? "",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        if (title != null) hSizeBox10,
        Obx(
          () => Container(
            height: height ?? 47,
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
            child: DropdownButton<DropDownModel>(
              focusNode: focusNode,
              key: key,
              value:
                  selectedValue.value.name.isEmpty ? null : selectedValue.value,
              icon: const Icon(Icons.keyboard_arrow_down, size: 30),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              items: dropdownList.map((DropDownModel dropDownModel) {
                return DropdownMenuItem<DropDownModel>(
                  value: dropDownModel,
                  child: FittedBox(
                    child: Text(
                      dropDownModel.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                );
              }).toList(),
              style: const TextStyle(color: Colors.amber),
              hint: FittedBox(
                child: Text(
                  hintText ?? title ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              underline: const SizedBox(),
              isExpanded: true,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}

class DropDownModel {
  final int id;
  final String name;
  const DropDownModel({required this.id, required this.name});
}
