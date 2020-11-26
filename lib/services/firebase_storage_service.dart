//NOT CURRENTLY USING

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageService {
  Future<void> downloadURLExample(String url) async {
    String downloadURL = await firebase_storage.FirebaseStorage.instance
        .ref(url)
        .getDownloadURL();
    print(downloadURL);
  }
}

//Call
/* print(context
        .watch<FirebaseStorageService>()
        .downloadURLExample("/users/Son Ye-jin.jpg")); */
