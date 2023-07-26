    
import 'package:firebase_auth/firebase_auth.dart';

class Utils {
  static User? currentUser = FirebaseAuth.instance.currentUser;

  // static Future<List<TodoModel>> getCurrentUserTodos() async {
  //   List<TodoModel> todoList = [];
  //   final firestore = FirebaseFirestore.instance;

  //   try {
  //     final collectionRef = await firestore
  //         .collection('users')
  //         .doc(currentUser?.uid)
  //         .collection('todos')
  //         .orderBy('date', descending: true)
  //         .get();
  //     for (final document in collectionRef.docs) {
  //       var todo = TodoModel.fromJson(document.data());
  //       todoList.add(todo);
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   return todoList;
  // }
}
