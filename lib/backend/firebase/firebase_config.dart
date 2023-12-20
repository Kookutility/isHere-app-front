import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD9D9so0lurfFnM-uWRtgRPgSFW4tCu2Mo",
            authDomain: "ishere-7726d.firebaseapp.com",
            projectId: "ishere-7726d",
            storageBucket: "ishere-7726d.appspot.com",
            messagingSenderId: "463768315666",
            appId: "1:463768315666:web:2deed5ef18f8f8567a75cb"));
  } else {
    await Firebase.initializeApp();
  }
}
