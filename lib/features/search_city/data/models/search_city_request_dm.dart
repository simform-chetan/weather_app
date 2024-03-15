import 'package:json_annotation/json_annotation.dart';

part 'search_city_request_dm.g.dart';

@JsonSerializable()
class SearchCityRequestDm {
  const SearchCityRequestDm({
    required this.name,
    required this.count,
  });

  final String name;
  final String count;

  factory SearchCityRequestDm.fromJson(Map<String, dynamic> json) =>
      _$SearchCityRequestDmFromJson(json);

  Map<String, String> toJson() =>
      Map<String, String>.from(_$SearchCityRequestDmToJson(this));
}
