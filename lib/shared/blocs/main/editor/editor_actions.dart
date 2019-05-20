class SaveChangesAction {
  SaveChangesAction(this.index);
  int index;
}

class ClearEntryAction {
  ClearEntryAction(this.index);
  final int index;
}

class CacheChangeAction {
  CacheChangeAction._({
    this.workHours,
    this.timeOfDay,
    this.date,
  });

  String workHours;
  DateTime timeOfDay;
  DateTime date;

  factory CacheChangeAction.cacheDate(DateTime date) =>
      CacheChangeAction._(date: date);
  factory CacheChangeAction.cacheTime(DateTime timeOfDay) =>
      CacheChangeAction._(timeOfDay: timeOfDay);
  factory CacheChangeAction.cacheWorkHours(String workHours) =>
      CacheChangeAction._(workHours: workHours);
}
