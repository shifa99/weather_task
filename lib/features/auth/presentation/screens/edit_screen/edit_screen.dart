import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/utills/navigation.dart';
import 'package:weather_app/core/utills/style_manager.dart';
import 'package:weather_app/core/widgets/default_app_bar.dart';
import 'package:weather_app/core/widgets/default_loading.dart';
import 'package:weather_app/core/widgets/default_text_button.dart';
import 'package:weather_app/core/widgets/default_text_field.dart';
import 'package:weather_app/core/widgets/error_toast.dart';
import 'package:weather_app/core/widgets/success_toast.dart';
import 'package:weather_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:weather_app/features/auth/presentation/screens/change_password/change_password.dart';
import 'package:weather_app/features/auth/presentation/screens/login_screen/login_screen.dart';

class EditScreen extends StatelessWidget {
  EditScreen({Key? key}) : super(key: key);
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit()..getuser(),
      child: Scaffold(
        appBar: defaultAppbar(title: 'Edit Profile', actions: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  AuthCubit.get(context).logout();
                  navigateAndFinish(context: context, screen: LoginScreen());
                },
                icon: Icon(
                  Icons.logout,
                  size: 25.sp,
                ));
          }),
        ]),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Form(
            key: formKey,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  successToast('Changed succcessfully');
                  formKey.currentState!.reset();
                } else if (state is AuthError) {
                  errorToast(state.error);
                }
              },
              builder: (context, state) {
                if (state is AuthGetUserError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: bodyStyle(),
                    ),
                  );
                } else if (state is! AuthGetUserLoading &&
                    state is! AuthInitial) {
                  if (state is AuthGetUserSuccess) {
                    name.text = AuthCubit.get(context).user.name;
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      defaultTextField(
                        controller: name,
                        hint: 'Name',
                        validator: (String value) {
                          if (value.isEmpty) return 'Please enter your name';
                        },
                        type: TextInputType.name,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      state is AuthLoading
                          ? const DefaultLoading()
                          : defaultTextButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  AuthCubit.get(context)
                                      .update(name: name.text);
                                }
                              },
                              buttonColor: Colors.lightGreen,
                              title: 'Change'),
                      SizedBox(
                        height: 20.h,
                      ),
                      defaultTextButton(
                          onPressed: () {
                            navigateTo(
                                context: context, screen: ChangePassword());
                          },
                          title: 'Change Password'),
                    ],
                  );
                } else {
                  return const DefaultLoading();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
