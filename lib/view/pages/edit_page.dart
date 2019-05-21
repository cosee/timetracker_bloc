import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';

import 'package:time_track/view/pages/drawer/main_drawer.dart';
import 'package:time_track/view/shared/widgets/centered_loading_spinner.dart';
import 'package:time_track/view/shared/widgets/period_selector.dart';
import 'package:time_track/view/shared/widgets/edit_row.dart';
import 'package:time_track/view/shared/widgets/times_editor.dart';
import 'package:time_track/shared/blocs/main/blocs.dart';

class EditPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditPageState();
  }
}

class _EditPageState extends State<EditPage> with TickerProviderStateMixin {
  MainBloc mainBloc = MainBloc(MainBlocInteractor());

  AnimationController _animationController;
  double _animatedHeight = 0;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(accentColor: Colors.blue),
        home: Scaffold(
          drawer: MainDrawer(context, EditPage),
          appBar: AppBar(title: Text('Edit Work Times')),
          body: StreamBuilder(
            stream: mainBloc.state,
            initialData: mainBloc.initialState(),
            builder: (context, AsyncSnapshot<MainState> snapshot) {
              return snapshot.hasData
                  ? _buildUI(context, snapshot.data)
                  : CenteredLoadingSpinner(text: 'Waiting!');
            },
          ),
        ));
  }

  _buildUI(BuildContext context, MainState state) => Column(
        children: <Widget>[
          _createPeriodSelector(),
          _createTableHead(),
          _buildTimesList(context, state),
          _createTimesEditor(context, state),
        ],
      );

  _createPeriodSelector() => PeriodSelector(
        DateTime.now(),
        DateTime.now().add(Duration(days: 31)),
        _selectPeriod,
      );

  _createTableHead() => Container(
        margin: EdgeInsets.only(top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 70,
              child: Text('Weekday'),
            ),
            Container(
              width: 80,
              child: Text('Date'),
            ),
            Container(
              width: 50,
              child: Text('Begin'),
            ),
            Container(
              width: 100,
              child: Text('Hours worked'),
            ),
          ],
        ),
      );

  Widget _buildTimesList(BuildContext context, MainState state) {
    Widget timesList = Center(child: Text('No Times persisted yet'));

    print('building list!');
    if (state.workPeriod.workDays.length > 0) {
      timesList = ListView(
        children: _buildProductItemList(context, state),
      );
    }

    return Flexible(flex: 5, child: timesList);
  }

  List<Widget> _buildProductItemList(
    BuildContext context,
    MainState state,
  ) {
    int index = 0;
    return state.workPeriod.workDays
        .map((f) => EditRow(
              workEntry: f,
              index: index,
              selectDay: (int idx) => _selectDay(idx, state),
              isSelected: state.selectedIndex == index++,
            ))
        .toList();
  }

  Widget _createTimesEditor(
    BuildContext context,
    MainState state,
  ) {
    print('building timesEditor');
    var timesEditor = AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      height: _animatedHeight,
      child: SingleChildScrollView(
        child: TimesEditor(
          index: state.selectedIndex,
          clearButtonEnabled: state.selectedDay.isEnabled(),
          stream: mainBloc.workDayState(state.selectedIndex),
          sink: mainBloc.updateEntry,
        ),
      ),
    );
    return timesEditor;
  }

  void _selectPeriod(DateTime begin, DateTime end) {
    // mainBloc.selectPeriod.add();
    // //TODO: make blocish
    // setState(() {
    //   _dbLoaded = false;
    //   _loadDates(begin, end);
    // });
  }

  void _selectDay(int index, MainState state) {
    _showDrawer(index, state);
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    mainBloc.selectDate.add(SelectDateAction(index));
  }

/**
 * Slide in on each click on a row. Slide out on second click on same row.
 * Stays out while clicking on different row.
 */
  _showDrawer(int index, MainState state) {
    setState(() {
      print(
          '_animatedHeight:$_animatedHeight; selectedIndex:$state.selectedIndex; index:$index');
      if (state.selectedIndex == index) {
        _animatedHeight != 0.0
            ? _animatedHeight = 0.0
            : _animatedHeight = 133.0;
      } else {
        if (_animatedHeight == 0.0) {
          _animatedHeight = 133.0;
        }
      }
    });
  }
}
