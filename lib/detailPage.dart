import 'package:flutter/material.dart';
import 'package:udemy_api/model/data.dart';

class Detail extends StatefulWidget {
  data data1;
  Detail(this.data1);

  @override
  _State createState() => _State();
}

class _State extends State<Detail> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details page'),
        backgroundColor: Colors.indigo[900],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(
                  widget.data1.url,
                  height: 250.0,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 10.0,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          child: Text(widget.data1.id.toString(),),
                        ),
                      ),
                      SizedBox(width: 7.0,),
                      Expanded(
                        flex: 2,
                        child: Text(widget.data1.title),
                      )
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
