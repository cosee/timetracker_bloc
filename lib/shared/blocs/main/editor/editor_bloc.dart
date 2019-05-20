import 'dart:async';

import 'package:rxdart/rxdart.dart';

import '../blocs.dart';

class EditorBloc implements BlocBase {
  // Inputs
  final Sink<ClearEntryAction> clearEntry;
  final Sink<SaveChangesAction> saveChanges;
  final Sink<CacheChangeAction> cacheChanges;
  // cacheChanges
  // Outputs

  final BehaviorSubject<WorkDayState> _state;
  Stream<WorkDayState> get state => _state.distinct();
  WorkDayState get initialState => _state.value;

  // Cleanup
  @override
  final List<StreamSubscription<dynamic>> _subscriptions;

  void dispose() {
    clearEntry.close();
    cacheChanges.close();
    _subscriptions.forEach((f) => f.cancel());
  }

  // Route in and outputs to (mostly) interactors methods/ streams
  factory EditorBloc(
    Stream<WorkDayState> stream,
    Sink<WorkDayState> sink,
  ) {
    var interactor = EditorBlocInteractor(sink);

    final clearDateController = StreamController<ClearEntryAction>(sync: true);
    final saveChangesController =
        StreamController<SaveChangesAction>(sync: true);

    final cacheChangesController =
        StreamController<CacheChangeAction>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      stream.listen(interactor.updateState),
      clearDateController.stream.listen(interactor.clearEntry),
      saveChangesController.stream.listen(interactor.saveChanges),
      cacheChangesController.stream.listen(interactor.cacheChanges)
    ];

    return EditorBloc._(
      subscriptions,
      clearDateController.sink,
      saveChangesController.sink,
      cacheChangesController.sink,
      interactor.cachedState,
    );
  }

  EditorBloc._(
    this._subscriptions,
    this.clearEntry,
    this.saveChanges,
    this.cacheChanges,
    this._state,
  );
}
