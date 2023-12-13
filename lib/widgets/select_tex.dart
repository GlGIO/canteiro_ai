import 'package:canteiro_ai/core/colors_theme.dart';
import 'package:flutter/material.dart';

class SelectText<T> extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  const SelectText({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    required this.dropdownMenuEntries,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 30, bottom: 10),
            child: Text(
              label!,
              style: const TextStyle(fontSize: 14, color: ColorsTheme.primary),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: ColorsTheme.backgroundField,
            border: Border.all(
              color: ColorsTheme.borderFieldSearch,
              width: 1,
            ),
          ),
          child: DropdownMenu<T>(
            width: MediaQuery.of(context).size.width * 0.84,
            enabled: true,
            hintText: hintText,
            textStyle: TextStyle(
              fontFamily: 'roboto-regular',
              overflow: TextOverflow.ellipsis,
              color: ColorsTheme.textGrey,
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: const EdgeInsets.symmetric(horizontal: 27),
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: ColorsTheme.hintTextColor,
              ),
            ),
            menuStyle: MenuStyle(
              maximumSize: MaterialStatePropertyAll(
                Size(MediaQuery.of(context).size.width * 0.84,
                    MediaQuery.of(context).size.height * 0.5),
              ),
            ),
            trailingIcon: const Icon(
              Icons.arrow_drop_down,
              color: ColorsTheme.primary,
            ),
            controller: controller,
            dropdownMenuEntries: dropdownMenuEntries,
          ),
        ),
      ],
    );
  }
}
