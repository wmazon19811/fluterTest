import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_1/models/images.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {
  List items = [];
  /* Esta es la funcion para leer el archivo data.json 
  * La lista "items" se va a llenar con los elementos "items" de  el archivo data.json  
  */
  Future<void> readJson() async{
   // final dio = Dio();
               
              
    //final  response = await dio.get('https://api.flickr.com/services/feeds/photos_public.gne?tags=priime&format=json&nojsoncallback=1');
        
    final String response = await rootBundle.loadString("assets/data2.json");
    final data = await json.decode(response.toString());
    setState((){
      items = data["items"]; 
    }
   
    );
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Cargar Url'),
        ),
        body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
          ElevatedButton(
            onPressed: readJson,
            child: const Text("Cargar...")
          ),
          items.isNotEmpty?
          Expanded(
            child: ListView.builder( // En este builder vamos a recorrer cada uno de los elementos de la List "items" que ya estan cargados del archivo data.json
              itemCount: items.length,
              itemBuilder: (context, index){
                return Card(
                  key: ValueKey(items[index]["title"]),
                  margin: const EdgeInsets.all(10),
                  color: Colors.amber.shade100,
                  child: Column(
                    children: [
                      Text(items[index]["title"]),
                      Center(
                        child: Image(image: NetworkImage(items[index]["media"]["m"].toString(),),
                        fit: BoxFit.fill,
                        ),
                        
                      ),
                      Text(items[index]["tags"]),
                    ],
                  )
                );
              },
            )
          ) : Container()
          ]
        )
      )
      )
    );
  }
}

