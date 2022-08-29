


class FireStorePaths {
  FireStorePaths._();
  static const usersPath = 'users/';
  static const inspirationPath = 'inspirations/';
  static const booksPath = 'Books/';
  static const myFollowing = 'Following/';
  static const songsPath = 'Music/';
  static const mediaPath = 'Media/';
}

class FireStoreRepo {
  FireStoreRepo._();
 // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static FireStoreRepo get instance => FireStoreRepo._();
  //
}
