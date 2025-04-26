import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nasmobile/core/services/base_service.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationServices extends BaseService {
  @override
  void onInit() async {
    await determinePosition();
    super.onInit();
  }

  void _showErrorLocation() {
    showErrorDialog(
      content: S.current.notGetGPS,
      onTap: () async {
        await Geolocator.openLocationSettings();
      },
    );
  }

  Future<Position?> determinePosition() async {
    try {
      LocationPermission permission;

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showErrorLocation();
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showErrorLocation();
        return null;
      }

      final locationPermission = await Permission.location.request();
      if (!locationPermission.isGranted) {
        _showErrorLocation();
        return null;
      }

      final currentPosition = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(milliseconds: 5000),
        ),
      );

      return currentPosition;
    } catch (_) {
      return null;
    }
  }

  Future handleCameraMap({
    required Completer<GoogleMapController> mapController,
    required LatLng latLng,
    double zoom = 14,
  }) async {
    final c = await mapController.future;
    final p = CameraPosition(
      target: latLng,
      zoom: zoom,
    );
    c.animateCamera(CameraUpdate.newCameraPosition(p));
  }

  Future findMyLocation({
    required Completer<GoogleMapController> mapController,
  }) async {
    final position = await determinePosition();
    if (position == null) {
      _showErrorLocation();
      return;
    }
    await handleCameraMap(
      mapController: mapController,
      latLng: LatLng(position.latitude, position.longitude),
    );
  }

  Future handleCameraMapWithBounds({
    required Completer<GoogleMapController> mapController,
    required List<LatLng> listMarkerCoordinate,
    required LatLng currentUserPosition,
    double paddingBound = 100,
  }) async {
    final c = await mapController.future;
    c.animateCamera(
      CameraUpdate.newLatLngBounds(
        boundsFromLatLngList(
          listMarkerCoordinate,
          currentUserPosition,
        ),
        paddingBound,
      ),
    );
  }

  LatLngBounds boundsFromLatLngList(
    List<LatLng> listMarkerCoordinate,
    LatLng currentUserPosition,
  ) {
    listMarkerCoordinate.add(currentUserPosition);

    var lngs = listMarkerCoordinate.map<double>((m) => m.longitude).toList();
    var lats = listMarkerCoordinate.map<double>((m) => m.latitude).toList();

    double topMost = lngs.reduce(max);
    double leftMost = lats.reduce(min);
    double rightMost = lats.reduce(max);
    double bottomMost = lngs.reduce(min);

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(rightMost, topMost),
      southwest: LatLng(leftMost, bottomMost),
    );

    return bounds;
  }
}
