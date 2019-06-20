import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Map _data;
List _features;
void main() async {
  // Intl.defaultLocale = 'pt_BR';
  _data = await getJSON();
  _features = _data['features'];
  // var format = new DateFormat("yMd");
  // var dateString = format.format(_data['features'][0]['properties']['time'] * 1000);
  // print(dateString);
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Quake"),
      ),
      body: ListView.builder(
        itemCount: _features.length,
        padding: const EdgeInsets.all(15.0),
        itemBuilder: (BuildContext context, int index) {
          var format = new DateFormat.yMMMMd('en_US').add_jm();

          var date = format.format(DateTime.fromMicrosecondsSinceEpoch(
              _features[index]['properties']['time'] * 1000,
              isUtc: true));
          return Column(
            children: <Widget>[
              Divider(
                height: 3.4,
              ),
              ListTile(
                  onTap: () { _showAlertMessage(context, "${_features[index]['properties']['title']}") ;}, 
                                    title: Text(
                                      "$date",
                                      style: TextStyle(
                                          fontSize: 19.5,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.orange),
                                    ),
                                    subtitle: Text("${_features[index]['properties']['place']}",
                                        style: TextStyle(
                                            fontSize: 14.5,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey,
                                            fontStyle: FontStyle.italic)),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Text('${_features[index]['properties']['mag']}',
                                          style: TextStyle(
                                              fontSize: 16.5,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontStyle: FontStyle.normal)),
                                    ))
                              ],
                            );
                          },
                        ),
                      ),
                    ));
                  }
                  
                  void _showAlertMessage(BuildContext context, String message) {
                    var alert = AlertDialog(
                      title: Text("Quakes"),
                      content: Text(message),
                      actions: <Widget>[
                        FlatButton(onPressed: (){Navigator.pop(context);},
                          child: Text("OK"),
                        )
                      ],

                    );
                    showDialog(context: context, child: alert);
}

Future<Map> getJSON() async {
  String APIURL =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
  http.Response response = await http.get(APIURL);
  return json.decode(response.body);
}
