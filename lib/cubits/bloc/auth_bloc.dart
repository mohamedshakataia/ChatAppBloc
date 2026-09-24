import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          emit(LoginFailure(errorMessage: 'Incorrect Email or Password'));
        } else {
          emit(LoginFailure(errorMessage: 'errorMessage'));
        }
      } catch (e) {
        emit(LoginFailure(errorMessage: 'errorMessage'));
      }
    });
    on<RegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(RegisterSuccess());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(
            RegisterFailure(errorMessage: 'The password provided is too weak.'),
          );
        } else if (e.code == 'email-already-in-use') {
          emit(
            RegisterFailure(
              errorMessage: 'The account already exists for that email',
            ),
          );
        } else {
          emit(RegisterFailure(errorMessage: 'Error,Try Again'));
        }
      } catch (e) {
        emit(RegisterFailure(errorMessage: e.toString()));
      }
    });
  }
}
