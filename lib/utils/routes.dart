import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/baseStrings.dart';
import 'package:resume_builder/views/pages/addEditContent.dart';
import 'package:resume_builder/views/pages/home_view.dart';
import 'package:resume_builder/views/pages/resume_detail.dart';

class Routes {
  static const String addEditResume = '/addEditResume';
  static const String home = '/home';
  static const String resumeDetail = '/resumeDetail';

  // List<GetPage> getPages = [
  //   GetPage(name: home, page: () => const HomeView()),
  //   GetPage(name: addEditResume, page: () => const AddEditContent()),
  //   GetPage(name: resumeDetail, page: () => const ResumeDetail()),
  //   // GetPage(name: '/resume/:resumeId', page: () => const ResumeEditWrapper()),
  // ];

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case addEditResume:
        return handleAddEditRoute(settings.arguments);
      case resumeDetail:
        return MaterialPageRoute(builder: (_) => ResumeDetail());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }

  static MaterialPageRoute handleAddEditRoute(Object? arguments) {
    Map<String, dynamic> args = arguments as Map<String, dynamic>;
    String title =
        args.containsKey(BaseStrings.title) ? args[BaseStrings.title] : '';
    Resume? resume = args.containsKey(BaseStrings.updatedResume) &&
            args[BaseStrings.updatedResume] != null
        ? args[BaseStrings.updatedResume]
        : null;
    return MaterialPageRoute(
        builder: (_) => AddEditContent(
              title: title,
              updateResume: resume,
            ));
  }
}
