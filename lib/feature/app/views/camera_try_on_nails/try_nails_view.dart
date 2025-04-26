import 'package:flutter/material.dart';
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/widgets/app_bar_widget.dart';
import 'package:nasmobile/core/widgets/rounded_button_widget.dart';
import 'package:nasmobile/feature/app/controllers/camera_try_on_nails/try_nails_controller.dart';
import 'package:nasmobile/feature/app/views/base_view.dart';
import 'package:nasmobile/generated/l10n.dart';

class TryNailsView extends BaseView<TryNailsController> {
  const TryNailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        titleName: S.current.tryNailSamples,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(AppDimension.mediumSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedButtonWidget(
              onPressed: () async => await controller.getGroupLenses(),
              text: S.current.lensList,
            ),
            const SizedBox(height: AppDimension.mediumSpace),
            RoundedButtonWidget(
              onPressed: () async => await controller.initCameraKit(),
              text: S.current.openLens,
            ),
          ],
        ),
      ),
    );
  }
}
