// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'rem_user.g.dart';

@JsonSerializable()
class RemUser {
  final String? id;
  final String? email;
  final String? full_name;
  final String? first_name;
  final String? last_name;
  final String? password;
  final String? user_name;
  final bool? is_connected;
  final String? partner_connection_code;

  RemUser({
    this.id,
    this.email,
    this.full_name,
    this.user_name,
    this.first_name,
    this.last_name,
    this.password,
    this.is_connected,
    this.partner_connection_code,
  });

  factory RemUser.fromJson(Map<String, dynamic> json) =>
      _$RemUserFromJson(json);
  Map<String, dynamic> toJson() => _$RemUserToJson(this);
}
