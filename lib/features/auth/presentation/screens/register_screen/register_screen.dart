import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utills/navigation.dart';
import 'package:weather_app/core/widgets/default_app_bar.dart';
import 'package:weather_app/core/widgets/default_loading.dart';
import 'package:weather_app/core/widgets/default_text_button.dart';
import 'package:weather_app/core/widgets/default_text_field.dart';
import 'package:weather_app/core/widgets/error_toast.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/features/weather/presentation/screens/main_screen/main_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(title: 'Register'),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  defaultTextField(
                    controller: name,
                    hint: 'username',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your username';
                      } else if (value.length < 2) {
                        return 'username very weak';
                      }
                      return null;
                    },
                    type: TextInputType.name,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultTextField(
                    controller: email,
                    hint: 'Email',
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!EmailValidator.validate(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    type: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultTextField(
                    controller: password,
                    isPassword: true,
                    hint: 'password',
                    action: TextInputAction.done,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'your password is weak';
                      }
                      return null;
                    },
                    type: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  BlocProvider(
                    create: (context) => AuthCubit(),
                    child: BlocConsumer<AuthCubit, AuthState>(
                      listener: (context, state) {
                        if (state is AuthError) {
                          errorToast(state.error);
                        } else if (state is AuthSuccess) {
                          navigateAndFinish(
                              context: context, screen: MainScreen());
                        }
                      },
                      builder: (context, state) {
                        return state is AuthLoading
                            ? const DefaultLoading()
                            : defaultTextButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    AuthCubit.get(context).createAccount(
                                        email: email.text,
                                        password: password.text,
                                        username: name.text);
                                  }
                                },
                                title: 'Register');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
