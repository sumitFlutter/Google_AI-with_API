import 'package:flutter/material.dart';
import 'package:google_gemini/screen/home/provider/gemini_provider.dart';
import 'package:google_gemini/utils/routes/my_routes.dart';
import 'package:provider/provider.dart';
void main()
{
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GeminiProvider())
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
      ),
    );
  }
}
