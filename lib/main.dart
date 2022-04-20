import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:resume_builder/bloc/resume_bloc.dart';
import 'package:resume_builder/data_provider/user_data_provider.dart';
import 'package:resume_builder/utils/routes.dart';
import 'package:resume_builder/views/pages/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const firebaseConfig = {
    'apiKey': "AIzaSyC-Qu92m0MqS9UE15kGDzHSm2TSfp3n-mo",
    'authDomain': "medicom-c3c81.firebaseapp.com",
    'projectId': "medicom-c3c81",
    'storageBucket': "medicom-c3c81.appspot.com",
    'messagingSenderId': "1010660912665",
    'appId': "1:1010660912665:web:8badcf2893c8df207b0488"
  };

  /// use any one of the following

  ///for web
  // await Firebase.initializeApp(
  //     options: FirebaseOptions.fromMap(firebaseConfig));

  ///for mobile
  await Firebase.initializeApp();

  final UserDataProvider userDataProvider = UserDataProvider();

  runApp(BlocProvider(
    create: (context) => ResumeBloc(userDataProvider: userDataProvider),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final routes = Routes();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      onGenerateRoute: Routes.generateRoute,
      builder: (context, widget) => ResponsiveWrapper.builder(
        widget!,
        background: Container(
          color: Colors.grey.shade50,
        ),
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1000, name: TABLET),
        ],
      ),
    );
  }
}
