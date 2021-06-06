import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';

void main() {
  runApp(MaterialApp(
    theme: new ThemeData(
        colorScheme: ColorScheme.light(
      background: Colors.black,
    )),
    home: new HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map pokeData;

  fetchPokemonData() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.thingspeak.com/channels/1408525/feeds.json?api_key=Z39TIBA5I7P4372H&results=2"));
    setState(() {
      pokeData = json.decode(response.body);
      print('hello: $pokeData');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchPokemonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text("POKEMONE APP")),
        backgroundColor: Colors.lightBlue,
      ),
      body: new Container(
        child: new Center(
          child: pokeData == null
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: (pokeData.length),
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: new Card(
                        child: Center(
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Text("TEMP : " ),
                                  /*new Text("Id : " +
                                  pokeData["feeds"][index]['field1']
                                      .toString()),*/
                                  // new Image.network( pokeData['pokemon'][index]['img']),
                                  new CircularPercentIndicator(
                                    radius: 120.0,
                                    lineWidth: 10.0,
                                    percent: double.parse(
                                        pokeData["feeds"][0]["field1"]) /
                                        100,
                                    center: new Text(double.parse(
                                        pokeData["feeds"][0]["field1"])
                                        .toStringAsFixed(2)),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Text("humidity : " ),
                                  /*new Text("Id : " +
                                  pokeData["feeds"][index]['field1']
                                      .toString()),*/
                                  // new Image.network( pokeData['pokemon'][index]['img']),
                                  new CircularPercentIndicator(
                                    radius: 120.0,
                                    lineWidth: 10.0,
                                    percent: double.parse(
                                        pokeData["feeds"][0]["field2"]) /
                                        100,
                                    center: new Text(double.parse(
                                        pokeData["feeds"][0]["field2"])
                                        .toStringAsFixed(2)),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  new Text("AirQuality : " ),
                                  /*new Text("Id : " +
                                  pokeData["feeds"][index]['field1']
                                      .toString()),*/
                                  // new Image.network( pokeData['pokemon'][index]['img']),
                                  new CircularPercentIndicator(
                                    radius: 120.0,
                                    lineWidth: 10.0,
                                    percent: double.parse(
                                        pokeData["feeds"][0]["field3"]) /
                                        100,
                                    center: new Text(double.parse(
                                        pokeData["feeds"][0]["field3"])
                                        .toStringAsFixed(2)),
                                    progressColor: Colors.green,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
