import 'dart:ffi';

import 'package:flutter/material.dart';

import 'beike/page/home_page.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() => runApp(MyReduxApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class ReduxState {
  String name;
  String password;

  ReduxState(this.name, this.password);
}

ReduxState appReducer(ReduxState state, action) {
  return ReduxState(
      NameReducer(state.name, action), PasswordReducer(state.password, action));
}

final NameReducer = combineReducers<String>([
  TypedReducer<String, UpdateNameAction>((name, action) {
    return action.name;
  }),
]);

final PasswordReducer = combineReducers<String>([
  TypedReducer<String, UpdatePasswordAction>((password, action) {
    return action.password;
  }),
]);

class UpdateNameAction {
  final name;

  UpdateNameAction(this.name);
}

class UpdatePasswordAction {
  final password;

  UpdatePasswordAction(this.password);
}

class MyReduxApp extends StatelessWidget {
  final store = new Store<ReduxState>(appReducer,
      initialState: new ReduxState("未知", "123"));

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: new MaterialApp(
          home: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            StoreConnector<ReduxState, String>(
              converter: (store) => store.state.name,
              builder: (context, name) {
                return new Text(
                  name,
                  style: Theme.of(context).textTheme.display1,
                );
              },
            ),
            StoreConnector<ReduxState, String>(
              converter: (store) => store.state.password,
              builder: (context, password) {
                return Text(password);
              },
            ),
            StoreConnector<ReduxState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(UpdateNameAction("修改名字成功"));
              },
              builder: (context, callback) {
                return FlatButton(
                  child: Text("点击修改姓名"),
                  onPressed: () {
                    callback();
                  },
                );
              },
            ),
            StoreConnector<ReduxState, VoidCallback>(
              converter: (store) {
                return () => store.dispatch(UpdatePasswordAction("修改密码成功"));
              },
              builder: (context, callback) {
                return FlatButton(
                  child: Text("点击修改密码"),
                  onPressed: () {
                    callback();
                  },
                );
              },
            ),
            StoreConnector<ReduxState, Void>(
              builder: (context, value) {
                return FlatButton(
                  child: Text("of方式修改密码"),
                  onPressed: () {
                    StoreProvider.of<ReduxState>(context)
                        .dispatch(UpdatePasswordAction("通过of修改密码成功"));
                  },
                );
              }, converter: (Store store) {return null;},
            )
          ],
        ),
      )),
    );
  }
}
