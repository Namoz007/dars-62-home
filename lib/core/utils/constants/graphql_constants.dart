class GraphqlConstants {
  static const String fetchProducts = '''
    query {
      products (limit: 10, offset: 0) {
        id
        title
        price
        description
        category{
          name
        }
      }
    }
  ''';
}
