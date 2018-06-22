import 'package:flutter/material.dart';
import 'package:async/async.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../models/company.dart';
import '../models/app_state.dart';
import '../actions/actions.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        if (vm.currentCompany != null && vm.currentCompany.companyName.length > 0) {
          return new Column(
            children: [
              new Row(
                children: [
                  new Text(
                    'Company Name: ' + vm.currentCompany.companyName,
                    style: TextStyle(fontSize: 18.0),
                  )
                ]
              ),
              new Row(
                children: [
                  new Text(
                    'CEO Name: ' + vm.currentCompany.ceoName,
                    style: TextStyle(fontSize: 18.0)
                  )
                ]
              ),
              new Row(
                children: [
                  new Text('')
                ]
              ),
              new Row(
                children: [
                  new Text(
                    'Current Lines of Code Written: ${vm.currentCompany.currentLinesOfCode}',
                    style: TextStyle(fontSize: 16.0)
                  )
                ]
              ),
              new Row(
                children: [
                  new Text(
                    'Current Code Production: ${vm.currentCompany.linesOfCodeProducedPerTick}/tap',
                    style: TextStyle(fontSize: 16.0)
                  )
                ]
              ),
              new Row(
                children: [
                  new Text(
                    'Current Cash: ${vm.currentCompany.companyCash}',
                    style: TextStyle(fontSize: 16.0)
                  )
                ]
              ),
              new Row(
                children: [
                  new Text('')
                ]
              ),
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new StoreConnector<AppState, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(new AddLinesOfCodeAction(5.0));
                    },
                    builder: (context, callback) {
                      return new RaisedButton(
                        onPressed: callback,
                        child: new Text('Code!')
                      );
                    }
                  ),
                  new StoreConnector<AppState, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(new ReleaseProductAction());
                    },
                    builder: (context, callback) {
                      return new RaisedButton(
                        onPressed: callback,
                        child: new Text('Release!')
                      );
                    }
                  )
                ]
              ),
              new Row(
                children: [
                  new Text('')
                ]
              ),
              new Row(
                children: [
                  new Text('')
                ]
              ),
              new StoreConnector<AppState, VoidCallback>(
                converter: (store) {
                  return () => store.dispatch(
                    new ResetCompanyAction()
                  );
                },
                builder: (context, callback) {
                  return new RaisedButton(
                    child: new Text('Reset Company'),
                    onPressed: callback,
                    color: new Color(0xFFF00000),
                  );
                }
              ),
            ]
          );
        }
        return CompanyForm();
      }
    );
  }
}

class CompanyForm extends StatefulWidget {
  @override
  _CompanyFormState createState() => _CompanyFormState();
}

class _CompanyFormState extends State<CompanyForm> {
  final companyNameController = TextEditingController();
  final ceoNameController = TextEditingController();

  @override
  void dispose() {
    companyNameController.dispose();
    ceoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        Text('Company Name:'),
        TextField(
          controller: companyNameController,
        ),
        Text('CEO Name'),
        TextField(
          controller: ceoNameController,
        ),
        new StoreConnector<AppState, VoidCallback>(
          converter: (store) {
            return () => store.dispatch(
              new SetCompanyAction(
                new Company(
                  companyName: companyNameController.text,
                  ceoName: ceoNameController.text,
                  linesOfCodeProducedPerTick: 5.0,
                  companyCash: 1000.0
                )
              )
            );
          },
          builder: (context, callback) {
            return new RaisedButton(
              child: new Text('Save Company & Start!'),
              onPressed: callback
            );
          }
        )
      ],
    );
  }
}

class _ViewModel {
  final Company currentCompany;

  _ViewModel({
    @required this.currentCompany,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    if(store.state.company != null && store.state.company.companyName.length > 0) {
      return new _ViewModel(
        currentCompany: store.state.company
      );
    }
    return new _ViewModel(
      currentCompany: store.state.company
    );
  }

  @override
  bool operator ==(Object other) =>
    identical(this, other) ||
    other is _ViewModel &&
      currentCompany == other.currentCompany;
}