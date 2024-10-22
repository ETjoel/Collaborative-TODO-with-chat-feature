import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userid;
  final String username;
  final String fname;
  final String sname;
  final String email;
  final String imageurl;

  UserEntity({
    required this.userid,
    required this.username,
    required this.fname,
    required this.sname,
    required this.email,
    required this.imageurl,
  });

  @override
  List<Object?> get props => [userid, username, fname, sname, email, imageurl];
}
