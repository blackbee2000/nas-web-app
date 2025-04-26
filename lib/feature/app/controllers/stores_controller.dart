import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nasmobile/core/extensions/dartz_extension.dart';
import 'package:nasmobile/core/route/app_routes.dart';
import 'package:nasmobile/core/services/location_services.dart';
import 'package:nasmobile/core/widgets/marker_map_widget.dart';
import 'package:nasmobile/core/widgets/store_filter/store_filter_controller.dart';
import 'package:nasmobile/core/widgets/store_filter/store_filter_widget.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';
import 'package:nasmobile/feature/domain/entities/store_entity.dart';
import 'package:nasmobile/feature/domain/repositories/store_repository.dart';
import 'package:nasmobile/generated/l10n.dart';
import 'package:widget_to_marker/widget_to_marker.dart';

class StoresController extends BaseController {
  late StoreRepository _storeRepository;
  late LocationServices locationServices;
  final isFilter = false.obs;
  Completer<GoogleMapController> ggController =
      Completer<GoogleMapController>();
  final initCamera = const CameraPosition(
    target: LatLng(10.7769, 106.7009),
    zoom: 14,
  );
  final marker = <Marker>{}.obs;
  final isMap = true.obs;
  final stores = <StoreEntity>[].obs;
  final _pageNumber = 1.obs;
  final _pageSize = 100;
  final search = TextEditingController();
  final tabs = [
    S.current.all,
    S.current.hot,
    S.current.favorite,
    S.current.recently,
  ].obs;
  final indexCurrentTab = 0.obs;

  @override
  void onInit() async {
    locationServices = Get.find();
    _storeRepository = Get.find();
    await getStores();
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) async {
    ggController = Completer<GoogleMapController>();
    if (!ggController.isCompleted) {
      ggController.complete(controller);
    }

    /// Get current position
    await locationServices.findMyLocation(
      mapController: ggController,
    );

    /// Call data
    await getStores();

    /// Set marker
    await setMarkerMap();
    await focusAndZoomMarkers();
  }

  Future<void> setMarkerMap() async {
    showLoading();
    marker.clear();
    for (var e in stores) {
      if (e.lat != 0 && e.lng != 0) {
        marker.add(
          Marker(
            markerId: MarkerId('Market ID ${e.id}'),
            position: LatLng(e.lat, e.lng),
            icon: await const MarkerMapWidget().toBitmapDescriptor(),
            onTap: () => onViewDetail(store: e),
          ),
        );
      }
    }
    marker.refresh();
    hideLoading();
  }

  void onChangeModeView() {
    isMap.value = !isMap.value;
  }

  Future<void> getStores() async {
    showLoading();
    final result = await _storeRepository.getListStore(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
    );
    hideLoading();

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    stores.value = result.asRight().items;
  }

  Future<void> onViewDetail({required StoreEntity store}) async {
    final result = await Get.toNamed(AppRoutes.storeDetail, arguments: store);

    if (result == null || result is! bool) return;

    if (result) {
      final result = await _storeRepository.getListStore(
        pageNumber: _pageNumber.value,
        pageSize: _pageSize,
      );

      if (result.isLeft()) {
        showErrorDialog(content: result.asLeft().message);
        return;
      }

      stores.value = result.asRight().items;
      stores.refresh();

      /// Set marker
      // marker.clear();
      // for (var e in stores) {
      //   if (e.lat != 0 && e.lng != 0) {
      //     marker.add(
      //       Marker(
      //         markerId: MarkerId('Market ID ${e.id}'),
      //         position: LatLng(e.lat, e.lng),
      //         icon: await const MarkerMapWidget().toBitmapDescriptor(),
      //         onTap: () => onViewDetail(store: e),
      //       ),
      //     );
      //   }
      // }
      // marker.refresh();
      // await focusAndZoomMarkers();
    }
  }

  Future<void> focusAndZoomMarkers() async {
    final determinePosition = await locationServices.determinePosition();

    final listMarkerCoordinate = stores
        .map(
          (e) => LatLng(e.lat, e.lng),
        )
        .toList();

    if (determinePosition == null) {
      showErrorDialog(
        content: S.current.notGetGPS,
      );
      return;
    }

    if (listMarkerCoordinate.isNotEmpty) {
      /// Zoom to cover markers and current position
      await locationServices.handleCameraMapWithBounds(
        mapController: ggController,
        listMarkerCoordinate: listMarkerCoordinate,
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

  Future<void> showFilter() async {
    await showBaseBottomSheet(
      widget: StoreFilterWidget(
        storeFilterController: StoreFilterController(),
      ),
    );
  }

  /// On search
  Future<void> onSearch({required String value}) async {
    final result = await _storeRepository.getListStore(
      pageNumber: _pageNumber.value,
      pageSize: _pageSize,
      searchText: value,
    );

    if (result.isLeft()) {
      showErrorDialog(content: result.asLeft().message);
      return;
    }

    stores.value = result.asRight().items;
    stores.refresh();

    /// Set marker
    // await setMarkerMap();
    // await focusAndZoomMarkers();
  }

  Future<void> likeStore({required StoreEntity store}) async {
    final result = await _storeRepository.likeStore(
      id: store.id,
      isFavorite: !store.isFavorite,
    );

    if (result.asRight()) {
      for (int i = 0; i < stores.length; i++) {
        if (store.id == stores[i].id) {
          stores[i] = stores[i].copyWith(isFavorite: !store.isFavorite);
        }
      }

      stores.refresh();
    }
  }
}
