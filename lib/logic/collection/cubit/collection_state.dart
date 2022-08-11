part of 'collection_cubit.dart';

enum CollectionStatus {
  initial,
  loading,
  success,
  failure,
}

class CollectionState extends Equatable {
  CollectionState({
    this.collectionStatus = CollectionStatus.initial,
    Collection? collection,
  }) : collection = collection ?? Collection.empty();

  final CollectionStatus collectionStatus;
  final Collection collection;

  @override
  List<Object> get props => [collectionStatus, collection];

  CollectionState copyWith({
    CollectionStatus? collectionStatus,
    Collection? collection,
  }) {
    return CollectionState(
      collectionStatus: collectionStatus ?? this.collectionStatus,
      collection: collection ?? this.collection,
    );
  }
}
