import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/default_app_bar.dart';
import 'package:weather_app/core/widgets/default_loading.dart';
import 'package:weather_app/core/widgets/default_text_button.dart';
import 'package:weather_app/core/widgets/default_text_field.dart';
import 'package:weather_app/core/widgets/error_toast.dart';
import 'package:weather_app/core/widgets/success_toast.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar(title: 'Change Password'),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: BlocProvider(
              create: (context) => AuthCubit(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  defaultTextField(
                      controller: newPassword,
                      hint: 'New Password',
                      isPassword: true,
                      validator: (String value) {
                        if (value.length < 6) {
                          return 'new password very weak';
                        } else if (newPassword.text != confirmPassword.text) {
                          return 'Password mismathc';
                        }
                      },
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  defaultTextField(
                      controller: confirmPassword,
                      isPassword: true,
                      action: TextInputAction.done,
                      hint: 'Confirm Password',
                      validator: (String value) {
                        if (value.length < 6) {
                          return 'new password very weak';
                        } else if (newPassword.text != confirmPassword.text) {
                          return 'Password mismathc';
                        }
                      },
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        successToast('Changed Successfully');
                        Navigator.pop(context);
                      } else if (state is AuthError) {
                        errorToast(state.error);
                      }
                    },
                    builder: (context, state) {
                      return state is AuthLoading
                          ? const DefaultLoading()
                          : defaultTextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context).changePassword(
                                      password: newPassword.text);
                                }
                              },
                              title: 'Confirm');
                    },
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
