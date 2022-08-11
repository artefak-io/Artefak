import 'package:equatable/equatable.dart';

import 'package:artefak/logic/user/user.dart';

class Collection extends Equatable {
  final String id;
  final String coverImage;
  final ArtefakUser creator;
  final String description;
  final String name;
  final int price;
  final String externalLink;
  final int views;
  const Collection({
    required this.id,
    required this.coverImage,
    required this.creator,
    required this.description,
    required this.name,
    required this.price,
    required this.externalLink,
    required this.views,
  });

  factory Collection.empty() {
    return Collection(
      id: '',
      coverImage: '',
      creator: ArtefakUser.empty(),
      description: '',
      name: '',
      price: 0,
      externalLink: '',
      views: 0,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      coverImage,
      creator,
      description,
      name,
      price,
      externalLink,
      views,
    ];
  }

  factory Collection.fromMap({
    required Map<String, dynamic> mapCollection,
    required String idCollection,
    required Map<String, dynamic> mapUser,
    required String idUser,
  }) {
    return Collection(
      id: idCollection,
      coverImage: mapCollection['coverImage'] as String,
      creator: ArtefakUser.fromMap(map: mapUser, id: idUser),
      description: mapCollection['description'] as String,
      name: mapCollection['name'] as String,
      price: mapCollection['price'] as int,
      externalLink: mapCollection['externalLink'] as String,
      views: mapCollection['views'] as int,
    );
  }

//TODO: would be user later probably
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coverImage': coverImage,
      'description': description,
      'name': name,
      'price': price,
      'externalLink': externalLink,
      'views': views,
    };
  }
}
