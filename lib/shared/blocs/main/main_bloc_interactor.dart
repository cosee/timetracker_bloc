import 'package:rxdart/rxdart.dart';

import 'package:time_track/shared/blocs/main/blocs.dart';

class MainBlocInteractor {
  final _state = BehaviorSubject<MainState>.seeded(MainState());

  MainState initialState() => _state.value;
  Stream<MainState> get state => _state.stream.distinct();

  void selectDate(SelectDateAction action) =>
      _statelify((MainStateBuilder state) {
        state.selectedIndex = action.index;
      });

  void clearDate(ClearEntryAction action) =>
      _statelify((MainStateBuilder state) {
        print('auy');
        WorkDayStateBuilder builder =
            state.workPeriod.workDays[action.index].toBuilder();

        builder.hoursWorked = 0;
        state.workPeriod.workDays[action.index] = builder.build();
      });

  void _statelify(void stateChange(MainStateBuilder b)) {
    final state = _state.value.toBuilder();
    stateChange(state);
    _state.add(state.build());
  }
}
