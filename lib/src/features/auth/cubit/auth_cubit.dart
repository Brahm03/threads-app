import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_state.dart';

// * ctr + shift + 5
// * ./gradlew signInReport
// * 40:F7:BE:FF:DC:4B:77:C1:A2:ED:68:14:19:0D:AC:A4:F7:06:73:0B

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState());

  Future<void> signInWithGoogle() async {
    emit(AuthState(status: AuthStatus.loading));
    try {
      print('Auth boshlandi ..');

      await GoogleSignIn.instance.initialize(
          clientId:
              "863675084155-bf17h3rompciih10v15cdr7tag00mh2h.apps.googleusercontent.com");

      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate(); // * dialog google account
      print('Authentificated tugadi $googleUser');
      if (googleUser.authentication.idToken == null) {
        emit(AuthState(status: AuthStatus.initial));
        return;
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      // * credential -> tanlangan account data

      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthState(status: AuthStatus.authentificated));
    } catch (e) {
      print('Error keldi $e');
      emit(AuthState(
          status: AuthStatus.error, errorText: 'Something went wrong !'));
    }
  }
}
