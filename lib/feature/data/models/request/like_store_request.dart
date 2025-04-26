class LikeStoreRequest {
  final int id;
  final bool isFavorite;

  LikeStoreRequest({required this.id, required this.isFavorite});

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsFavorite": isFavorite,
      };
}
