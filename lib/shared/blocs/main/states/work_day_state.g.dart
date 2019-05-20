// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_day_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkDayState extends WorkDayState {
  @override
  final DateTime date;
  @override
  final int hours;
  @override
  final int minutes;
  @override
  final double hoursWorked;

  factory _$WorkDayState([void Function(WorkDayStateBuilder) updates]) =>
      (new WorkDayStateBuilder()..update(updates)).build();

  _$WorkDayState._({this.date, this.hours, this.minutes, this.hoursWorked})
      : super._() {
    if (date == null) {
      throw new BuiltValueNullFieldError('WorkDayState', 'date');
    }
    if (hours == null) {
      throw new BuiltValueNullFieldError('WorkDayState', 'hours');
    }
    if (minutes == null) {
      throw new BuiltValueNullFieldError('WorkDayState', 'minutes');
    }
    if (hoursWorked == null) {
      throw new BuiltValueNullFieldError('WorkDayState', 'hoursWorked');
    }
  }

  @override
  WorkDayState rebuild(void Function(WorkDayStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkDayStateBuilder toBuilder() => new WorkDayStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkDayState &&
        date == other.date &&
        hours == other.hours &&
        minutes == other.minutes &&
        hoursWorked == other.hoursWorked;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, date.hashCode), hours.hashCode), minutes.hashCode),
        hoursWorked.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WorkDayState')
          ..add('date', date)
          ..add('hours', hours)
          ..add('minutes', minutes)
          ..add('hoursWorked', hoursWorked))
        .toString();
  }
}

class WorkDayStateBuilder
    implements Builder<WorkDayState, WorkDayStateBuilder> {
  _$WorkDayState _$v;

  DateTime _date;
  DateTime get date => _$this._date;
  set date(DateTime date) => _$this._date = date;

  int _hours;
  int get hours => _$this._hours;
  set hours(int hours) => _$this._hours = hours;

  int _minutes;
  int get minutes => _$this._minutes;
  set minutes(int minutes) => _$this._minutes = minutes;

  double _hoursWorked;
  double get hoursWorked => _$this._hoursWorked;
  set hoursWorked(double hoursWorked) => _$this._hoursWorked = hoursWorked;

  WorkDayStateBuilder();

  WorkDayStateBuilder get _$this {
    if (_$v != null) {
      _date = _$v.date;
      _hours = _$v.hours;
      _minutes = _$v.minutes;
      _hoursWorked = _$v.hoursWorked;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkDayState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WorkDayState;
  }

  @override
  void update(void Function(WorkDayStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WorkDayState build() {
    final _$result = _$v ??
        new _$WorkDayState._(
            date: date,
            hours: hours,
            minutes: minutes,
            hoursWorked: hoursWorked);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
