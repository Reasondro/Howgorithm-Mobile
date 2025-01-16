import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:howgorithm/router/routing_service.dart';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ColorScheme howgorithmColorTheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 61, 100, 162),
    brightness: Brightness.light);

final ThemeData howgorithmTheme = ThemeData().copyWith(
  colorScheme: howgorithmColorTheme,
  textTheme: GoogleFonts.dmSansTextTheme().copyWith(
    titleLarge:
        GoogleFonts.majorMonoDisplay(fontWeight: FontWeight.bold, fontSize: 35),
    titleMedium: GoogleFonts.dmSans(
        fontWeight: FontWeight.w600,
        fontSize: 25,
        color: howgorithmColorTheme.secondary),
    titleSmall: GoogleFonts.dmSans(
        fontWeight: FontWeight.w600,
        fontSize: 20,
        color: howgorithmColorTheme.secondary),
    labelSmall: GoogleFonts.dmSans(
        fontWeight: FontWeight.w400,
        fontSize: 15,
        color: howgorithmColorTheme.primary),
  ),
  appBarTheme: AppBarTheme(
    color: howgorithmColorTheme.surfaceContainer,
    foregroundColor: howgorithmColorTheme.primary,
  ),
  navigationBarTheme: NavigationBarThemeData(
    iconTheme: WidgetStateProperty.resolveWith((Set<WidgetState> states) =>
        states.contains(WidgetState.selected)
            ? (IconThemeData(color: howgorithmColorTheme.primary))
            : (IconThemeData(color: howgorithmColorTheme.onSurface))),
    height: 65,
    backgroundColor: howgorithmColorTheme.surfaceContainer,
    // indicatorColor: howgorithmColorTheme.secondaryContainer,
    // indicatorColor: howgorithmColorTheme.inversePrimary,
    indicatorColor: howgorithmColorTheme.secondaryContainer,
    // indicatorColor: Color.fromARGB(0, 0, 0, 0),

    indicatorShape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    // indicatorShape: const CircleBorder(),
    // indicatorShape: const BeveledRectangleBorder(),
    labelTextStyle: WidgetStatePropertyAll(
      TextStyle(
        // color: howgorithmColorTheme.onSurface,
        color: howgorithmColorTheme.primary,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  scaffoldBackgroundColor: howgorithmColorTheme.surface,
);

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      anonKey: dotenv.env["SUPABASE_ANON_KEY"]!,
      url: dotenv.env["SUPABASE_PROJECT_URL"]!);
  GoRouter router = RoutingService().router;

  Supabase.instance.client.auth.onAuthStateChange.listen((AuthState data) {
    router.refresh();
  });

  runApp(MyApp(
    router: router,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.router});
  final GoRouter router;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() async {
    await Future.delayed(const Duration(milliseconds: 650));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Howgorithm',
      theme: howgorithmTheme,
      routerConfig: widget.router,
    );
  }
}
