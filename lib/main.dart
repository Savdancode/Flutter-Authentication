import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splash_and_firebase/Screens/splash_sreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: CheckError(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CheckError extends StatefulWidget {
  const CheckError({Key? key}) : super(key: key);

  @override
  _CheckErrorState createState() => _CheckErrorState();
}

class _CheckErrorState extends State<CheckError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Splash();
          }
        },
      ),
    );
  }
}
