import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:triple_h/utils/constants/colors.dart';
import 'package:triple_h/utils/constants/text_strings.dart';
import 'package:triple_h/utils/routes/app_routes.dart';
import 'package:triple_h/utils/theme/theme.dart';


import 'bindings/general_bindings.dart';
import 'features/authentication/screens/onboarding/onboarding.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: TTexts.appName,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      debugShowCheckedModeBanner: true,
      initialBinding: GeneralBindings(),
      darkTheme: TAppTheme.darkTheme,
      getPages: AppRoutes.pages,
      home:const Scaffold(
        backgroundColor: TColors.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}