import 'package:dashboard/src/classes/constents.class.dart';
import 'package:dashboard/src/providers/auth.provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'src/classes/routes.class.dart';
import 'src/providers/routes.provider.dart';
import 'src/providers/search.provider.dart';

void main() {
  Get.lazyPut(() => AuthProvider());
  Get.lazyPut(() => RoutesProvider());
  Get.lazyPut(() => SearchProvider());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SEA HORSE',
      debugShowCheckedModeBanner: false,
      getPages: routes,
      initialRoute: routes.first.name,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
          surfaceTint: Colors.transparent,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primaryColor,
          selectionColor: primaryColor.withOpacity(.1),
        ),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
    );
  }
}
