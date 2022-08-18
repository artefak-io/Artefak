part of 'collection_cubit.dart';

enum CollectionStatus {
  loading,
  success,
  failure,
}

class CollectionState extends Equatable {
  CollectionState({
    this.collectionStatus = CollectionStatus.loading,
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
