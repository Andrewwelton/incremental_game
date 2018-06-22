import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:async/async.dart';

import 'models/app_state.dart';
import 'models/company.dart';
import 'components/home_screen.dart';
import 'components/staff_screen.dart';
import 'actions/actions.dart';
import 'reducers/app_state_reducer.dart';

String debug(String preMessage, String thing) {
  print('DEBUG THING');
  print(preMessage);
  print(thing);
  return thing;
}

void main() {
  final persistor = new Persistor<AppState>(
    storage: new FlutterStorage("startup-simulator"),
    transforms: Transforms(
      onSave: [
        (state) => state.company == null ? state.copyWith(company: new Company(companyName: '', ceoName: '')) : state
      ]
    ),
    version: 1,
    migrations: {},
    decoder: AppState.fromJson,
  );

  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(),
    middleware: [persistor.createMiddleware()],
  );

  persistor.load(store);

  runApp(new StartupSimulatorApp(
    title: 'Startup Simulator',
    store: store,
  ));
}

class StartupSimulatorApp extends StatelessWidget {
  final Store<AppState> store;
  final String title;

  StartupSimulatorApp({Key key, this.store, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: new MaterialApp(
        theme: new ThemeData.dark(),
        title: title,
        home: DefaultTabController(
          length: 3,
          child: Scaffold (
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.people)),
                  Tab(icon: Icon(Icons.arrow_upward))
                ]
              )
            ),
            body: TabBarView(
              children: [
                HomeScreen(),
                StaffScreen(),
                Icon(Icons.arrow_upward)
              ]
            ),
          )
        )
      )
    );
  }
}

class PersonnelListState extends State<PersonnelList> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(textToShow) {
    return new ListTile(title: new Text(textToShow, style: _biggerFont));
  }
  
  Widget _buildList() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if(i.isOdd){
          return new Divider();
        }

        return _buildRow("Test Text " + i.toString());
      },
    );
  }

  Widget build(BuildContext context) {
    return _buildList();
  }
}

class PersonnelList extends StatefulWidget {
  @override
  createState() => new PersonnelListState();
}
