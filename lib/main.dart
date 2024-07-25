import 'package:dars_62_home/logic/graphql_config.dart';
import 'package:flutter/material.dart';

import 'core/app.dart';

void main() {
  final client = GraphqlConfig.initiliazeClient();
  runApp(MainApp(
    client: client,
  ));
}
