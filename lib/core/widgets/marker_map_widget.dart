import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nasmobile/core/constants/app_paths.dart';

class MarkerMapWidget extends StatelessWidget {
  const MarkerMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppPaths.icMarkerMap,
      width: 50,
    );
  }
}
