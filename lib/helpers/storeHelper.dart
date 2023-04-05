import 'package:cloud_firestore/cloud_firestore.dart';

class StoreHelper {
  StoreHelper._();

  static final StoreHelper storeHelper = StoreHelper._();

  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  CollectionReference? collectionReference;

  connectCollection() {
    collectionReference = fireStore.collection("Notes");
  }

  Future<void> addNotes({required String title, required des}) async {
    print("in ");
    connectCollection();
    int id = DateTime.now().millisecondsSinceEpoch;
    await collectionReference!
        .doc(id.toString())
        .set({'id': id, 'title': title, 'des': des})
        .then((value) => print("Notes added.."))
        .catchError((error) => print("$error"));
  }

  Stream<QuerySnapshot<Object?>> getNotes() {
    connectCollection();

    return collectionReference!.snapshots();
  }

  editNotes({required String id, required Map<Object, Object> data}) async {
    connectCollection();

    collectionReference!
        .doc(id)
        .update(data)
        .then((value) => print("Notes edited..."))
        .catchError((error) => print(error));
  }

  deleteNotes({required String id}) async {
    connectCollection();

    collectionReference!
        .doc(id)
        .delete()
        .then((value) => print("Note deleted.."))
        .catchError((error) => print(error));
  }
}
