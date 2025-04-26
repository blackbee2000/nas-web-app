import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nasmobile/core/widgets/form_rating/data_form_rating.dart';
import 'package:nasmobile/feature/app/controllers/base_controller.dart';

class FormRatingController extends BaseController {
  final DataFormRating dataFormRating;
  final rating = 0.0.obs;
  final note = TextEditingController();

  final technicianRating = 0.0.obs;
  final noteTechnician = TextEditingController();
  final isPrivate = false.obs;

  FormRatingController({required this.dataFormRating});

  @override
  void onInit() {
    _initData();
    super.onInit();
  }

  void _initData() {
    rating.value = dataFormRating.rating;
    note.text = dataFormRating.note ?? '';
  }

  void onConfirm() {
    Get.back(
      result: DataFormRating(rating: rating.value, note: note.text),
    );
  }
}
