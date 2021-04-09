import 'package:demo_videocalling/features/agora/presentation/pages/video_calling_page.dart';
import 'package:demo_videocalling/features/dashboard/presentation/screen/dashboard_screen.dart';
import 'package:get/get.dart';

import '../features/login/presentation/screen/login_screen.dart';

abstract class Routes {
  static final login = '/login';
  static final dashboard = '/dashboard';
  static final videocalling = '/videocalling';

  static final pages = <GetPage>[
    GetPage(
      name: login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: dashboard,
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: videocalling,
      page: () => VideoCallingPage(),
    ),
  ];
}
