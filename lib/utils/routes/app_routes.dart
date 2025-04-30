
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:triple_h/utils/routes/routes.dart';

import '../../features/authentication/screens/login/login.dart';
import '../../features/authentication/screens/onboarding/onboarding.dart';
import '../../features/dashboard/screens/adding_tree/adding_tree.dart';


class AppRoutes {
  static final pages = [
    GetPage(name: TRoutes.adding_plants, page: () => const AddingTree ()),

    // Add more GetPage entries as needed
  ];
}
