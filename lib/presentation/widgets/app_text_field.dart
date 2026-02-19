import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scholar_clone/core/utils/constant_sizebox.dart';

textField(
        {String? title,
        String? hintText,
        String error = "",
        Function(String)? onChanged,
        int maxLine = 1,
        TextInputType? textInputType}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title!.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        hSizeBox10,
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: title.isNotEmpty ? Colors.black : Colors.grey.shade400,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: title.isNotEmpty ? Colors.black12 : Colors.transparent,
              ),
            ],
          ),
          child: TextFormField(
            onChanged: onChanged!,
            maxLines: maxLine,
            keyboardType: textInputType,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );

textFieldController(
  TextEditingController messageController, {
  String? title,
  String? hintText,
  String error = "",
  Function(String)? onChanged,
  int maxLine = 1,
  bool isOnlyRead = false,
}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title!.isNotEmpty)
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(
              color: title.isNotEmpty ? Colors.black : Colors.grey.shade400,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: title.isNotEmpty ? Colors.black12 : Colors.transparent,
              ),
            ],
          ),
          child: TextFormField(
            readOnly: isOnlyRead,
            controller: messageController,
            onChanged: onChanged,
            maxLines: maxLine,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(15),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black87),
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );

dateRangeTimeWRT({
  String? date,
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
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2015),
              lastDate: DateTime.now(),
            ).then(onTap!);
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
                    date == "" || date == null
                        ? "dd/mm/yyyy"
                        : DateFormat("dd/MM/yyyy").format(DateTime.parse(date)),
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

dateRangeTimeTextField({
  DateTime? date,
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
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2025, 8),
            ).then(onTap!);
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

dropDownTextFieldSearch(
        {String? title,
        List<String>? list,
        String error = "",
        required void Function(String?)? onChanged}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
        ),
        Container(
          height: 40,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.all(5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade100,
            ),
          ),
          child: DropdownButtonFormField(
            isExpanded: false,
            items: list!.map((String category) {
              return DropdownMenuItem(
                value: category,
                child: Text(category),
              );
            }).toList(),
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: onChanged,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "Select",
              hintStyle: TextStyle(color: Colors.black87),
            ),
          ),
        ),
        error.isEmpty ? Text(error) : const SizedBox(),
      ],
    );
