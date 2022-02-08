class AssetModel {
  final String id;
  late String currentOwner;
  late String creator;
  late String name;
  late String description;
  late String coverImage;
  late int views;
  String? externalLink;
  String? contractAddress;
  String? tokenId;

  AssetModel({
    required this.id,
    required this.currentOwner,
    required this.creator,
    required this.name,
    required this.description,
    required this.coverImage,
    required this.views,
    this.externalLink,
    this.contractAddress,
    this.tokenId,
  });
}
