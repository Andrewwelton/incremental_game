import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/staff.dart';
import '../models/app_state.dart';
import '../actions/actions.dart';

class StaffScreen extends StatelessWidget {
  final List<Staff> _staffList = List.of([
    new Staff(
      name: 'Old Gregg',
      linesOfCodeProduced: 20.0,
      cost: 100.0
    ),
    new Staff(
      name: 'Frank McCode',
      linesOfCodeProduced: 100.0,
      cost: 500.0
    ),
    new Staff(
      name: 'Bobert Robert',
      linesOfCodeProduced: 220.0,
      cost: 2500.0
    ),
    new Staff(
      name: 'Jaded Softer',
      linesOfCodeProduced: 300.0,
      cost: 10000.0
    ),
    new Staff(
      name: 'CodeBot 3000',
      linesOfCodeProduced: 678.0,
      cost: 25000.0
    ),
    new Staff(
      name: 'Code God',
      linesOfCodeProduced: 987.0,
      cost: 50000.0
    ),
    new Staff(
      name: 'Gerald',
      linesOfCodeProduced: 1500.0,
      cost: 150000.0
    ),
  ]);
  
  ListView _buildListView(List<Staff> hiredStaff) {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _staffList.length,
      itemBuilder: (BuildContext context, int index) {
        final staff = _staffList[index];
        print(hiredStaff);
        return new ListTile(
          title: new Text(staff.name),
          subtitle: new Text('Code Production: ${staff.linesOfCodeProduced.toString()}'),
          trailing: hiredStaff != null && hiredStaff.contains(staff) ? new Text('Hired') :
            new StoreConnector<AppState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(
                  new HireStaffAction(staff)
                );
              },
              builder: (context, callback) {
                return new RaisedButton(
                  child: new Text('Hire - ${staff.cost}'),
                  onPressed: callback,
                );
              }
            )
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return _buildListView(vm.hiredStaff);
      }
    );
  }
}

class _ViewModel {
  final List<Staff> hiredStaff;

  _ViewModel({
    @required this.hiredStaff,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(hiredStaff: store.state.company.currentStaff);
  }
}