import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_data.freezed.dart';
part 'user_data.g.dart';

enum OnboardingTooltip {
  construction('Tap here to open the construction menu'),
  groundCleanup('Tap here to start cleaning the ground'),
  research('Tap here to open the research menu'),
  waterCleanup('Tap here to start cleaning the water'),
  diplomacy('Tap here to start the diplomacy process');

  final String tooltipMessage;
  const OnboardingTooltip(this.tooltipMessage);
}

@freezed
class UserData with _$UserData {
  const factory UserData({
    @Default('UN') String countryCode,
    @Default(0) int finishedLevel,
    @Default([]) List<String> achievements,
    @Default(false) bool introShown,
    @Default({}) Set<OnboardingTooltip> onboardingTooltipsShown,
    @Default('UN') String flag,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}
