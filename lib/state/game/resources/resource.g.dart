// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResourceImpl _$$ResourceImplFromJson(Map<String, dynamic> json) =>
    _$ResourceImpl(
      type: $enumDecode(_$ResourceTypeEnumMap, json['type']),
      amount: json['amount'] as int,
    );

Map<String, dynamic> _$$ResourceImplToJson(_$ResourceImpl instance) =>
    <String, dynamic>{
      'type': _$ResourceTypeEnumMap[instance.type]!,
      'amount': instance.amount,
    };

const _$ResourceTypeEnumMap = {
  ResourceType.material: 'material',
  ResourceType.water: 'water',
  ResourceType.food: 'food',
  ResourceType.population: 'population',
  ResourceType.electricity: 'electricity',
  ResourceType.impact: 'impact',
};
