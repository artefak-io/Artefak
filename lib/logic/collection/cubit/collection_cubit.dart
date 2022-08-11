import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/models.dart';
import '../repositories/repositories.dart';

part 'collection_state.dart';

//TODO: Should be a bloc
class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit(this._firebaseCollection) : super(CollectionState());
  final FirebaseCollection _firebaseCollection;

  void collectionFetched(String id) async {
    emit(state.copyWith(collectionStatus: CollectionStatus.loading));

    try {
      emit(state.copyWith(
        collectionStatus: CollectionStatus.success,
        collection: await _firebaseCollection.getCollection(id),
      ));
    } catch (e) {
      emit(state.copyWith(
        collectionStatus: CollectionStatus.failure,
      ));
    }
  }
}
