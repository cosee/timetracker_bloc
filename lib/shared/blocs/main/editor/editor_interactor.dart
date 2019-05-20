import 'package:rxdart/rxdart.dart';

import 'package:time_track/shared/blocs/main/blocs.dart';

class EditorBlocInteractor {
  EditorBlocInteractor(this.sink);

  WorkDayState _lastState;
  WorkDayState get lastState =>
      _lastState; //FIXME: This is ugly... find better way
  void updateState(WorkDayState newState) {
    _lastState = newState;
    // cachedState = newState;
    cachedState.add(newState);
  }

  final cachedState = BehaviorSubject<WorkDayState>.seeded(null);

  // WorkDayState cachedState;

  // Output for TravelBloc update
  Sink<WorkDayState> sink;

  void clearEntry(ClearEntryAction action) => _statelify((state) {
        state = WorkDayState.empty().toBuilder();
        // return WorkDayState.empty().toBuilder();
        state.hoursWorked = 0;
        print(state);
      });

  void saveChanges(SaveChangesAction action) => // cache to store
      _statelify((state) => state = cachedState.value.toBuilder());

  void cacheChanges(CacheChangeAction action) => _cacheState((state) {
        if (null != action.date) {
          print('date');
          state.date = action.date;
        }
        if (null != action.timeOfDay) {
          print('timeOfDay :${action.timeOfDay}');

          state.hours = action.timeOfDay.hour;
          state.minutes = action.timeOfDay.minute;
        }
        if (null != action.workHours) {
          print('workHours');
          double hoursWorked = double.parse(action.workHours);
          state.hoursWorked = hoursWorked;
        }
      });

  void _statelify(WorkDayStateBuilder stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value.toBuilder();
    var returnedState = stateChange(state);
    sink.add(state.build()); //Back to where you came from!
  }

  void _cacheState(void stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value?.toBuilder();
    stateChange(state);
    print('state is now: \n${state.hoursWorked}');
    cachedState.add(state.build()); //Back to where you came from!
  }
}
