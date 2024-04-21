// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ip_location_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IpLocationData _$IpLocationDataFromJson(Map<String, dynamic> json) {
  return _IpLocationData.fromJson(json);
}

/// @nodoc
mixin _$IpLocationData {
  String? get ip => throw _privateConstructorUsedError;
  String? get hostname => throw _privateConstructorUsedError;
  @JsonKey(name: 'continent_code')
  String? get continentCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'continent_name')
  String? get continentName => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_code2')
  String? get countryCode2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_code3')
  String? get countryCode3 => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_name')
  String? get countryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_capital')
  String? get countryCapital => throw _privateConstructorUsedError;
  @JsonKey(name: 'state_prov')
  String? get stateProv => throw _privateConstructorUsedError;
  String? get district => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  String? get zipcode => throw _privateConstructorUsedError;
  String? get latitude => throw _privateConstructorUsedError;
  String? get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_eu')
  bool? get isEu => throw _privateConstructorUsedError;
  @JsonKey(name: 'calling_code')
  String? get callingCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_tld')
  String? get countryTld => throw _privateConstructorUsedError;
  String? get languages => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_flag')
  String? get countryFlag => throw _privateConstructorUsedError;
  @JsonKey(name: 'geoname_id')
  String? get geonameId => throw _privateConstructorUsedError;
  String? get isp => throw _privateConstructorUsedError;
  @JsonKey(name: 'connection_type')
  String? get connectionType => throw _privateConstructorUsedError;
  String? get organization => throw _privateConstructorUsedError;
  String? get asn => throw _privateConstructorUsedError;
  Currency? get currency => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_zone')
  TimeZone? get timeZone => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IpLocationDataCopyWith<IpLocationData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IpLocationDataCopyWith<$Res> {
  factory $IpLocationDataCopyWith(
          IpLocationData value, $Res Function(IpLocationData) then) =
      _$IpLocationDataCopyWithImpl<$Res, IpLocationData>;
  @useResult
  $Res call(
      {String? ip,
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
      @JsonKey(name: 'time_zone') TimeZone? timeZone});

  $CurrencyCopyWith<$Res>? get currency;
  $TimeZoneCopyWith<$Res>? get timeZone;
}

/// @nodoc
class _$IpLocationDataCopyWithImpl<$Res, $Val extends IpLocationData>
    implements $IpLocationDataCopyWith<$Res> {
  _$IpLocationDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? hostname = freezed,
    Object? continentCode = freezed,
    Object? continentName = freezed,
    Object? countryCode2 = freezed,
    Object? countryCode3 = freezed,
    Object? countryName = freezed,
    Object? countryCapital = freezed,
    Object? stateProv = freezed,
    Object? district = freezed,
    Object? city = freezed,
    Object? zipcode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isEu = freezed,
    Object? callingCode = freezed,
    Object? countryTld = freezed,
    Object? languages = freezed,
    Object? countryFlag = freezed,
    Object? geonameId = freezed,
    Object? isp = freezed,
    Object? connectionType = freezed,
    Object? organization = freezed,
    Object? asn = freezed,
    Object? currency = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_value.copyWith(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _value.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      continentCode: freezed == continentCode
          ? _value.continentCode
          : continentCode // ignore: cast_nullable_to_non_nullable
              as String?,
      continentName: freezed == continentName
          ? _value.continentName
          : continentName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode2: freezed == countryCode2
          ? _value.countryCode2
          : countryCode2 // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode3: freezed == countryCode3
          ? _value.countryCode3
          : countryCode3 // ignore: cast_nullable_to_non_nullable
              as String?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCapital: freezed == countryCapital
          ? _value.countryCapital
          : countryCapital // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProv: freezed == stateProv
          ? _value.stateProv
          : stateProv // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      zipcode: freezed == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      isEu: freezed == isEu
          ? _value.isEu
          : isEu // ignore: cast_nullable_to_non_nullable
              as bool?,
      callingCode: freezed == callingCode
          ? _value.callingCode
          : callingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryTld: freezed == countryTld
          ? _value.countryTld
          : countryTld // ignore: cast_nullable_to_non_nullable
              as String?,
      languages: freezed == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as String?,
      countryFlag: freezed == countryFlag
          ? _value.countryFlag
          : countryFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      geonameId: freezed == geonameId
          ? _value.geonameId
          : geonameId // ignore: cast_nullable_to_non_nullable
              as String?,
      isp: freezed == isp
          ? _value.isp
          : isp // ignore: cast_nullable_to_non_nullable
              as String?,
      connectionType: freezed == connectionType
          ? _value.connectionType
          : connectionType // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      asn: freezed == asn
          ? _value.asn
          : asn // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as TimeZone?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCopyWith<$Res>? get currency {
    if (_value.currency == null) {
      return null;
    }

    return $CurrencyCopyWith<$Res>(_value.currency!, (value) {
      return _then(_value.copyWith(currency: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TimeZoneCopyWith<$Res>? get timeZone {
    if (_value.timeZone == null) {
      return null;
    }

    return $TimeZoneCopyWith<$Res>(_value.timeZone!, (value) {
      return _then(_value.copyWith(timeZone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$IpLocationDataImplCopyWith<$Res>
    implements $IpLocationDataCopyWith<$Res> {
  factory _$$IpLocationDataImplCopyWith(_$IpLocationDataImpl value,
          $Res Function(_$IpLocationDataImpl) then) =
      __$$IpLocationDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? ip,
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
      @JsonKey(name: 'time_zone') TimeZone? timeZone});

  @override
  $CurrencyCopyWith<$Res>? get currency;
  @override
  $TimeZoneCopyWith<$Res>? get timeZone;
}

/// @nodoc
class __$$IpLocationDataImplCopyWithImpl<$Res>
    extends _$IpLocationDataCopyWithImpl<$Res, _$IpLocationDataImpl>
    implements _$$IpLocationDataImplCopyWith<$Res> {
  __$$IpLocationDataImplCopyWithImpl(
      _$IpLocationDataImpl _value, $Res Function(_$IpLocationDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ip = freezed,
    Object? hostname = freezed,
    Object? continentCode = freezed,
    Object? continentName = freezed,
    Object? countryCode2 = freezed,
    Object? countryCode3 = freezed,
    Object? countryName = freezed,
    Object? countryCapital = freezed,
    Object? stateProv = freezed,
    Object? district = freezed,
    Object? city = freezed,
    Object? zipcode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? isEu = freezed,
    Object? callingCode = freezed,
    Object? countryTld = freezed,
    Object? languages = freezed,
    Object? countryFlag = freezed,
    Object? geonameId = freezed,
    Object? isp = freezed,
    Object? connectionType = freezed,
    Object? organization = freezed,
    Object? asn = freezed,
    Object? currency = freezed,
    Object? timeZone = freezed,
  }) {
    return _then(_$IpLocationDataImpl(
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      hostname: freezed == hostname
          ? _value.hostname
          : hostname // ignore: cast_nullable_to_non_nullable
              as String?,
      continentCode: freezed == continentCode
          ? _value.continentCode
          : continentCode // ignore: cast_nullable_to_non_nullable
              as String?,
      continentName: freezed == continentName
          ? _value.continentName
          : continentName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode2: freezed == countryCode2
          ? _value.countryCode2
          : countryCode2 // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode3: freezed == countryCode3
          ? _value.countryCode3
          : countryCode3 // ignore: cast_nullable_to_non_nullable
              as String?,
      countryName: freezed == countryName
          ? _value.countryName
          : countryName // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCapital: freezed == countryCapital
          ? _value.countryCapital
          : countryCapital // ignore: cast_nullable_to_non_nullable
              as String?,
      stateProv: freezed == stateProv
          ? _value.stateProv
          : stateProv // ignore: cast_nullable_to_non_nullable
              as String?,
      district: freezed == district
          ? _value.district
          : district // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      zipcode: freezed == zipcode
          ? _value.zipcode
          : zipcode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as String?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as String?,
      isEu: freezed == isEu
          ? _value.isEu
          : isEu // ignore: cast_nullable_to_non_nullable
              as bool?,
      callingCode: freezed == callingCode
          ? _value.callingCode
          : callingCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryTld: freezed == countryTld
          ? _value.countryTld
          : countryTld // ignore: cast_nullable_to_non_nullable
              as String?,
      languages: freezed == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as String?,
      countryFlag: freezed == countryFlag
          ? _value.countryFlag
          : countryFlag // ignore: cast_nullable_to_non_nullable
              as String?,
      geonameId: freezed == geonameId
          ? _value.geonameId
          : geonameId // ignore: cast_nullable_to_non_nullable
              as String?,
      isp: freezed == isp
          ? _value.isp
          : isp // ignore: cast_nullable_to_non_nullable
              as String?,
      connectionType: freezed == connectionType
          ? _value.connectionType
          : connectionType // ignore: cast_nullable_to_non_nullable
              as String?,
      organization: freezed == organization
          ? _value.organization
          : organization // ignore: cast_nullable_to_non_nullable
              as String?,
      asn: freezed == asn
          ? _value.asn
          : asn // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as Currency?,
      timeZone: freezed == timeZone
          ? _value.timeZone
          : timeZone // ignore: cast_nullable_to_non_nullable
              as TimeZone?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IpLocationDataImpl implements _IpLocationData {
  const _$IpLocationDataImpl(
      {this.ip,
      this.hostname,
      @JsonKey(name: 'continent_code') this.continentCode,
      @JsonKey(name: 'continent_name') this.continentName,
      @JsonKey(name: 'country_code2') this.countryCode2,
      @JsonKey(name: 'country_code3') this.countryCode3,
      @JsonKey(name: 'country_name') this.countryName,
      @JsonKey(name: 'country_capital') this.countryCapital,
      @JsonKey(name: 'state_prov') this.stateProv,
      this.district,
      this.city,
      this.zipcode,
      this.latitude,
      this.longitude,
      @JsonKey(name: 'is_eu') this.isEu,
      @JsonKey(name: 'calling_code') this.callingCode,
      @JsonKey(name: 'country_tld') this.countryTld,
      this.languages,
      @JsonKey(name: 'country_flag') this.countryFlag,
      @JsonKey(name: 'geoname_id') this.geonameId,
      this.isp,
      @JsonKey(name: 'connection_type') this.connectionType,
      this.organization,
      this.asn,
      this.currency,
      @JsonKey(name: 'time_zone') this.timeZone});

  factory _$IpLocationDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$IpLocationDataImplFromJson(json);

  @override
  final String? ip;
  @override
  final String? hostname;
  @override
  @JsonKey(name: 'continent_code')
  final String? continentCode;
  @override
  @JsonKey(name: 'continent_name')
  final String? continentName;
  @override
  @JsonKey(name: 'country_code2')
  final String? countryCode2;
  @override
  @JsonKey(name: 'country_code3')
  final String? countryCode3;
  @override
  @JsonKey(name: 'country_name')
  final String? countryName;
  @override
  @JsonKey(name: 'country_capital')
  final String? countryCapital;
  @override
  @JsonKey(name: 'state_prov')
  final String? stateProv;
  @override
  final String? district;
  @override
  final String? city;
  @override
  final String? zipcode;
  @override
  final String? latitude;
  @override
  final String? longitude;
  @override
  @JsonKey(name: 'is_eu')
  final bool? isEu;
  @override
  @JsonKey(name: 'calling_code')
  final String? callingCode;
  @override
  @JsonKey(name: 'country_tld')
  final String? countryTld;
  @override
  final String? languages;
  @override
  @JsonKey(name: 'country_flag')
  final String? countryFlag;
  @override
  @JsonKey(name: 'geoname_id')
  final String? geonameId;
  @override
  final String? isp;
  @override
  @JsonKey(name: 'connection_type')
  final String? connectionType;
  @override
  final String? organization;
  @override
  final String? asn;
  @override
  final Currency? currency;
  @override
  @JsonKey(name: 'time_zone')
  final TimeZone? timeZone;

  @override
  String toString() {
    return 'IpLocationData(ip: $ip, hostname: $hostname, continentCode: $continentCode, continentName: $continentName, countryCode2: $countryCode2, countryCode3: $countryCode3, countryName: $countryName, countryCapital: $countryCapital, stateProv: $stateProv, district: $district, city: $city, zipcode: $zipcode, latitude: $latitude, longitude: $longitude, isEu: $isEu, callingCode: $callingCode, countryTld: $countryTld, languages: $languages, countryFlag: $countryFlag, geonameId: $geonameId, isp: $isp, connectionType: $connectionType, organization: $organization, asn: $asn, currency: $currency, timeZone: $timeZone)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IpLocationDataImpl &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.hostname, hostname) ||
                other.hostname == hostname) &&
            (identical(other.continentCode, continentCode) ||
                other.continentCode == continentCode) &&
            (identical(other.continentName, continentName) ||
                other.continentName == continentName) &&
            (identical(other.countryCode2, countryCode2) ||
                other.countryCode2 == countryCode2) &&
            (identical(other.countryCode3, countryCode3) ||
                other.countryCode3 == countryCode3) &&
            (identical(other.countryName, countryName) ||
                other.countryName == countryName) &&
            (identical(other.countryCapital, countryCapital) ||
                other.countryCapital == countryCapital) &&
            (identical(other.stateProv, stateProv) ||
                other.stateProv == stateProv) &&
            (identical(other.district, district) ||
                other.district == district) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.zipcode, zipcode) || other.zipcode == zipcode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.isEu, isEu) || other.isEu == isEu) &&
            (identical(other.callingCode, callingCode) ||
                other.callingCode == callingCode) &&
            (identical(other.countryTld, countryTld) ||
                other.countryTld == countryTld) &&
            (identical(other.languages, languages) ||
                other.languages == languages) &&
            (identical(other.countryFlag, countryFlag) ||
                other.countryFlag == countryFlag) &&
            (identical(other.geonameId, geonameId) ||
                other.geonameId == geonameId) &&
            (identical(other.isp, isp) || other.isp == isp) &&
            (identical(other.connectionType, connectionType) ||
                other.connectionType == connectionType) &&
            (identical(other.organization, organization) ||
                other.organization == organization) &&
            (identical(other.asn, asn) || other.asn == asn) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            (identical(other.timeZone, timeZone) ||
                other.timeZone == timeZone));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        ip,
        hostname,
        continentCode,
        continentName,
        countryCode2,
        countryCode3,
        countryName,
        countryCapital,
        stateProv,
        district,
        city,
        zipcode,
        latitude,
        longitude,
        isEu,
        callingCode,
        countryTld,
        languages,
        countryFlag,
        geonameId,
        isp,
        connectionType,
        organization,
        asn,
        currency,
        timeZone
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IpLocationDataImplCopyWith<_$IpLocationDataImpl> get copyWith =>
      __$$IpLocationDataImplCopyWithImpl<_$IpLocationDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IpLocationDataImplToJson(
      this,
    );
  }
}

abstract class _IpLocationData implements IpLocationData {
  const factory _IpLocationData(
          {final String? ip,
          final String? hostname,
          @JsonKey(name: 'continent_code') final String? continentCode,
          @JsonKey(name: 'continent_name') final String? continentName,
          @JsonKey(name: 'country_code2') final String? countryCode2,
          @JsonKey(name: 'country_code3') final String? countryCode3,
          @JsonKey(name: 'country_name') final String? countryName,
          @JsonKey(name: 'country_capital') final String? countryCapital,
          @JsonKey(name: 'state_prov') final String? stateProv,
          final String? district,
          final String? city,
          final String? zipcode,
          final String? latitude,
          final String? longitude,
          @JsonKey(name: 'is_eu') final bool? isEu,
          @JsonKey(name: 'calling_code') final String? callingCode,
          @JsonKey(name: 'country_tld') final String? countryTld,
          final String? languages,
          @JsonKey(name: 'country_flag') final String? countryFlag,
          @JsonKey(name: 'geoname_id') final String? geonameId,
          final String? isp,
          @JsonKey(name: 'connection_type') final String? connectionType,
          final String? organization,
          final String? asn,
          final Currency? currency,
          @JsonKey(name: 'time_zone') final TimeZone? timeZone}) =
      _$IpLocationDataImpl;

  factory _IpLocationData.fromJson(Map<String, dynamic> json) =
      _$IpLocationDataImpl.fromJson;

  @override
  String? get ip;
  @override
  String? get hostname;
  @override
  @JsonKey(name: 'continent_code')
  String? get continentCode;
  @override
  @JsonKey(name: 'continent_name')
  String? get continentName;
  @override
  @JsonKey(name: 'country_code2')
  String? get countryCode2;
  @override
  @JsonKey(name: 'country_code3')
  String? get countryCode3;
  @override
  @JsonKey(name: 'country_name')
  String? get countryName;
  @override
  @JsonKey(name: 'country_capital')
  String? get countryCapital;
  @override
  @JsonKey(name: 'state_prov')
  String? get stateProv;
  @override
  String? get district;
  @override
  String? get city;
  @override
  String? get zipcode;
  @override
  String? get latitude;
  @override
  String? get longitude;
  @override
  @JsonKey(name: 'is_eu')
  bool? get isEu;
  @override
  @JsonKey(name: 'calling_code')
  String? get callingCode;
  @override
  @JsonKey(name: 'country_tld')
  String? get countryTld;
  @override
  String? get languages;
  @override
  @JsonKey(name: 'country_flag')
  String? get countryFlag;
  @override
  @JsonKey(name: 'geoname_id')
  String? get geonameId;
  @override
  String? get isp;
  @override
  @JsonKey(name: 'connection_type')
  String? get connectionType;
  @override
  String? get organization;
  @override
  String? get asn;
  @override
  Currency? get currency;
  @override
  @JsonKey(name: 'time_zone')
  TimeZone? get timeZone;
  @override
  @JsonKey(ignore: true)
  _$$IpLocationDataImplCopyWith<_$IpLocationDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Currency _$CurrencyFromJson(Map<String, dynamic> json) {
  return _Currency.fromJson(json);
}

/// @nodoc
mixin _$Currency {
  String? get code => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get symbol => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrencyCopyWith<Currency> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyCopyWith<$Res> {
  factory $CurrencyCopyWith(Currency value, $Res Function(Currency) then) =
      _$CurrencyCopyWithImpl<$Res, Currency>;
  @useResult
  $Res call({String? code, String? name, String? symbol});
}

/// @nodoc
class _$CurrencyCopyWithImpl<$Res, $Val extends Currency>
    implements $CurrencyCopyWith<$Res> {
  _$CurrencyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CurrencyImplCopyWith<$Res>
    implements $CurrencyCopyWith<$Res> {
  factory _$$CurrencyImplCopyWith(
          _$CurrencyImpl value, $Res Function(_$CurrencyImpl) then) =
      __$$CurrencyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? code, String? name, String? symbol});
}

/// @nodoc
class __$$CurrencyImplCopyWithImpl<$Res>
    extends _$CurrencyCopyWithImpl<$Res, _$CurrencyImpl>
    implements _$$CurrencyImplCopyWith<$Res> {
  __$$CurrencyImplCopyWithImpl(
      _$CurrencyImpl _value, $Res Function(_$CurrencyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? name = freezed,
    Object? symbol = freezed,
  }) {
    return _then(_$CurrencyImpl(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      symbol: freezed == symbol
          ? _value.symbol
          : symbol // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CurrencyImpl implements _Currency {
  const _$CurrencyImpl({this.code, this.name, this.symbol});

  factory _$CurrencyImpl.fromJson(Map<String, dynamic> json) =>
      _$$CurrencyImplFromJson(json);

  @override
  final String? code;
  @override
  final String? name;
  @override
  final String? symbol;

  @override
  String toString() {
    return 'Currency(code: $code, name: $name, symbol: $symbol)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CurrencyImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.symbol, symbol) || other.symbol == symbol));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, name, symbol);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CurrencyImplCopyWith<_$CurrencyImpl> get copyWith =>
      __$$CurrencyImplCopyWithImpl<_$CurrencyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CurrencyImplToJson(
      this,
    );
  }
}

abstract class _Currency implements Currency {
  const factory _Currency(
      {final String? code,
      final String? name,
      final String? symbol}) = _$CurrencyImpl;

  factory _Currency.fromJson(Map<String, dynamic> json) =
      _$CurrencyImpl.fromJson;

  @override
  String? get code;
  @override
  String? get name;
  @override
  String? get symbol;
  @override
  @JsonKey(ignore: true)
  _$$CurrencyImplCopyWith<_$CurrencyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TimeZone _$TimeZoneFromJson(Map<String, dynamic> json) {
  return _TimeZone.fromJson(json);
}

/// @nodoc
mixin _$TimeZone {
  String? get name => throw _privateConstructorUsedError;
  int? get offset => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_time')
  String? get currentTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'current_time_unix')
  double? get currentTimeUnix => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_dst')
  bool? get isDst => throw _privateConstructorUsedError;
  @JsonKey(name: 'dst_savings')
  int? get dstSavings => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TimeZoneCopyWith<TimeZone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeZoneCopyWith<$Res> {
  factory $TimeZoneCopyWith(TimeZone value, $Res Function(TimeZone) then) =
      _$TimeZoneCopyWithImpl<$Res, TimeZone>;
  @useResult
  $Res call(
      {String? name,
      int? offset,
      @JsonKey(name: 'current_time') String? currentTime,
      @JsonKey(name: 'current_time_unix') double? currentTimeUnix,
      @JsonKey(name: 'is_dst') bool? isDst,
      @JsonKey(name: 'dst_savings') int? dstSavings});
}

/// @nodoc
class _$TimeZoneCopyWithImpl<$Res, $Val extends TimeZone>
    implements $TimeZoneCopyWith<$Res> {
  _$TimeZoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? offset = freezed,
    Object? currentTime = freezed,
    Object? currentTimeUnix = freezed,
    Object? isDst = freezed,
    Object? dstSavings = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      currentTime: freezed == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTimeUnix: freezed == currentTimeUnix
          ? _value.currentTimeUnix
          : currentTimeUnix // ignore: cast_nullable_to_non_nullable
              as double?,
      isDst: freezed == isDst
          ? _value.isDst
          : isDst // ignore: cast_nullable_to_non_nullable
              as bool?,
      dstSavings: freezed == dstSavings
          ? _value.dstSavings
          : dstSavings // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeZoneImplCopyWith<$Res>
    implements $TimeZoneCopyWith<$Res> {
  factory _$$TimeZoneImplCopyWith(
          _$TimeZoneImpl value, $Res Function(_$TimeZoneImpl) then) =
      __$$TimeZoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      int? offset,
      @JsonKey(name: 'current_time') String? currentTime,
      @JsonKey(name: 'current_time_unix') double? currentTimeUnix,
      @JsonKey(name: 'is_dst') bool? isDst,
      @JsonKey(name: 'dst_savings') int? dstSavings});
}

/// @nodoc
class __$$TimeZoneImplCopyWithImpl<$Res>
    extends _$TimeZoneCopyWithImpl<$Res, _$TimeZoneImpl>
    implements _$$TimeZoneImplCopyWith<$Res> {
  __$$TimeZoneImplCopyWithImpl(
      _$TimeZoneImpl _value, $Res Function(_$TimeZoneImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? offset = freezed,
    Object? currentTime = freezed,
    Object? currentTimeUnix = freezed,
    Object? isDst = freezed,
    Object? dstSavings = freezed,
  }) {
    return _then(_$TimeZoneImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      offset: freezed == offset
          ? _value.offset
          : offset // ignore: cast_nullable_to_non_nullable
              as int?,
      currentTime: freezed == currentTime
          ? _value.currentTime
          : currentTime // ignore: cast_nullable_to_non_nullable
              as String?,
      currentTimeUnix: freezed == currentTimeUnix
          ? _value.currentTimeUnix
          : currentTimeUnix // ignore: cast_nullable_to_non_nullable
              as double?,
      isDst: freezed == isDst
          ? _value.isDst
          : isDst // ignore: cast_nullable_to_non_nullable
              as bool?,
      dstSavings: freezed == dstSavings
          ? _value.dstSavings
          : dstSavings // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeZoneImpl implements _TimeZone {
  const _$TimeZoneImpl(
      {this.name,
      this.offset,
      @JsonKey(name: 'current_time') this.currentTime,
      @JsonKey(name: 'current_time_unix') this.currentTimeUnix,
      @JsonKey(name: 'is_dst') this.isDst,
      @JsonKey(name: 'dst_savings') this.dstSavings});

  factory _$TimeZoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeZoneImplFromJson(json);

  @override
  final String? name;
  @override
  final int? offset;
  @override
  @JsonKey(name: 'current_time')
  final String? currentTime;
  @override
  @JsonKey(name: 'current_time_unix')
  final double? currentTimeUnix;
  @override
  @JsonKey(name: 'is_dst')
  final bool? isDst;
  @override
  @JsonKey(name: 'dst_savings')
  final int? dstSavings;

  @override
  String toString() {
    return 'TimeZone(name: $name, offset: $offset, currentTime: $currentTime, currentTimeUnix: $currentTimeUnix, isDst: $isDst, dstSavings: $dstSavings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeZoneImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.offset, offset) || other.offset == offset) &&
            (identical(other.currentTime, currentTime) ||
                other.currentTime == currentTime) &&
            (identical(other.currentTimeUnix, currentTimeUnix) ||
                other.currentTimeUnix == currentTimeUnix) &&
            (identical(other.isDst, isDst) || other.isDst == isDst) &&
            (identical(other.dstSavings, dstSavings) ||
                other.dstSavings == dstSavings));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, offset, currentTime,
      currentTimeUnix, isDst, dstSavings);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeZoneImplCopyWith<_$TimeZoneImpl> get copyWith =>
      __$$TimeZoneImplCopyWithImpl<_$TimeZoneImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeZoneImplToJson(
      this,
    );
  }
}

abstract class _TimeZone implements TimeZone {
  const factory _TimeZone(
      {final String? name,
      final int? offset,
      @JsonKey(name: 'current_time') final String? currentTime,
      @JsonKey(name: 'current_time_unix') final double? currentTimeUnix,
      @JsonKey(name: 'is_dst') final bool? isDst,
      @JsonKey(name: 'dst_savings') final int? dstSavings}) = _$TimeZoneImpl;

  factory _TimeZone.fromJson(Map<String, dynamic> json) =
      _$TimeZoneImpl.fromJson;

  @override
  String? get name;
  @override
  int? get offset;
  @override
  @JsonKey(name: 'current_time')
  String? get currentTime;
  @override
  @JsonKey(name: 'current_time_unix')
  double? get currentTimeUnix;
  @override
  @JsonKey(name: 'is_dst')
  bool? get isDst;
  @override
  @JsonKey(name: 'dst_savings')
  int? get dstSavings;
  @override
  @JsonKey(ignore: true)
  _$$TimeZoneImplCopyWith<_$TimeZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
