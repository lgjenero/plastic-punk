// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ip_location_data.freezed.dart';
part 'ip_location_data.g.dart';

@freezed
class IpLocationData with _$IpLocationData {
  const factory IpLocationData({
    String? ip,
    String? hostname,
    @JsonKey(name: 'continent_code') String? continentCode,
    @JsonKey(name: 'continent_name') String? continentName,
    @JsonKey(name: 'country_code2') String? countryCode2,
    @JsonKey(name: 'country_code3') String? countryCode3,
    @JsonKey(name: 'country_name') String? countryName,
    @JsonKey(name: 'country_capital') String? countryCapital,
    @JsonKey(name: 'state_prov') String? stateProv,
    String? district,
    String? city,
    String? zipcode,
    String? latitude,
    String? longitude,
    @JsonKey(name: 'is_eu') bool? isEu,
    @JsonKey(name: 'calling_code') String? callingCode,
    @JsonKey(name: 'country_tld') String? countryTld,
    String? languages,
    @JsonKey(name: 'country_flag') String? countryFlag,
    @JsonKey(name: 'geoname_id') String? geonameId,
    String? isp,
    @JsonKey(name: 'connection_type') String? connectionType,
    String? organization,
    String? asn,
    Currency? currency,
    @JsonKey(name: 'time_zone') TimeZone? timeZone,
  }) = _IpLocationData;

  factory IpLocationData.fromJson(Map<String, dynamic> json) => _$IpLocationDataFromJson(json);
}

@freezed
class Currency with _$Currency {
  const factory Currency({
    String? code,
    String? name,
    String? symbol,
  }) = _Currency;

  factory Currency.fromJson(Map<String, dynamic> json) => _$CurrencyFromJson(json);
}

@freezed
class TimeZone with _$TimeZone {
  const factory TimeZone({
    String? name,
    int? offset,
    @JsonKey(name: 'current_time') String? currentTime,
    @JsonKey(name: 'current_time_unix') double? currentTimeUnix,
    @JsonKey(name: 'is_dst') bool? isDst,
    @JsonKey(name: 'dst_savings') int? dstSavings,
  }) = _TimeZone;

  factory TimeZone.fromJson(Map<String, dynamic> json) => _$TimeZoneFromJson(json);
}
