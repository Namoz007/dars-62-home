import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlConfig {
  static HttpLink httpClient = HttpLink(
    'https://fakeapi.platzi.com/en/gql/products',
  );

  static ValueNotifier<GraphQLClient> initializaClient() {
    final Link link = httpClient;

    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
  }
}