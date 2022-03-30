import 'package:flutter/material.dart';
import 'package:resume_builder/model/resume_model.dart';
import 'package:resume_builder/utils/base_strings.dart';
import 'package:resume_builder/views/pages/add_edit_content.dart';
import 'package:resume_builder/views/pages/home_view.dart';
import 'package:resume_builder/views/pages/resume_detail.dart';

class Routes {
  static const String addEditResume = '/addEditResume';
  static const String home = '/home';
  static const String resumeDetail = '/resumeDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case addEditResume:
        return handleAddEditRoute(settings.arguments);
      case resumeDetail:
        return MaterialPageRoute(builder: (_) => const ResumeDetail());
      default:
        return unKnowRoute(settings.name);
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

  static MaterialPageRoute unKnowRoute(String? name) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(child: Text('No route defined for $name')),
      ),
    );
  }
}
