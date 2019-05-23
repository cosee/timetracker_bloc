import 'package:rxdart/rxdart.dart';

import 'package:time_track/shared/blocs/main/blocs.dart';

class EditorBlocInteractor {
  EditorBlocInteractor(this.sink);

  //The Editor needs to cache its state.
  //Only when the user hits the 'Save Changes' Button we want to update
  // our main state and by that the repositories.
  final cachedState = BehaviorSubject<WorkDayState>.seeded(null);

  // Output for TravelBloc update
  Sink<WorkDayState> sink;

  void clearEntry(ClearEntryAction action) => _statelify((state) {
        // The DB repository interpretes hoursWorked<0 as to delete the entry
        state.hoursWorked = 0;
        print(state);
      });

  // write cache back to store
  void saveChanges(SaveChangesAction action) =>
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

  // Convenience method for making our state modifiable
  void _statelify(WorkDayStateBuilder stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value.toBuilder();
    stateChange(state);
    //Back to where you came from!
    sink.add(state.build()); //Update our real state, back in the MainBloc
  }

  // Convenience method for making our state modifiable
  void _cacheState(void stateChange(WorkDayStateBuilder b)) {
    final state = cachedState.value?.toBuilder();
    stateChange(state);
    var newState = state.build();
    // print('state in changes is ${newState.toString()}');
    cachedState.add(newState); //Updating our cached state
  }
}
