// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rem_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemUser _$RemUserFromJson(Map<String, dynamic> json) => RemUser(
      id: json['id'] as String?,
      email: json['email'] as String?,
      full_name: json['full_name'] as String?,
      user_name: json['user_name'] as String?,
    );

Map<String, dynamic> _$RemUserToJson(RemUser instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'full_name': instance.full_name,
      'user_name': instance.user_name,
    };
