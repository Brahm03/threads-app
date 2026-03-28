import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_app/main.dart';
import 'package:threads_app/src/features/auth/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: state.status == AuthStatus.loading
                ? CircularProgressIndicator()
                : TextButton(
                    onPressed: () {
                      context.read<AuthCubit>().signInWithGoogle();
                    },
                    child: Text('Sign in with Google')),
          );
        },
      ),
    );
  }
}
