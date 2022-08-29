import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_app/core/helpers/cache/cache_helper.dart';
import 'package:weather_app/features/auth/data/models/user_model.dart';
import 'package:weather_app/features/auth/domain/entities/user.dart';

import 'fire_firestore.dart';

class ProfileServices {
  ProfileServices._();
  static ProfileServices get instance => ProfileServices._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> createUser({required UserModel userModel}) async {
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(userModel.email)
        .set(userModel.toMap());
  }

  Future<void> updateUser({required String name}) async {
    final String email = await CacheHelper.getDate(key: 'email');
    await _firestore
        .collection(FireStorePaths.usersPath)
        .doc(email)
        .update({'name': name});
  }

  Future<User> getUserData({required String email}) async {
    final user =
        await _firestore.collection(FireStorePaths.usersPath).doc(email).get();
    log('Data User');
    if (!user.exists) throw 'This user not exist';
    log(user.data()!.toString());
    UserModel userModel = UserModel.fromJson(user.data()!);
    //final followingList = (user.data() as Map<String,dynamic>)['usersIdFollowing'];

    return userModel;
    // return user.data()!;
  }
}
