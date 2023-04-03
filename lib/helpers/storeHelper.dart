import 'package:cloud_firestore/cloud_firestore.dart';

class StoreHelper {
  StoreHelper._();

  static final StoreHelper storeHelper = StoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;

  connectCollection() {
    collectionReference = fireStore.collection("Notes");
  }

  addNotes({required String title, required note}) async {
    connectCollection();
    int id = DateTime.now().millisecondsSinceEpoch;

    await collectionReference!
        .doc(id.toString())
        .set({'id': id, 'title': title, 'note': note})
        .then((value) => print("Notes added.."))
        .catchError((error) => print("$error"));
  }
}
