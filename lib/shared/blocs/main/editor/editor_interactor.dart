import 'package:rxdart/rxdart.dart';

import 'package:time_track/shared/blocs/main/blocs.dart';

class EditorBlocInteractor {
  EditorBlocInteractor(this.sink);

  void updateState(WorkDayState newState) {
    // print('state gets updated from root-stream!');

    cachedState.add(newState);
  }

  final cachedState = BehaviorSubject<WorkDayState>.seeded(null);

  // Output for TravelBloc update
  Sink<WorkDayState> sink;

  void clearEntry(ClearEntryAction action) => _statelify((state) {
        // state = WorkDayState.empty().toBuilder();
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
        // print('state in changes is ${state.build().toString()}');
      });

  void _statelify(WorkDayStateBuilder stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value.toBuilder();
    stateChange(state);
    sink.add(state.build()); //Back to where you came from!
  }

  void _cacheState(void stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value?.toBuilder();
    stateChange(state);
    var newState = state.build();
    // print('state is now: \n${newState.toString()}');
    cachedState.add(newState); //Back to where you came from!
  }
}
