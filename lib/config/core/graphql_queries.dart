const String fetchProducts = """
query {
  products {
    id
    title
    price
    description
    images
    category {
      id
      name
      image
    }
  }
}
""";