import 'package:flutter/material.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/app_colors.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/common_widgets.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/constant_variables.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/int_extensions.dart';
import 'package:flutter_mvvm_bloc_cubit/utils/extensions/widget_extensions.dart';


class TabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
   TabBarDelegate(this.tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          30.height,
          Container(
            height: 50,
            width: double.infinity,
            padding: const EdgeInsets.all(0),
            decoration: commonContainerDecoration(
              borderRadius: BorderRadius.circular(50),
              borderColor: AppColors.secondaryColor,
              borderWidth: 1,
              color: AppColors.searchFillColor
            ),
            child: tabBar,
          ),
        ],
      ).paddingSymmetric(horizontal: commonSafeAreaPadding),
    );
  }

  @override
  double get maxExtent => 90;

  @override
  double get minExtent => 90;

  @override
  bool shouldRebuild(covariant TabBarDelegate oldDelegate) {
    return tabBar != oldDelegate.tabBar;
  }
}
