import 'package:demo_library_fbloc_login/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildBlocBuilderTextField('Username', context),
                _buildPadding(10),
                _buildBlocBuilderTextField('Password', context),
                _buildPadding(10),
                _buildElevatedButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlocBuilderTextField(String valueLabel, BuildContext context) {
    return valueLabel == 'Username'
        ? BlocBuilder<UsernameCubit, String>(
            builder: (context, state) =>
                _buildTextField(valueLabel, state, context),
          )
        : BlocBuilder<PasswordCubit, String>(
            builder: (context, state) =>
                _buildTextField(valueLabel, state, context),
          );
  }

  Widget _buildTextField(
      String valueLabel, String state, BuildContext context) {
    final node = FocusScope.of(context);
    return TextField(
      controller:
          valueLabel == 'Username' ? _usernameController : _passwordController,
      obscureText: valueLabel == 'Username' ? false : true,
      style: _textStyle(18, Colors.black, FontWeight.normal),
      keyboardType: valueLabel == 'Username'
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction:
          valueLabel == 'Username' ? TextInputAction.next : TextInputAction.go,
      onSubmitted: (_) =>
          valueLabel == 'Username' ? node.nextFocus() : node.unfocus(),
      decoration: InputDecoration(
          errorText: state,
          labelText: valueLabel,
          suffixIcon: valueLabel == 'Username'
              ? null
              : IconButton(
                  icon: Icon(Icons.visibility_off),
                  onPressed: () {},
                )),
      /*onChanged: (value) {
          context.read<UsernameCubit>().validateUsername(value);
        },*/
    );
  }

  Widget _buildPadding(double valuePadding) {
    return Padding(padding: EdgeInsets.symmetric(vertical: valuePadding));
  }

  Widget _buildElevatedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        child: Text('SIGN IN',
            style: _textStyle(20, Colors.white, FontWeight.normal)),
        style: _elevateButton,
        onPressed: () {
          context
              .read<UsernameCubit>()
              .validateUsername(_usernameController.text);
          context
              .read<PasswordCubit>()
              .validatePassword(_passwordController.text);
        },
      ),
    );
  }

  _textStyle(double size, Color color, FontWeight fontWeight) {
    return TextStyle(fontSize: size, color: color, fontWeight: fontWeight);
  }

  final _elevateButton = ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      )),
      elevation: MaterialStateProperty.all(10),
      padding: MaterialStateProperty.all(EdgeInsets.all(15)),
      overlayColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.focused) ||
            states.contains(MaterialState.pressed)) return Colors.yellow;
        return null;
      }));
}
