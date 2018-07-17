import 'package:flutter/material.dart';
import 'package:app_av_1/lugares.dart';

void main() => runApp(new MyApp());
final saved = new Set<Lugar>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App Aviles',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'App Aviles'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _suggestions = <Lugar>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('App Aviles'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      //itemBuilder: (context, index) => new LugarSummary(lugares[index]),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        final index = i ~/ 2;
        print('index = $i');
        final item = lugares[index];
        for (var l in lugares)
        {
          print('item = $l');
          //return _buildRow(item);
        }
      },
    );
  }

  Widget _buildRow(Lugar lugar) {
    final alreadySaved = saved.contains(lugar);
    return new ListTile(
      title: new Text(lugar.name,style: _biggerFont,),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
            if (alreadySaved) {saved.remove(lugar);
            } else {saved.add(lugar);
            }
          },
        );
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = saved.map((pair) {return new ListTile(title: new Text(pair.name, style: _biggerFont,),);}, );
          final divided = ListTile.divideTiles(context: context,tiles: tiles,).toList();
          return new Scaffold(
            appBar: new AppBar(title: new Text('Favoritos')),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}

class LugarSummary extends StatelessWidget {
  final Lugar lugar;
  final bool horizontal;
  static Lugar lug;

  final alreadySaved = saved.contains(lug);

  LugarSummary(this.lugar, {this.horizontal = true});

  LugarSummary.vertical(this.lugar) : horizontal = false;


  Widget buildCard(String name, String imag, String desc){
    return new Card(
        color: Colors.yellowAccent,
        shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(44.0))),
        child:  new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //new HomePageBody(),
            new Container(
              color: Colors.purple,
              alignment: Alignment.center,
              padding: EdgeInsets.all(4.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new Text(name,style: new TextStyle(fontSize: 23.0, color: Colors.lightGreen),textAlign: TextAlign.center, ),
                ],
              ),
            ),
            new Divider(color: Colors.red,),
            new Container(
              color: Colors.lightGreen,
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(imag),
                  ]

              ),
            ),
            new Container(
              color: Colors.lightBlue,
              child: new Column(
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        new IconButton(
                            icon: new Icon(Icons.speaker), onPressed: null),
                        new IconButton(
                            icon: new Icon(Icons.map), onPressed: null),
                        new IconButton(
                          icon: new Icon(
                          alreadySaved ? Icons.favorite : Icons.favorite_border,
                          color: alreadySaved ? Colors.red : null,
                          )

                        ),
                      ],
                    ),
                  ]
              ),
            ),
            new Container(
                color: Colors.red,
                padding: EdgeInsets.all(10.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    new Text(desc, maxLines: 1,overflow: TextOverflow.fade),
                  ],
                )
            )
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return buildCard(this.lugar.name, this.lugar.image, this.lugar.description);

  }



}
