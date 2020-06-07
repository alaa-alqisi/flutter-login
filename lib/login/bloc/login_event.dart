import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String id;
  final String project;
  final String password;

  const LoginButtonPressed({
    @required this.id,
    @required this.project,
    @required this.password,
  });

  @override
  List<Object> get props => [id, project, password];

  @override
  String toString() =>
      'LoginButtonPressed { id: $id, password: $password,project : $project }';
}
