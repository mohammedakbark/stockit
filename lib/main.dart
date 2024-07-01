import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stockit/businesslogic/firebase_options.dart';
import 'package:stockit/data/firebase/database/db_controller.dart';
import 'package:stockit/data/provider/controller.dart';
import 'package:stockit/data/provider/location_provider.dart';
import 'package:stockit/spashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // LoginPreference.removePreference(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DbController>(create: (_) => DbController()),
                ChangeNotifierProvider<Controller>(create: (_) => Controller()),
                ChangeNotifierProvider<LocationService>(create: (_)=>LocationService())

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          
          colorScheme:
              ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 91, 12, 226)),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
