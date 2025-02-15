import '../../data/models/rem_user.dart';

class User {
  String? id;
  String? email;
  String? firstName;
  String? userName;
  String? lastName;
  String? password;
  bool? isConnected;
  String? partnerConnectionCode;

  User({
    this.id,
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
    this.password,
    this.isConnected,
    this.partnerConnectionCode,
  });

  // Convert User to RemUser
  RemUser toRemUser() {
    return RemUser(
      id: id,
      email: email,
      user_name: userName,
      first_name: firstName,
      last_name: lastName,
      password: password,
      full_name:
          firstName != null && lastName != null ? '$firstName $lastName' : null,
      is_connected: isConnected,
      partner_connection_code: partnerConnectionCode,
    );
  }

  // Create User from RemUser
  factory User.fromRemUser(RemUser remUser) {
    return User(
      id: remUser.id,
      email: remUser.email,
      userName: remUser.user_name,
      firstName: remUser.first_name,
      lastName: remUser.last_name,
      password: remUser.password,
      isConnected: remUser.is_connected,
      partnerConnectionCode: remUser.partner_connection_code,
    );
  }
}
