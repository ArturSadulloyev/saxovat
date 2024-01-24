import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}



// password_visibility_event.dart

abstract class PasswordVisibilityEvent extends Equatable {
  const PasswordVisibilityEvent();
}

class TogglePasswordVisibility extends PasswordVisibilityEvent {
  @override
  List<Object> get props => [];
}

// password_visibility_state.dart

class PasswordVisibilityState extends Equatable {
  final bool isPasswordVisible;

  const PasswordVisibilityState(this.isPasswordVisible);

  @override
  List<Object> get props => [isPasswordVisible];
}


class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityState(false));


  @override
  Stream<PasswordVisibilityState> mapEventToState(PasswordVisibilityEvent event) async* {
    if (event is TogglePasswordVisibility) {
      yield PasswordVisibilityState(!state.isPasswordVisible);
    }
  }


}
