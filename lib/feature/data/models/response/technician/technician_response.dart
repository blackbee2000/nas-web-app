import 'package:json_annotation/json_annotation.dart';
import 'package:nasmobile/feature/data/models/dto/technician/technician_model.dart';
import 'package:nasmobile/feature/data/models/response/base_response.dart';

part 'technician_response.g.dart';

@JsonSerializable()
class TechnicianResponse extends BaseResponse<TechnicianListModel> {
  TechnicianResponse({
    required super.succeeded,
    super.message,
    super.data,
  });

  factory TechnicianResponse.fromJson(Map<String, dynamic> json) =>
      _$TechnicianResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TechnicianResponseToJson(this);
}
