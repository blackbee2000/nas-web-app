import 'dart:async';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/themes/app_colors.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class DropdownWidget<T> extends DropdownSearch<T> {
  final bool hasBorder;
  final double borderSize;
  final double borderRadius;
  final double? popupBorderRadius;
  final double? popupHeight;
  final Color? enableColor;
  final Color? disableColor;
  final Color? errorColor;
  final Color? selectedTextColor;
  final double? selectedTextSize;
  final String? hintText;
  final Widget? icon;
  final Color? iconColor;
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;
  final EmptyBuilder? emptyWidget;
  final ErrorBuilder? errorWidget;
  final LoadingBuilder? loadingWidget;
  final PopupBuilder? containerWidget;
  final DropdownSearchPopupItemEnabled<T>? disabledItemFn;
  final bool showSelectedItems;
  final bool showSearchBox;

  DropdownWidget({
    this.hasBorder = false,
    this.borderSize = 1.0,
    this.borderRadius = 4.0,
    this.popupHeight,
    this.popupBorderRadius,
    this.hintText,
    this.enableColor,
    this.disableColor,
    this.errorColor,
    this.selectedTextColor,
    this.selectedTextSize,
    this.icon,
    this.iconColor,
    this.popupItemBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.loadingWidget,
    this.containerWidget,
    this.disabledItemFn,
    this.showSelectedItems = false,
    this.showSearchBox = false,
    super.key,
    super.onSaved,
    super.validator,
    super.autoValidateMode = AutovalidateMode.disabled,
    super.onChanged,
    super.items = const [],
    super.selectedItem,
    super.asyncItems,
    super.dropdownBuilder,
    super.clearButtonProps = const ClearButtonProps(),
    super.enabled,
    super.filterFn,
    super.itemAsString,
    super.compareFn,
    super.onBeforeChange,
    super.onBeforePopupOpening,
  }) : super(
          popupProps: PopupProps.menu(
            showSearchBox: showSearchBox,
            showSelectedItems: showSelectedItems,
            searchDelay: const Duration(milliseconds: 250),
            constraints: BoxConstraints(
              maxHeight: popupHeight ??
                  (items.isNotEmpty
                      ? items.length > 4
                          ? 220
                          : items.length * 55
                      : 55),
            ),
            itemBuilder: popupItemBuilder,
            emptyBuilder: emptyWidget,
            errorBuilder: errorWidget,
            loadingBuilder: loadingWidget,
            containerBuilder: containerWidget,
            disabledItemFn: disabledItemFn,
            searchFieldProps: TextFieldProps(
              padding: const EdgeInsets.all(AppDimension.mediumSpace),
              decoration: InputDecoration(
                hintText: S.current.enterInformation,
                hintStyle: const TextStyle(
                  color: AppColors.border,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: AppDimension.smallSpace,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.pink400),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppDimension.smallBorderRadius),
                  ),
                ),
              ),
            ),
            menuProps: MenuProps(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(popupBorderRadius ?? 8.0),
                  bottom: Radius.circular(popupBorderRadius ?? 8.0),
                ),
              ),
            ),
          ),
          dropdownButtonProps: DropdownButtonProps(
            icon: icon ??
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 24,
                ),
            padding: const EdgeInsets.only(right: AppDimension.smallSpace),
            constraints: const BoxConstraints(),
            color: iconColor ?? AppColors.greyText,
          ),
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: TextStyle(
              color: selectedTextColor ?? AppColors.blackText,
              fontSize: selectedTextSize ?? AppDimension.mediumFontSize,
              fontWeight: FontWeight.w400,
            ),
            dropdownSearchDecoration: InputDecoration(
              contentPadding: const EdgeInsets.fromLTRB(
                10.0,
                15,
                10.0,
                15,
              ),
              hintText: hintText,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.pink400),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.all(
                  Radius.circular(AppDimension.smallBorderRadius),
                ),
              ),
            ),
          ),
        );
}

class DropdownMultiWidget<T> extends StatelessWidget {
  final bool hasBorder;
  final double borderSize;
  final double? popupHeight;
  final String? hintText;
  final Widget? icon;
  final EdgeInsets contentPaddingBorder;
  final EdgeInsets contentPaddingNoBorder;
  final DropdownSearchPopupItemBuilder<T>? popupItemBuilder;
  final EmptyBuilder? emptyWidget;
  final ErrorBuilder? errorWidget;
  final LoadingBuilder? loadingWidget;
  final PopupBuilder? containerWidget;
  final DropdownSearchPopupItemEnabled<T>? disabledItemFn;
  final TextFieldProps searchFieldProps;
  final bool showSelectedItems;
  final Widget Function(BuildContext, List<T>)? dropdownBuilder;
  final List<T> selectItem;
  final List<T> items;
  final Function(List<T>)? onChanged;
  final String Function(T)? itemAsString;
  final String? Function(List<T>?)? validator;
  final double borderRadius;

  const DropdownMultiWidget({
    super.key,
    this.hasBorder = false,
    this.borderRadius = 4.0,
    this.borderSize = 1.0,
    this.popupHeight,
    this.hintText,
    this.contentPaddingBorder = const EdgeInsets.fromLTRB(10, 15, 10, 15),
    this.contentPaddingNoBorder = const EdgeInsets.fromLTRB(0, 15, 0, 15),
    this.icon,
    this.popupItemBuilder,
    this.emptyWidget,
    this.errorWidget,
    this.loadingWidget,
    this.containerWidget,
    this.disabledItemFn,
    this.searchFieldProps = const TextFieldProps(),
    this.showSelectedItems = false,
    this.dropdownBuilder,
    required this.selectItem,
    required this.items,
    this.onChanged,
    this.itemAsString,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<T>.multiSelection(
      popupProps: PopupPropsMultiSelection.menu(
        showSelectedItems: showSelectedItems,
        searchDelay: const Duration(milliseconds: 250),
        constraints: BoxConstraints(
          maxHeight: popupHeight ??
              (items.isNotEmpty
                  ? items.length > 4
                      ? 280
                      : (items.length * 50) + 80
                  : 130),
        ),
        itemBuilder: popupItemBuilder,
        emptyBuilder: emptyWidget,
        errorBuilder: errorWidget,
        loadingBuilder: loadingWidget,
        containerBuilder: containerWidget,
        disabledItemFn: disabledItemFn,
        searchFieldProps: searchFieldProps,
        menuProps: const MenuProps(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(8.0),
              bottom: Radius.circular(8.0),
            ),
          ),
        ),
      ),
      dropdownButtonProps: DropdownButtonProps(
        icon: icon ??
            const Icon(
              Icons.keyboard_arrow_down,
              size: 24,
            ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        color: AppColors.greyText,
      ),
      dropdownDecoratorProps: DropDownDecoratorProps(
        baseStyle: const TextStyle(
          color: AppColors.blackText,
          fontSize: AppDimension.mediumFontSize,
          fontWeight: FontWeight.w400,
        ),
        dropdownSearchDecoration: InputDecoration(
          contentPadding:
              hasBorder ? contentPaddingBorder : contentPaddingNoBorder,
          hintText: hintText,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.pink400),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.border),
            borderRadius: BorderRadius.all(
              Radius.circular(AppDimension.smallBorderRadius),
            ),
          ),
        ),
      ),
      dropdownBuilder: dropdownBuilder,
      selectedItems: selectItem,
      items: items,
      itemAsString: itemAsString,
      onChanged: onChanged,
      validator: validator,
    );
  }
}

class MultiSelectionItemWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onUnselect;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  const MultiSelectionItemWidget({
    super.key,
    required this.message,
    this.onUnselect,
    this.margin = const EdgeInsets.all(5.0),
    this.padding = const EdgeInsets.all(5.0),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(5.0),
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.pink50,
        borderRadius: borderRadius,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextWidget(text: message),
          ),
          const SizedBox(width: 5.0),
          GestureDetector(
            onTap: onUnselect,
            child: const Icon(
              Icons.close_outlined,
              size: 15,
            ),
          )
        ],
      ),
    );
  }
}

class DropdownLazyLoadingWidget<T> extends StatelessWidget {
  final GlobalKey<DropdownSearchState> _dropdownState = GlobalKey();
  final T? selectedItem;
  final List<T> items;
  final void Function(T?)? onChanged;
  final String Function(T)? itemAsString;
  final Widget Function(BuildContext, T, bool) itemBuilder;
  final Widget Function(BuildContext, String)? emptyBuilder;
  final double? popupHeight;
  final bool isLoadingMore;
  final bool enableDelete;
  final Icon deleteIcon;
  final double deleteIconSize;
  final Color deleteIconColor;
  final Future<List<T>> Function()? onLoadMore;
  final bool hasLoadMoreEffect;
  final EdgeInsetsGeometry contentPadding;
  final Widget Function(BuildContext, T?)? dropdownBuilder;
  final bool hasBorder;

  DropdownLazyLoadingWidget({
    super.key,
    this.hasBorder = false,
    this.selectedItem,
    required this.items,
    this.onChanged,
    this.itemAsString,
    this.popupHeight,
    required this.itemBuilder,
    this.isLoadingMore = false,
    this.enableDelete = false,
    this.deleteIcon = const Icon(Icons.cancel),
    this.deleteIconSize = 24,
    this.deleteIconColor = AppColors.greyText,
    this.onLoadMore,
    this.emptyBuilder,
    this.hasLoadMoreEffect = false,
    this.contentPadding = EdgeInsets.zero,
    this.dropdownBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownWidget<T>(
      key: _dropdownState,
      hasBorder: hasBorder,
      selectedItem: selectedItem,
      items: items,
      itemAsString: itemAsString,
      containerWidget: (ctx, widget) => Container(
        padding: contentPadding,
        constraints: BoxConstraints(
          maxHeight: popupHeight ??
              (items.isNotEmpty
                  ? items.length > 4
                      ? 220
                      : items.length * 55
                  : 55),
        ),
        child: DropdownLazyLoadingContentWidget<T>(
          parentState: _dropdownState.currentState,
          selectedItem: selectedItem,
          items: items,
          itemBuilder: itemBuilder,
          emptyBuilder: emptyBuilder,
          onChanged: onChanged,
          onLoadMore: onLoadMore,
          hasLoadMoreEffect: hasLoadMoreEffect,
        ),
      ),
      clearButtonProps: ClearButtonProps(
        isVisible: enableDelete,
        icon: deleteIcon,
        iconSize: deleteIconSize,
        color: deleteIconColor,
        onPressed: () {
          onChanged?.call(null);
        },
      ),
      dropdownBuilder: dropdownBuilder,
    );
  }
}

class DropdownLazyLoadingContentWidget<T> extends StatefulWidget {
  final DropdownSearchState? parentState;
  final T? selectedItem;
  final List<T> items;
  final Future<List<T>> Function()? onLoadMore;
  final Widget Function(BuildContext, T, bool) itemBuilder;
  final Widget Function(BuildContext, String)? emptyBuilder;
  final void Function(T?)? onChanged;
  final bool hasLoadMoreEffect;

  const DropdownLazyLoadingContentWidget({
    super.key,
    this.onLoadMore,
    required this.items,
    required this.itemBuilder,
    this.emptyBuilder,
    this.onChanged,
    this.selectedItem,
    required this.hasLoadMoreEffect,
    this.parentState,
  });

  @override
  State<DropdownLazyLoadingContentWidget<T>> createState() =>
      _DropdownLazyLoadingContentWidgetState<T>();
}

class _DropdownLazyLoadingContentWidgetState<T>
    extends State<DropdownLazyLoadingContentWidget<T>> {
  final ScrollController _scrollController = ScrollController();
  List<T> items = [];
  bool isLoadingMore = false;

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.atEdge) {
            bool isTop = notification.metrics.pixels == 0;
            if (!isTop && !isLoadingMore) {
              setState(() {
                isLoadingMore = true;
              });

              widget.onLoadMore?.call().then((value) async {
                setState(() {
                  isLoadingMore = false;
                });
                if (value.isEmpty) {
                  return;
                }

                final double lastMaxScrollExtent =
                    _scrollController.position.maxScrollExtent;
                setState(() {
                  _scrollController.animateTo(
                    lastMaxScrollExtent + 20,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeIn,
                  );
                });
              });
            }
          }
        }
        return false;
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: items.isNotEmpty
                ? ListView.builder(
                    key: ValueKey('${T.toString()}DropDownContent'),
                    controller: _scrollController,
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    itemBuilder: (lbCtx, index) {
                      final item = items[index];
                      return Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            widget.onChanged?.call(item);
                            widget.parentState?.closeDropDownSearch();
                          },
                          child: widget.itemBuilder(
                            lbCtx,
                            item,
                            item == widget.selectedItem,
                          ),
                        ),
                      );
                    },
                  )
                : widget.emptyBuilder != null
                    ? widget.emptyBuilder!.call(
                        context,
                        S.current.noData,
                      )
                    : Container(
                        width: screenSize.width,
                        height: 55,
                        alignment: Alignment.topCenter,
                        padding: const EdgeInsets.all(16),
                        child: TextWidget(
                          text: S.current.noData,
                        ),
                      ),
          ),
          widget.hasLoadMoreEffect
              ? Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(5.0),
                  child: const CircularProgressIndicator(),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class ClearButtonPropsWidget extends ClearButtonProps {
  const ClearButtonPropsWidget({
    super.icon = const Icon(Icons.cancel, size: 24),
    super.isVisible = false,
    super.iconSize = 24.0,
    super.visualDensity,
    super.padding = const EdgeInsets.all(8.0),
    super.alignment = Alignment.center,
    super.splashRadius,
    super.color = AppColors.greyText,
    super.focusColor,
    super.hoverColor,
    super.highlightColor,
    super.splashColor,
    super.disabledColor,
    super.mouseCursor = SystemMouseCursors.click,
    super.focusNode,
    super.autofocus = false,
    super.tooltip,
    super.enableFeedback = false,
    super.constraints,
    super.style,
    super.isSelected,
    super.selectedIcon,
    super.onPressed,
  });
}
