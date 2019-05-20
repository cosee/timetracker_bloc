// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_period_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WorkPeriodState extends WorkPeriodState {
  @override
  final DateTime periodBegin;
  @override
  final DateTime periodEnd;
  @override
  final BuiltList<WorkDayState> workDays;

  factory _$WorkPeriodState([void Function(WorkPeriodStateBuilder) updates]) =>
      (new WorkPeriodStateBuilder()..update(updates)).build();

  _$WorkPeriodState._({this.periodBegin, this.periodEnd, this.workDays})
      : super._() {
    if (periodBegin == null) {
      throw new BuiltValueNullFieldError('WorkPeriodState', 'periodBegin');
    }
    if (periodEnd == null) {
      throw new BuiltValueNullFieldError('WorkPeriodState', 'periodEnd');
    }
    if (workDays == null) {
      throw new BuiltValueNullFieldError('WorkPeriodState', 'workDays');
    }
  }

  @override
  WorkPeriodState rebuild(void Function(WorkPeriodStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WorkPeriodStateBuilder toBuilder() =>
      new WorkPeriodStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WorkPeriodState &&
        periodBegin == other.periodBegin &&
        periodEnd == other.periodEnd &&
        workDays == other.workDays;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, periodBegin.hashCode), periodEnd.hashCode),
        workDays.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WorkPeriodState')
          ..add('periodBegin', periodBegin)
          ..add('periodEnd', periodEnd)
          ..add('workDays', workDays))
        .toString();
  }
}

class WorkPeriodStateBuilder
    implements Builder<WorkPeriodState, WorkPeriodStateBuilder> {
  _$WorkPeriodState _$v;

  DateTime _periodBegin;
  DateTime get periodBegin => _$this._periodBegin;
  set periodBegin(DateTime periodBegin) => _$this._periodBegin = periodBegin;

  DateTime _periodEnd;
  DateTime get periodEnd => _$this._periodEnd;
  set periodEnd(DateTime periodEnd) => _$this._periodEnd = periodEnd;

  ListBuilder<WorkDayState> _workDays;
  ListBuilder<WorkDayState> get workDays =>
      _$this._workDays ??= new ListBuilder<WorkDayState>();
  set workDays(ListBuilder<WorkDayState> workDays) =>
      _$this._workDays = workDays;

  WorkPeriodStateBuilder();

  WorkPeriodStateBuilder get _$this {
    if (_$v != null) {
      _periodBegin = _$v.periodBegin;
      _periodEnd = _$v.periodEnd;
      _workDays = _$v.workDays?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WorkPeriodState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$WorkPeriodState;
  }

  @override
  void update(void Function(WorkPeriodStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WorkPeriodState build() {
    _$WorkPeriodState _$result;
    try {
      _$result = _$v ??
          new _$WorkPeriodState._(
              periodBegin: periodBegin,
              periodEnd: periodEnd,
              workDays: workDays.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'workDays';
        workDays.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WorkPeriodState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
