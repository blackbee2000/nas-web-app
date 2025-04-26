class LikePostRequest {
  final int id;
  final bool isFavorite;

  LikePostRequest({required this.id, required this.isFavorite});

  Map<String, dynamic> toJson() => {
        "Id": id,
        "IsFavorite": isFavorite,
      };
}
