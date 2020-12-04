import 'package:demo_library_fbloc_login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_page.dart';

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<UsernameCubit>(
        create: (_) => UsernameCubit(),
      ),
      BlocProvider<PasswordCubit>(
        create: (_) => PasswordCubit(),
      ),
    ], child: LoginPage());
  }
}
