import 'package:shopapp_flut/bloc_helpers/bloc_event_state.dart';

abstract class AuthenticationEvent extends BlocEvent {
  final String name;

  AuthenticationEvent({
    this.name: '',
  });
}

class AuthenticationEventLogin extends AuthenticationEvent {
  AuthenticationEventLogin({
    String name,
  }) : super(
          name: name,
        );
}

class AuthenticationEventLogout extends AuthenticationEvent {}
