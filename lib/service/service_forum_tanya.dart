import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceForumTanya {
  static var thread = FirebaseFirestore.instance.collection('thread');

  static Stream<QuerySnapshot> getThread() {
    return thread.orderBy('date', descending: true).snapshots();
  }

  static Stream<DocumentSnapshot> streamForumTanya(String id) {
    return thread.doc(id).snapshots();
  }

  static Future<void> addThread(String judul, String desc) async {
    await thread.doc().set({
      "judul": judul,
      "desc": desc,
      "date": DateTime.now().millisecondsSinceEpoch,
      "like": [],
      "comment": [],
    });
  }

  static Future<void> addComment(String idThread, String id, String username,
      String comment, dynamic oldComment) async {
    await thread.doc(idThread).set(
      {
        "comment": [
          ...oldComment,
          {
            "id": id,
            "username": username,
            "comment": comment,
            "date": DateTime.now().millisecondsSinceEpoch,
          }
        ]
      },
      SetOptions(
        merge: true,
      ),
    );
  }

  static Future<void> like(String idThread, String id, dynamic oldLike) async {
    var liked =
        oldLike.firstWhere((like) => like["id"] == id, orElse: () => null);
    if (liked == null) {
      await thread.doc(idThread).set(
        {
          "like": [
            ...oldLike,
            {
              "id": id,
              "date": DateTime.now().millisecondsSinceEpoch,
            }
          ]
        },
        SetOptions(
          merge: true,
        ),
      );
    } else {
      var index = oldLike.indexOf(liked);
      oldLike.removeAt(index);
      await thread.doc(idThread).set(
        {
          "like": [
            ...oldLike,
          ]
        },
        SetOptions(
          merge: true,
        ),
      );
    }
  }
}
