
// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'rem_user.g.dart';

@JsonSerializable()
class RemUser{
  final String? id;
  final String? email;
  final String? full_name;
  final String? user_name;

  RemUser({
    this.id,
    this.email,
    this.full_name,
    this.user_name,
  });

  factory RemUser.fromJson(Map<String, dynamic> json) => _$RemUserFromJson(json);
  Map<String, dynamic> toJson() => _$RemUserToJson(this);
}