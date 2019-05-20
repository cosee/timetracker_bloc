import 'dart:async';

import 'package:time_track/shared/blocs/main/blocs.dart';

import 'package:time_track/view/bloc_provider.dart';

class MainBloc implements BlocBase {
  // Inputs
  final Sink<SelectDateAction> selectDate;
  final Sink<ClearEntryAction> clearEntry;

  // Outputs
  final Stream<MainState> state;

  // ! Not BLoC conform convenient method !
  final MainState Function() initialState;

  // Cleanup
  final List<StreamSubscription<dynamic>> _subscriptions;

  @override
  void dispose() {
    selectDate.close();
    _subscriptions.forEach((f) => f.cancel());
  }

  factory MainBloc(MainBlocInteractor interactor) {
    final selectDateController = StreamController<SelectDateAction>(sync: true);
    final clearDateController = StreamController<ClearEntryAction>(sync: true);

    final subscriptions = <StreamSubscription<dynamic>>[
      selectDateController.stream.listen(interactor.selectDate),
      clearDateController.stream.listen(interactor.clearDate)
    ];

    return MainBloc._(
      subscriptions,
      interactor.state,
      interactor.initialState,
      selectDateController.sink,
      clearDateController.sink,
    );
  }

  MainBloc._(
    this._subscriptions,
    this.state,
    this.initialState,
    this.selectDate,
    this.clearEntry,
  );
}
