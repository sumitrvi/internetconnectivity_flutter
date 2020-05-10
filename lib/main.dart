import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Here define multiple provider you can define multiple providers inside multiprovider
    return MultiProvider(
        providers: [
          StreamProvider(
              create: (context) => Connectivity().onConnectivityChanged),
        ],
        child: MaterialApp(
          title: 'Internet Connectivity',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: MyHomePage(title: 'Internet connectivity'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var connectionStatus;
  var _scafoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    connectionStatus = Provider.of<ConnectivityResult>(context);
    return Scaffold(
        key: _scafoldkey,
        appBar: AppBar(
          title: Text('Internet connectivity'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "You are ${(connectionStatus != ConnectivityResult.none ? 'Online' : 'Offline')}",
                style: Theme.of(context).textTheme.display1,
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                onPressed: () {
                  if (connectionStatus == ConnectivityResult.wifi ||
                      connectionStatus == ConnectivityResult.mobile) {
                    _scafoldkey.currentState.hideCurrentSnackBar();
                    _scafoldkey.currentState.showSnackBar(SnackBar(
                        content: Text(
                      ""
                      "You are online!",
                      style: TextStyle(color: Colors.red,fontSize:18.0),
                    )));
                  } else {
                    _scafoldkey.currentState.hideCurrentSnackBar();
                    _scafoldkey.currentState.showSnackBar(SnackBar(
                        content: Text(
                      ""
                      "You are offline!",
                          style: TextStyle(color: Colors.red,fontSize:18.0),
                    )));
                  }
                },
                child: Text('Check Status'),
              )
            ],
          ),
        ));
  }
}
