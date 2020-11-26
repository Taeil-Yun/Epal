import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore;
  final String userEmail;

  FirestoreService(this.firestore, this.userEmail);

  //Get Generic Collection.
  Future<List<QueryDocumentSnapshot>> getCollectionDocs(
      String collectionName) async {
    final collection = await firestore.collection(collectionName).get();
    return collection.docs;
  }

  //Get User Informations
  Future<QueryDocumentSnapshot> getUserInformations() async {
    final userInformations = await firestore
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
    return userInformations.docs.first;
  }
}
