// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ip_location_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IpLocationDataImpl _$$IpLocationDataImplFromJson(Map<String, dynamic> json) =>
    _$IpLocationDataImpl(
      ip: json['ip'] as String?,
      hostname: json['hostname'] as String?,
      continentCode: json['continent_code'] as String?,
      continentName: json['continent_name'] as String?,
      countryCode2: json['country_code2'] as String?,
      countryCode3: json['country_code3'] as String?,
      countryName: json['country_name'] as String?,
      countryCapital: json['country_capital'] as String?,
      stateProv: json['state_prov'] as String?,
      district: json['district'] as String?,
      city: json['city'] as String?,
      zipcode: json['zipcode'] as String?,
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
      isEu: json['is_eu'] as bool?,
      callingCode: json['calling_code'] as String?,
      countryTld: json['country_tld'] as String?,
      languages: json['languages'] as String?,
      countryFlag: json['country_flag'] as String?,
      geonameId: json['geoname_id'] as String?,
      isp: json['isp'] as String?,
      connectionType: json['connection_type'] as String?,
      organization: json['organization'] as String?,
      asn: json['asn'] as String?,
      currency: json['currency'] == null
          ? null
          : Currency.fromJson(json['currency'] as Map<String, dynamic>),
      timeZone: json['time_zone'] == null
          ? null
          : TimeZone.fromJson(json['time_zone'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$IpLocationDataImplToJson(
        _$IpLocationDataImpl instance) =>
    <String, dynamic>{
      'ip': instance.ip,
      'hostname': instance.hostname,
      'continent_code': instance.continentCode,
      'continent_name': instance.continentName,
      'country_code2': instance.countryCode2,
      'country_code3': instance.countryCode3,
      'country_name': instance.countryName,
      'country_capital': instance.countryCapital,
      'state_prov': instance.stateProv,
      'district': instance.district,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'is_eu': instance.isEu,
      'calling_code': instance.callingCode,
      'country_tld': instance.countryTld,
      'languages': instance.languages,
      'country_flag': instance.countryFlag,
      'geoname_id': instance.geonameId,
      'isp': instance.isp,
      'connection_type': instance.connectionType,
      'organization': instance.organization,
      'asn': instance.asn,
      'currency': instance.currency?.toJson(),
      'time_zone': instance.timeZone?.toJson(),
    };

_$CurrencyImpl _$$CurrencyImplFromJson(Map<String, dynamic> json) =>
    _$CurrencyImpl(
      code: json['code'] as String?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
    );

Map<String, dynamic> _$$CurrencyImplToJson(_$CurrencyImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'name': instance.name,
      'symbol': instance.symbol,
    };

_$TimeZoneImpl _$$TimeZoneImplFromJson(Map<String, dynamic> json) =>
    _$TimeZoneImpl(
      name: json['name'] as String?,
      offset: json['offset'] as int?,
      currentTime: json['current_time'] as String?,
      currentTimeUnix: (json['current_time_unix'] as num?)?.toDouble(),
      isDst: json['is_dst'] as bool?,
      dstSavings: json['dst_savings'] as int?,
    );

Map<String, dynamic> _$$TimeZoneImplToJson(_$TimeZoneImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'offset': instance.offset,
      'current_time': instance.currentTime,
      'current_time_unix': instance.currentTimeUnix,
      'is_dst': instance.isDst,
      'dst_savings': instance.dstSavings,
    };
