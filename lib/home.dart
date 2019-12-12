import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import '././model/data.dart';
import './detailPage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Color> _color = [
    Colors.indigo[300],
    Colors.indigo,
    Colors.indigo[600],
    Colors.indigo[800],
    Colors.indigo[900]
  ];

  Future<List<data>> getAll() async {
    var api = "https://jsonplaceholder.typicode.com/photos";
    var data1 = await http.get(api);

    var jsonData = json.decode(data1.body);

    List<data> ListOf = [];

    for (var i in jsonData) {
      data d = data(i["id"], i["title"], i["url"], i["thumbnailUrl"]);
      ListOf.add(d);
    }
    return ListOf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('json parsing app'),
        backgroundColor: Colors.indigo[900],
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => debugPrint("search"),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => debugPrint("add"),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("codewith YDC"),
              accountEmail: Text("ydc@gmail.com"),
              decoration: BoxDecoration(color: Colors.indigo[900]),
            ),
            ListTile(
              title: Text("First page"),
              leading: Icon(
                Icons.search,
                color: Colors.indigoAccent,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Second page"),
              leading: Icon(
                Icons.add,
                color: Colors.indigoAccent,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Third page"),
              leading: Icon(
                Icons.home,
                color: Colors.indigoAccent,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Fourth page"),
              leading: Icon(
                Icons.list,
                color: Colors.indigoAccent,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Close"),
              leading: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10.0),
              height: 250.0,
              child: FutureBuilder(
                future: getAll(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Center(
                      child: ListTile(
                        title: Text("Loading..."),
                        leading: CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int idx) {
                          Color mColor = _color[idx % _color.length];
                          return Card(
                            elevation: 10.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  snapshot.data[idx].url,
                                  height: 150.0,
                                  width: 150.0,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                  height: 7.0,
                                ),
                                Container(
                                  margin: EdgeInsets.all(6.0),
                                  height: 50.0,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        child: CircleAvatar(
                                          child: Text(
                                              snapshot.data[idx].id.toString()),
                                          backgroundColor: mColor,
                                          foregroundColor: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.0,
                                      ),
                                      Container(
                                        width: 80.0,
                                        child: Text(
                                          snapshot.data[idx].title,
                                          maxLines: 1,
                                          style:
                                              TextStyle(color: Colors.indigo),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
                },
              )),
          SizedBox(
            height: 7.0,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height,
            child: FutureBuilder(
              future: getAll(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Container();
                  /*return Center(
                    child: ListTile(
                      title: Text("Loading..."),
                      leading: CircularProgressIndicator(),
                    ),
                  );*/
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int idx) {
                        Color mColor = _color[idx % _color.length];
                        return Card(
                          elevation: 7.0,
                          child: Container(
                            height: 100.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Image.network(
                                    snapshot.data[idx].url,
                                    height: 100.0,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 6.0,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: InkWell(
                                    child: Text(
                                      snapshot.data[idx].title,
                                      style: TextStyle(fontSize: 16.0),
                                      maxLines: 2,
                                    ),
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext c)=> Detail(snapshot.data[idx])
                                      ));
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: CircleAvatar(
                                      child: Text(
                                          snapshot.data[idx].id.toString()),
                                      backgroundColor: mColor,
                                      foregroundColor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
