import 'dart:async';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/services/location_services.dart';
import 'package:nasmobile/core/utils/distance_position_util.dart';
import 'package:nasmobile/core/widgets/marker_map_widget.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/repositories/store_repository.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StoreDetailController extends BaseController {
  late LocationServices locationServices;
  late StoreRepository _storeRepository;
  Completer<GoogleMapController> ggController =
      Completer<GoogleMapController>();
  final initCamera = const CameraPosition(
    target: LatLng(10.8692605, 106.5870364),
    zoom: 14,
  ).obs;
  final marker = <Marker>{}.obs;
  final Rxn<StoreEntity> store = Rxn();

  @override
  void onInit() async {
    locationServices = Get.find();
    _storeRepository = Get.find();
    await getStoreDetail();
    super.onInit();
  }

  Future<void> getStoreDetail() async {
    if (Get.arguments == null) return;
    if (Get.arguments is! StoreEntity) return;

    showLoading();
    final result = await _storeRepository.getStoreDetail(
      id: (Get.arguments as StoreEntity).id,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    store.value = result.asRight();
  }

  void onMapCreated(GoogleMapController controller) async {
    ggController = Completer<GoogleMapController>();
    if (!ggController.isCompleted) {
      ggController.complete(controller);
    }

    /// Set marker
    await setMarkerMap();
    await focusAndZoomMarkers();
  }

  Future<void> setMarkerMap() async {
    marker.clear();
    if (store.value != null && store.value!.lat != 0 && store.value!.lng != 0) {
      marker.add(
        Marker(
          markerId: MarkerId('Market ID ${store.value!.id}'),
          position: LatLng(store.value!.lat, store.value!.lng),
          icon: await const MarkerMapWidget().toBitmapDescriptor(),
          onTap: () {},
        ),
      );
    }
    marker.refresh();
  }

  void onView360Store() {
    Get.toNamed(
      AppRoutes.view360Store,
      arguments: store.value?.imageUrls.first,
    );
  }

  Future<void> focusAndZoomMarkers() async {
    final determinePosition = await locationServices.determinePosition();
    if (determinePosition == null) {
      showErrorDialog(
        content: S.current.notGetGPS,
      );
      return;
    }

    store.value!.distance.value = await DistancePositionUtil.calculateDistance(
      start: LatLng(determinePosition.latitude, determinePosition.longitude),
      end: LatLng(store.value?.lat ?? 0, store.value?.lng ?? 0),
    );
    if (store.value != null && store.value!.lat != 0 && store.value!.lng != 0) {
      /// Zoom to cover markers and current position
      await locationServices.handleCameraMapWithBounds(
        paddingBound: 50,
        mapController: ggController,
        listMarkerCoordinate: [LatLng(store.value!.lat, store.value!.lng)],
        currentUserPosition: LatLng(
          determinePosition.latitude,
          determinePosition.longitude,
        ),
      );
    } else {
      /// Zoom to focus on the current position
      await locationServices.handleCameraMap(
        mapController: ggController,
        latLng: LatLng(
          determinePosition.latitude,
          determinePosition.longitude,
        ),
      );
    }
  }

  Future<void> likeStore() async {
    final result = await _storeRepository.likeStore(
      id: store.value!.id,
      isFavorite: !store.value!.isFavorite,
    );

    if (result.asRight()) {
      store.value = store.value!.copyWith(isFavorite: !store.value!.isFavorite);
      store.refresh();

      /// Set marker
      await setMarkerMap();
      await focusAndZoomMarkers();
    }
  }
}
