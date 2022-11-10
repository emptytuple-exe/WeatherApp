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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text ("Weather App",
          style: TextStyle(color: Color(0xff230000)),
        ),
      ),
      body:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FutureBuilder(
                  future: apicall(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 20, 30, 40),
                            child: Text(snapshot.data['temp'].toString()),
                          ),
                          Text(snapshot.data['description'].toString())
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
        )
    );
  }
}

Future apicall()async {
  final url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?zip=560040,in&appid=6f5f72d25bfbad1f08126182ee55dd6e");
  final response = await http.get(url);
  print(response.body);
  final json = jsonDecode(response.body);
  print(json['weather'][0]['main']);
  final output = {
    'description': json['weather'][0]['description'],
    'temp': json['main']['temp']
  };
  return output;
  }

