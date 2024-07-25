import 'package:dars_62_home/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../ui/screens/home_screen.dart';

class MainApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  const MainApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: ChangeNotifierProvider(
          create: (context) => ProductController(),
          builder: (BuildContext context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.amber,
                centerTitle: false,
              ),
            ),
            home: HomeScreen(),
          ),
        ),
      ),
    );
  }
}
