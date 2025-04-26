import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as map_launcher;
import 'package:nasmobile/core/constants/app_dimension.dart';
import 'package:nasmobile/core/utils/launcher_util.dart';
import 'package:nasmobile/core/utils/log_util.dart';
import 'package:nasmobile/core/widgets/dialog_customer_widget.dart';
import 'package:nasmobile/generated/l10n.dart';

class DistancePositionUtil {
  DistancePositionUtil._();

  static int limitedDistanceInMeters = 1000;

  /// Format distance
  static String formatDistance({required double distance}) {
    if (distance < limitedDistanceInMeters) {
      return '${distance.round()} m';
    } else {
      return '${(distance / 1000).toStringAsFixed(1)} km';
    }
  }

  /// Calculate distance
  static Future<double> calculateDistance({
    required LatLng start,
    required LatLng end,
  }) async {
    final double distance = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );

    return distance;
  }

  static String getGGMapUrl() {
    if (Platform.isIOS) {
      return 'https://apps.apple.com/vn/app/google-maps/id585027354';
    } else if (Platform.isAndroid) {
      return 'https://play.google.com/store/apps/details?cat=-1&id=com.google.android.apps.maps';
    }

    return '';
  }

  // Open installed map or default map
  static void openMapDirection({required LatLng latLng}) async {
    try {
      bool? isGoogleMapInstalled =
          await map_launcher.MapLauncher.isMapAvailable(
        map_launcher.MapType.google,
      );
      if (isGoogleMapInstalled!) {
        await map_launcher.MapLauncher.showDirections(
          destination: map_launcher.Coords(
            latLng.latitude,
            latLng.longitude,
          ),
          mapType: map_launcher.MapType.google,
        );
      } else {
        Get.bottomSheet(
          ErrorDialog(
            title: S.current.fail,
            content: S.current.pleaseInstallGGMap,
            onTap: () => LauncherUtil.launchInBrowser(getGGMapUrl()),
            textButton: S.current.close,
          ),
          isScrollControlled: true,
          enableDrag: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppDimension.largeBorderRadius),
            ),
          ),
          enterBottomSheetDuration: const Duration(milliseconds: 300),
          exitBottomSheetDuration: const Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          isDismissible: true,
        );
      }
    } catch (_) {
      Get.bottomSheet(
        ErrorDialog(
          title: S.current.fail,
          content: S.current.errorHappen,
          onTap: Get.back,
          textButton: S.current.close,
        ),
        isScrollControlled: true,
        enableDrag: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimension.largeBorderRadius - 4),
          ),
        ),
        enterBottomSheetDuration: const Duration(milliseconds: 300),
        exitBottomSheetDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        isDismissible: true,
      );
    }
  }

  /// Convert decimal to DMS (Degree Minute Second)
  static String convertLatLng(double decimal, bool isLat) {
    try {
      String degree = "${decimal.toString().split(".")[0]}°";
      double minutesBeforeConversion =
          double.parse("0.${decimal.toString().split(".")[1]}");
      String minutes =
          "${(minutesBeforeConversion * 60).toString().split('.')[0]}'";
      double secondsBeforeConversion = double.parse(
          "0.${(minutesBeforeConversion * 60).toString().split('.')[1]}");
      String seconds =
          '${double.parse((secondsBeforeConversion * 60).toString()).toStringAsFixed(2)}" ';
      return "$degree$minutes$seconds${isLat ? decimal > 0 ? 'N' : 'S' : decimal > 0 ? 'E' : 'W'}";
    } catch (e) {
      LogUtil.logDebug(e.toString());
      return decimal.toString();
    }
  }

  static Future<String?> gpsAddress(double latitude, double longitude) async {
    // Get GPS Address
    final gpsResult = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    LogUtil.logDebug(gpsResult.length);

    if (gpsResult.isEmpty) {
      return null;
    }

    final placeMark = gpsResult.first;
    final String gpsAddress = [
      placeMark.street ?? '',
      placeMark.subLocality ?? '',
      placeMark.subAdministrativeArea ?? '',
      placeMark.administrativeArea ?? '',
    ].where((element) => element.isNotEmpty).join(', ');

    return gpsAddress;
  }
}
