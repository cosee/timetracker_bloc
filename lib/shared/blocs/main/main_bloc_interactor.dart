import 'package:rxdart/rxdart.dart';

import 'package:time_track/model/work_period.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';
import 'package:time_track/shared/helper/compare.dart';
import 'package:time_track/db/entities/work_day_db.dart';

class MainBlocInteractor {
  //Our main state, while the app is up and running
  // We seed null now, since the real data is only available later after DB access.
  final _state = BehaviorSubject<MainState>.seeded(null);
  
  //Seeding null is the same as:
  // final _state = BehaviorSubject<MainState>();

  MainState initialState() => _state.value;
  Stream<MainState> get state => _state.stream.distinct();

  MainBlocInteractor() {
    var now = DateTime.now();
    //At creation time start to load the data from the DB
    _loadDates(now, now.add(Duration(days: 30)));
  }

  void selectDate(SelectDateAction action) => _statelify(
      (MainStateBuilder state) => state.selectedIndex = action.index);

  //This is our SubBlocs way of updating the main state.
  void updateEntry(WorkDayState newEntryState) =>
      _statelify((MainStateBuilder state) {
        state.workPeriod.workDays.map((WorkDayState f) {
          if (isSameDate(f.date, newEntryState.date)) {
            WorkDayDb().insert(newEntryState.toBusiness()).then((onValue) {
              print('db reponse $onValue');
            });
            return newEntryState;
          }
          return f;
        });
      });

  //We transform each element of our main-state-stream into a stream containing only
  // a sub-set of the data.
  Stream<WorkDayState> getWorkDayState(int index) =>
      state.map((MainState f) => f.workPeriod.workDays[index]);

  void _loadDates(DateTime begin, DateTime end) {
    WorkDayDb().getAll().then((workDays) {
      WorkPeriod period;
      if (workDays.isNotEmpty) {
        print('loaded ${workDays.length} dates ');
        period =
            WorkPeriod(periodBegin: begin, periodEnd: end, workDays: workDays);
      } else {
        print('No dates stored yet');
        period = WorkPeriod(periodBegin: begin, periodEnd: end);
      }
      _state.add(MainState(workPeriod: period));
    });
  }

  // Convenience method for making our state modifiable
  void _statelify(void stateChange(MainStateBuilder b)) {
    final state = _state.value.toBuilder();
    stateChange(state);
    _state.add(state.build());
  }
}
