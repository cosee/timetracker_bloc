// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MainState extends MainState {
  @override
  final int selectedIndex;
  @override
  final WorkPeriod workPeriod;

  factory _$MainState([void Function(MainStateBuilder) updates]) =>
      (new MainStateBuilder()..update(updates)).build();

  _$MainState._({this.selectedIndex, this.workPeriod}) : super._() {
    if (selectedIndex == null) {
      throw new BuiltValueNullFieldError('MainState', 'selectedIndex');
    }
    if (workPeriod == null) {
      throw new BuiltValueNullFieldError('MainState', 'workPeriod');
    }
  }

  @override
  MainState rebuild(void Function(MainStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MainStateBuilder toBuilder() => new MainStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MainState &&
        selectedIndex == other.selectedIndex &&
        workPeriod == other.workPeriod;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, selectedIndex.hashCode), workPeriod.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MainState')
          ..add('selectedIndex', selectedIndex)
          ..add('workPeriod', workPeriod))
        .toString();
  }
}

class MainStateBuilder implements Builder<MainState, MainStateBuilder> {
  _$MainState _$v;

  int _selectedIndex;
  int get selectedIndex => _$this._selectedIndex;
  set selectedIndex(int selectedIndex) => _$this._selectedIndex = selectedIndex;

  WorkPeriod _workPeriod;
  WorkPeriod get workPeriod => _$this._workPeriod;
  set workPeriod(WorkPeriod workPeriod) => _$this._workPeriod = workPeriod;

  MainStateBuilder();

  MainStateBuilder get _$this {
    if (_$v != null) {
      _selectedIndex = _$v.selectedIndex;
      _workPeriod = _$v.workPeriod;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MainState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MainState;
  }

  @override
  void update(void Function(MainStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MainState build() {
    final _$result = _$v ??
        new _$MainState._(selectedIndex: selectedIndex, workPeriod: workPeriod);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
