class Provider {
  final String image;

  Provider({
    required this.image,
  });

  factory Provider.fromMap({required Map data}) {
    return Provider(
      image: data["largeImageURL"],
    );
  }
}
