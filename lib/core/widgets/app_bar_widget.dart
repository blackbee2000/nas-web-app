import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/constants/app_paths.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? imagePath;
  final String titleName;
  final Widget? leading;
  final Color? backgroundColor;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;
  final VoidCallback? onLeadingTap;
  final Color? leadingColor;
  final double? leadingWidth;
  final double elevation;
  final double scrolledUnderElevation;
  final bool centerTitle;
  final Widget? customeTitle;
  final double heightAppBar;
  final Color titleColor;
  final ShapeBorder? shape;
  final bool isBorderRadiusBackgroundImage;
  final Color colorLeading;

  const AppBarWidget({
    super.key,
    this.imagePath,
    required this.titleName,
    this.leading,
    this.actions,
    this.bottom,
    this.backgroundColor,
    this.onLeadingTap,
    this.leadingColor,
    this.leadingWidth,
    this.elevation = 0,
    this.scrolledUnderElevation = 0,
    this.centerTitle = true,
    this.customeTitle,
    this.heightAppBar = 60,
    this.titleColor = AppColors.blackText,
    this.shape,
    this.isBorderRadiusBackgroundImage = true,
    this.colorLeading = AppColors.blackText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      scrolledUnderElevation: scrolledUnderElevation,
      centerTitle: centerTitle,
      title: customeTitle ??
          TextWidget(
            text: titleName,
            fontSize: AppDimension.extraLargeFontSize + 2,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
      flexibleSpace: imagePath != null
          ? Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: isBorderRadiusBackgroundImage
                    ? const BorderRadius.only(
                        bottomLeft: Radius.circular(
                          (AppDimension.largeBorderRadius + 4) * 2,
                        ),
                        bottomRight: Radius.circular(
                          (AppDimension.largeBorderRadius + 4) * 2,
                        ),
                      )
                    : null,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    spreadRadius: 1,
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(imagePath!),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : const SizedBox(),
      backgroundColor: backgroundColor ?? Colors.white,
      leading: leadingWidth == 0
          ? null
          : leading ??
              IconButton(
                onPressed: onLeadingTap ?? Get.back,
                icon: SvgPicture.asset(
                  AppPaths.icArrowLeft,
                  colorFilter: ColorFilter.mode(colorLeading, BlendMode.srcIn),
                ),
              ),
      leadingWidth: leadingWidth,
      actions: actions != null
          ? [
              ...actions!,
              const SizedBox(width: 4.0),
            ]
          : null,
      bottom: bottom,
      shape: shape,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(heightAppBar);
}
