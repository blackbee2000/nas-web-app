import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/text_widget.dart';
import 'package:nasmobile/feature/app/controllers/report_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReportView extends BaseView<ReportController> {
  const ReportView({super.key});

  Widget _buildTitle({required String title}) => TextWidget(
        text: title,
        fontSize: AppDimension.largeFontSize,
        fontWeight: FontWeight.w700,
      );

  @override
  Widget build(BuildContext context) {
    List<_SalesData> data = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40)
    ];

    return Scaffold(
      appBar: AppBarWidget(titleName: S.current.report),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.fromLTRB(
          AppDimension.mediumSpace,
          0,
          AppDimension.mediumSpace,
          max(
            AppDimension.mediumSpace,
            MediaQuery.of(context).viewPadding.bottom,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(title: '1. Báo cáo lịch sử sử dụng'),
              const SizedBox(height: AppDimension.mediumSpace),
              SizedBox(
                width: double.infinity,
                height: Get.height / 3,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_SalesData, String>>[
                    ColumnSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppDimension.largeSpace),
              _buildTitle(title: '2. Báo cáo mẫu móng yêu thích'),
              const SizedBox(height: AppDimension.mediumSpace),
              SizedBox(
                width: double.infinity,
                height: Get.height / 3,
                child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries<_SalesData, String>>[
                    LineSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData sales, _) => sales.year,
                      yValueMapper: (_SalesData sales, _) => sales.sales,
                      name: 'Sales',
                      // Enable data label
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: AppDimension.largeSpace),
              _buildTitle(title: '3. Báo cáo cửa hàng yêu thích'),
              const SizedBox(height: AppDimension.mediumSpace),
              SizedBox(
                width: double.infinity,
                height: Get.height / 3,
                child: SfCircularChart(
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CircularSeries>[
                    PieSeries<_SalesData, String>(
                      dataSource: data,
                      xValueMapper: (_SalesData data, _) => data.year,
                      yValueMapper: (_SalesData data, _) => data.sales,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
