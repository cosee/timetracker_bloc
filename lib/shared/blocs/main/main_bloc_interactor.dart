import 'package:rxdart/rxdart.dart';

import 'package:time_track/shared/blocs/main/blocs.dart';
import 'package:time_track/shared/helper/compare.dart';

class MainBlocInteractor {
  final _state = BehaviorSubject<MainState>.seeded(MainState());

  MainState initialState() => _state.value;
  Stream<MainState> get state => _state.stream.distinct();

  void selectDate(SelectDateAction action) =>
      _statelify((MainStateBuilder state) {
        state.selectedIndex = action.index;
      });

  void updateEntry(WorkDayState newEntryState) =>
      _statelify((MainStateBuilder state) {
        state.workPeriod.workDays.map((WorkDayState f) {
          if (isSameDate(f.date, newEntryState.date)) {
            print('found entry, updating it: ${f.date}');
            return newEntryState;
          }
          return f;
        });

      });

  Stream<WorkDayState> getWorkDayState(int index) =>
      state.map((MainState f) => f.workPeriod.workDays[index]);

  void _statelify(void stateChange(MainStateBuilder b)) {
    final state = _state.value.toBuilder();
    stateChange(state);
    _state.add(state.build());
  }
}
