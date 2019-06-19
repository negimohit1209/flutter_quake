import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() async {
  Intl.defaultLocale = 'pt_BR';
  Map _data = await getJSON();
  var format = new DateFormat("yMd");
  var dateString = format.format(_data['features'][0]['properties']['time'] * 1000);
  print(dateString);
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Quake"),
      ),
      body: ListView.builder(
        itemCount: _data['features'].length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Divider(
                height: 3.4,
              ),
              // _data['features'][index]['properties']['mag']
              ListTile(
                onTap: () => print('tapped'),
                title: Text("fsfasdfas"),
                subtitle: Text("${_data['features'][index]['properties']['place']}"),
                leading: CircleAvatar(backgroundColor: Colors.greenAccent,child: Text('${_data['features'][index]['properties']['mag']}'),)
              )
            ],
          );
        },
      ),
    ),
  ));
}

Future<Map> getJSON() async {
  String APIURL = "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson";
  http.Response response = await http.get(APIURL);
  return json.decode(response.body);
}
