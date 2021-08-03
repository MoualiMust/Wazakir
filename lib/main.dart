import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wazakir/auth/connexion.dart';
import 'package:wazakir/auth/controllAuth.dart';
import 'package:wazakir/providers/tasksProvider.dart';
import 'package:wazakir/providers/userProvider.dart';
import 'package:wazakir/theme/colors/light_colors.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: LightColors.kLightYellow, // navigation bar color
    statusBarColor: Color(0xffffb969), // status bar color
  ));

  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<Utilisateur>.value(
          value: StreamProviderAuth().utilisateur,
        ),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: TaskProvider()),
      ],
      child: MaterialApp(
        title: 'Wazakir',
        home: Passerelle(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
