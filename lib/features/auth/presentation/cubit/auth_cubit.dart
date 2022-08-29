import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/helpers/cache/cache_helper.dart';
import 'package:weather_app/core/helpers/firebase/auth/fire_auth.dart';
import 'package:weather_app/core/helpers/firebase/firestore/profile_services.dart';
import 'package:weather_app/features/auth/data/models/user_model.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  late User user;
  Future<void> getuser() async {
    emit(AuthGetUserLoading());
    try {
      final String email = await CacheHelper.getDate(key: 'email');
      log(email.toString());
      user = await ProfileServices.instance.getUserData(email: email);
      emit(AuthGetUserSuccess());
    } catch (e) {
      emit(AuthGetUserError(e.toString()));
      rethrow;
    }
  }

  Future<void> createAccount(
      {required String email,
      required String password,
      required String username}) async {
    emit(AuthLoading());
    try {
      final user = await FireAuth.instance
          .registerUser(email: email, password: password);
      UserModel userModel = UserModel(email: user.email!, name: username);
      await ProfileServices.instance.createUser(userModel: userModel);
      await CacheHelper.saveDate(key: 'email', value: email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> loginAccount(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await FireAuth.instance
          .signInEmailAndPassword(email: email, password: password);
      await CacheHelper.saveDate(key: 'email', value: user.email!);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> update({required String name}) async {
    emit(AuthLoading());
    try {
      await ProfileServices.instance.updateUser(name: name);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> changePassword({required String password}) async {
    emit(AuthLoading());
    try {
      FireAuth.instance.updateUserData(newPassword: password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      await FireAuth.instance.logoutUser();
      await CacheHelper.removeData(key: 'email');
    } catch (e) {
      rethrow;
    }
  }
}
