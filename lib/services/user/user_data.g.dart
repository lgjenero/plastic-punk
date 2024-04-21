// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      countryCode: json['countryCode'] as String? ?? 'UN',
      finishedLevel: json['finishedLevel'] as int? ?? 0,
      achievements: (json['achievements'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      introShown: json['introShown'] as bool? ?? false,
      onboardingTooltipsShown:
          (json['onboardingTooltipsShown'] as List<dynamic>?)
                  ?.map((e) => $enumDecode(_$OnboardingTooltipEnumMap, e))
                  .toSet() ??
              const {},
      flag: json['flag'] as String? ?? 'UN',
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'countryCode': instance.countryCode,
      'finishedLevel': instance.finishedLevel,
      'achievements': instance.achievements,
      'introShown': instance.introShown,
      'onboardingTooltipsShown': instance.onboardingTooltipsShown
          .map((e) => _$OnboardingTooltipEnumMap[e]!)
          .toList(),
      'flag': instance.flag,
    };

const _$OnboardingTooltipEnumMap = {
  OnboardingTooltip.construction: 'construction',
  OnboardingTooltip.groundCleanup: 'groundCleanup',
  OnboardingTooltip.research: 'research',
  OnboardingTooltip.waterCleanup: 'waterCleanup',
  OnboardingTooltip.diplomacy: 'diplomacy',
};
