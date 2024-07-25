class GraphqlMutations {
  String createProduct = """
mutation addProduct(
  \$title: String!, 
  \$price: Float!, 
  \$description: String!, 
  \$categoryId: Float!,
  \$images: [String!]!
) {
    addProduct(
      data: {
        title: \$title, 
        price:  \$price, 
        description: \$description, 
        categoryId: \$categoryId
        images: \$images
      }) {
      id
      title
      price
      description
      images
      category {
        name
      }
    }
}

""";

  static const String updateProduct = """
  mutation UpdateProduct(\$id: ID!, \$title: String!, \$description: String!, \$price: Float!, \$category: CategoryInput!) {
    updateProduct(id: \$id, title: \$title, description: \$description, price: \$price, category: \$category) {
      id
      title
      description
      price
      category {
        name
      }
    }
  }
  """;

  static const String deleteProduct = """
  mutation DeleteProduct(\$id: ID!) {
    deleteProduct(id: \$id)
  }
  """;
}
