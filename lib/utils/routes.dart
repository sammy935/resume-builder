import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:resume_builder/views/pages/addEditContent.dart';
import 'package:resume_builder/views/pages/home_view.dart';
import 'package:resume_builder/views/pages/resume_detail.dart';

class Routes {
  static const String addEditResume = '/addEditResume';
  static const String home = '/home';
  static const String resumeDetail = '/resumeDetail';

  List<GetPage> getPages = [
    GetPage(name: home, page: () => const HomeView()),
    GetPage(name: addEditResume, page: () => const AddEditContent()),
    GetPage(name: resumeDetail, page: () => const ResumeDetail()),
    // GetPage(name: '/resume/:resumeId', page: () => const ResumeEditWrapper()),
  ];

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //
  //   switch (settings.name) {
  //     case home:
  //       return MaterialPageRoute(builder: (_) =>const HomeView());
  //     case addEditResume:
  //       return MaterialPageRoute(builder: (_) => AddEditContent());
  //       case resumeDetail:
  //       return MaterialPageRoute(builder: (_) => ResumeDetail());
  //     default:
  //       return MaterialPageRoute(
  //           builder: (_) => Scaffold(
  //             body: Center(
  //                 child: Text('No route defined for ${settings.name}')),
  //           ));
  //   }
  // }
}
