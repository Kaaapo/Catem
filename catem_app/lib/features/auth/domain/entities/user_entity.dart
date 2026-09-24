import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.email,
    this.phone,
    this.isEmailConfirmed = false,
    this.isPhoneConfirmed = false,
  });

  final String id;
  final String? email;
  final String? phone;
  final bool isEmailConfirmed;
  final bool isPhoneConfirmed;

  bool get isVerified => isEmailConfirmed || isPhoneConfirmed;

  @override
  List<Object?> get props => [
    id,
    email,
    phone,
    isEmailConfirmed,
    isPhoneConfirmed,
  ];
}
