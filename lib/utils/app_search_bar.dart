import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_icons.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_text_style.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_functions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';


class AppSearchBar extends StatefulWidget {
  final TextEditingController searchController;
  final String? hintText;
  final bool? shadow;
  final BoxBorder? border;
  final bool autoFocus;
  final Function(String)? onChanged;
  final Function()? onClear;
  final Function(String)? onFieldSubmitted;
  const AppSearchBar({super.key, required this.searchController, this.hintText, this.shadow, this.border, this.autoFocus = false ,this.onChanged,this.onClear, this.onFieldSubmitted});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {

  late VoidCallback _listener;

  @override
  void initState() {
    // TODO: implement initState
    _listener = () {
      if (mounted) {
        setState(() {});
      }
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.searchController!.addListener(_listener);
    });
      super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: const EdgeInsets.only(left: 10),
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color:  AppColors.searchFillColor,
          borderRadius: BorderRadius.circular(25),
          boxShadow:  [
            if(widget.shadow == true)
              const BoxShadow(
                color: Colors.black26,
                offset: Offset(0.0, 2.0),
                blurRadius: 2.5,
              ),
          ],
          border: widget.border ?? Border.all(color: AppColors.borderColor, width: 1)
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppIcons.svg.search, width: 20),
          10.width,
          Expanded(
            child: TextFormField(
              controller: widget.searchController,
              cursorColor:  AppColors.primaryTextColor,
              keyboardType: TextInputType.text,
              autofocus: widget.autoFocus,
              textAlignVertical: TextAlignVertical.center,
              decoration:  InputDecoration(
                fillColor: AppColors.textFieldFillColor,
                alignLabelWithHint: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: widget.hintText ?? "Search...",
                hintStyle: AppTextStyle.bodyGreyColor.copyWith(color: AppColors.greyTextColor, fontWeight: FontWeight.w500, fontSize: 16),
                isCollapsed: true,
                isDense: true,
              ),
              onChanged: widget.onChanged,
              onFieldSubmitted: widget.onFieldSubmitted,
            ),
          ),

          if(widget.searchController.text.isNotEmpty)
          IconButton(
            onPressed: widget.onClear ?? () {
              widget.searchController.clear();
              commonHideKeyboard(context);
              },
            icon:  const Icon(CupertinoIcons.clear, color: AppColors.greyIconColor, size: 20),
          )
        ],
      ),
    );
  }
}