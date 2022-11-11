import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const predicament());
}

class predicament extends StatelessWidget {
  const predicament({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final myController = TextEditingController();
  late String title;
  String text = "No Value Entered";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  void _setText() {
    setState(() {
      text = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text(
            "Weather App",
            style: TextStyle(color: Color(0xff230000)),
          ),
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: TextField(
                    onChanged: (value) => title = value,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(hintText: 'Enter city name'),
                    controller: myController,
                  ),
                  width: MediaQuery.of(context).size.width * 0.5,
                ),

                //////////////////////////
                ElevatedButton(
                    onPressed: _setText,
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(8),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey)),
                    child: const Text('Submit')),
                // RaisedButton is deprecated and should not be used
                // Use ElevatedButton instead

                // RaisedButton(
                //     onPressed: _setText,
                //     child: Text('Submit'),
                //     elevation: 8,
                // ),
                const SizedBox(
                  height: 20,
                ),
                Text(text),

                //////////////

                FutureBuilder(
                    future: apicall(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey,
                                  ),
                                  height: 80,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Latitude: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                              "${snapshot.data['lat'].toString()}"),
                                          // Image.network('http://openweathermap.org/img/w/${json['weather']['icon']}.png',),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey,
                                ),
                                height: 80,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text("Longitude: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                                        Text(
                                            "${snapshot.data['lon'].toString()}\u00B0F"),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Text()
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ] //children
                            ),
                            Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.blueGrey,
                                      ),
                                    height: 80,
                                    width: 300,
                                      child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Temperature: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                                          Text("${snapshot.data['temp'].toString()}\u00B0F"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey,
                                ),
                                height: 80,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Feels like: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.0),
                                        ),
                                        Text(
                                            "${snapshot.data['feelsLike'].toString()}\u00B0F"),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ] //children
                                ),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey,
                                  ),
                                  height: 80,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Max Temp: ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                              "${snapshot.data['max'].toString()}\u00B0F"),
                                          // Image.network('http://openweathermap.org/img/w/${json['weather']['icon']}.png',),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey,
                                ),
                                height: 80,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text("Min Temp: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                                        Text(
                                            "${snapshot.data['min'].toString()}\u00B0F"),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Text()
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ] //children
                            ),
                            Row(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.blueGrey,
                                  ),
                                  height: 80,
                                  width: 300,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Sunrise:",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14.0),
                                          ),
                                          Text(
                                              "${(DateTime.fromMillisecondsSinceEpoch((snapshot.data['sr'])))}"),
                                          // Image.network('http://openweathermap.org/img/w/${json['weather']['icon']}.png',),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.blueGrey,
                                ),
                                height: 80,
                                width: 300,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.center,
                                      children: [
                                        Text("Sunset: ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                                        Text(
                                            "${(DateTime.fromMillisecondsSinceEpoch((snapshot.data['ss'])))}"),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment: MainAxisAlignment.center,
                                    //   children: [
                                    //     Text()
                                    //   ],
                                    // )
                                  ],
                                ),
                              ),
                            ] //children
                            ),
                          ],
                        );
                      } //if
                      else {
                        return CircularProgressIndicator();
                      } //else
                    } //builder

                    )
              ],
            )
          ],
        ));
  }
}

Future apicall() async {
  final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?zip=560048,in&appid=6f5f72d25bfbad1f08126182ee55dd6e");
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['main']);
  final output = {
    'weather': json['weather'][0]['description'],
    'temp': json['main']['temp'],
    'feelsLike': json['main']['feels_like'],
    'lat': json['coord']['lat'],
    'lon': json['coord']['lon'],
    'min':json['main']['temp_min'],
    'max':json['main']['temp_max'],
    'sr': json['sys']['sunrise'],
    'ss':json['sys']['sunset'],
    //'ico': json["weather"]["icon"],
  };
  return output;
}
