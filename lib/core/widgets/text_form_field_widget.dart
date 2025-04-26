import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';

class TextFormFieldWidget extends TextFormField {
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? fillColor;
  final bool? filled;
  final Widget? prefixIcon;
  final Size prefixIconSize;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final Size suffixIconSize;
  final Color? suffixIconColor;
  final EdgeInsetsGeometry? contentPadding;
  final FloatingLabelBehavior floatingLabelBehavior;
  final int errorMaxLines;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isBorder;

  TextFormFieldWidget({
    this.labelText,
    this.labelStyle = const TextStyle(
      color: AppColors.fourBlackText,
      fontSize: AppDimension.smallFontSize,
      fontWeight: FontWeight.w400,
    ),
    this.hintText,
    this.hintStyle = const TextStyle(
      color: AppColors.greyText,
      fontSize: AppDimension.largeFontSize,
      fontWeight: FontWeight.w400,
    ),
    this.fillColor,
    this.filled,
    this.prefixIcon,
    this.prefixIconSize = const Size(24, 24),
    this.prefixIconColor,
    this.suffixIcon,
    this.suffixIconSize = const Size(24, 24),
    this.suffixIconColor,
    this.contentPadding,
    this.floatingLabelBehavior = FloatingLabelBehavior.always,
    this.errorMaxLines = 1,
    this.isBorder = true,
    super.key,
    super.controller,
    super.initialValue,
    super.focusNode,
    super.keyboardType,
    super.textCapitalization = TextCapitalization.none,
    super.textInputAction,
    super.style = const TextStyle(
      color: AppColors.fourBlackText,
      fontSize: AppDimension.largeFontSize,
      fontWeight: FontWeight.w400,
    ),
    super.strutStyle,
    super.textDirection,
    super.textAlign = TextAlign.start,
    super.autofocus = false,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.obscuringCharacter = '•',
    super.obscureText = false,
    super.autocorrect = true,
    super.smartDashesType,
    super.smartQuotesType,
    super.enableSuggestions = true,
    super.maxLengthEnforcement,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.onChanged,
    super.onTap,
    super.onTapOutside,
    super.onEditingComplete,
    super.onFieldSubmitted,
    super.onSaved,
    super.validator,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor = AppColors.pink600,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.enableInteractiveSelection,
    super.selectionControls,
    super.buildCounter,
    super.scrollPhysics,
    super.autofillHints,
    super.autovalidateMode,
    super.scrollController,
    super.restorationId,
    super.enableIMEPersonalizedLearning = true,
    super.mouseCursor,
    super.contextMenuBuilder,
    this.border = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
    this.enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
    this.focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.pink400),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
    this.disabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
    this.errorBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
    this.focusedErrorBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.border),
      borderRadius: BorderRadius.all(
        Radius.circular(AppDimension.largeBorderRadius * 10),
      ),
    ),
  }) : super(
          decoration: InputDecoration(
            isDense: true,
            counterText: '',
            labelText: labelText,
            labelStyle: labelStyle,
            hintText: hintText,
            hintStyle: hintStyle,
            prefixIcon: prefixIcon,
            prefixIconColor: prefixIconColor ?? Colors.black,
            prefixIconConstraints: BoxConstraints(
              minWidth: prefixIconSize.width,
              minHeight: prefixIconSize.height,
            ),
            suffixIcon: suffixIcon,
            suffixIconColor: suffixIconColor ?? Colors.black,
            suffixIconConstraints: BoxConstraints(
              minWidth: suffixIconSize.width,
              minHeight: suffixIconSize.height,
            ),
            fillColor: fillColor,
            filled: filled,
            errorMaxLines: errorMaxLines,
            floatingLabelBehavior: floatingLabelBehavior,
            contentPadding: contentPadding ??
                const EdgeInsets.all(AppDimension.mediumSpace),
            border: isBorder ? border : InputBorder.none,
            enabledBorder: isBorder ? enabledBorder : InputBorder.none,
            focusedBorder: isBorder ? focusedBorder : InputBorder.none,
            disabledBorder: isBorder ? disabledBorder : InputBorder.none,
            errorBorder: isBorder ? errorBorder : InputBorder.none,
            focusedErrorBorder:
                isBorder ? focusedErrorBorder : InputBorder.none,
          ),
        );
}
