// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      json['path'] as String,
      useGlobalSetting: json['useGlobalSetting'] as bool? ?? true,
      setting: json['setting'] == null
          ? null
          : GameSetting.fromJson(json['setting'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'path': instance.path,
      'useGlobalSetting': instance.useGlobalSetting,
      'setting': instance.setting,
    };

Path _$PathFromJson(Map<String, dynamic> json) => Path(
      name: json['name'] as String?,
      path: json['path'] as String?,
    );

Map<String, dynamic> _$PathToJson(Path instance) => <String, dynamic>{
      'name': instance.name,
      'path': instance.path,
    };
