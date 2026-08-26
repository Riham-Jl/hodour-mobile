import 'package:json_annotation/json_annotation.dart';

part 'paginated_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PaginatedResponse<T> {
  @JsonKey(name: 'current_page')
  final int currentPage;

  final List<T> data;

  @JsonKey(name: 'first_page_url')
  final String? firstPageUrl;

  final int? from;

  @JsonKey(name: 'last_page')
  final int lastPage;

  @JsonKey(name: 'last_page_url')
  final String? lastPageUrl;

  @JsonKey(name: 'next_page_url')
  final String? nextPageUrl;

  final String? path;

  @JsonKey(name: 'per_page')
  final int perPage;

  @JsonKey(name: 'prev_page_url')
  final String? prevPageUrl;

  final int? to;
  final int total;

  PaginatedResponse({
    required this.currentPage,
    required this.data,
    this.firstPageUrl,
    this.from,
    required this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    required this.perPage,
    this.prevPageUrl,
    this.to,
    required this.total,
  });

  factory PaginatedResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$PaginatedResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PaginatedResponseToJson(this, toJsonT);
}