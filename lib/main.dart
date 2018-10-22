import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'Objeto.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Correios SOAP Flutter',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Correios SOAP Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String resposta="";

  //101 para portugues, 102 para ingles

  void _callCorreiosRastreamento() async {

    //ex.: AB123456789BR
    String codigo = "PS364496594BR";

    String envelope =
        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" "
        +"xmlns:res=\"http://resource.webservice.correios.com.br/\"> "
        +"   <soapenv:Header/> "
        +"   <soapenv:Body>  "
        +"      <res:buscaEventosLista> "
        +"         <usuario>ECT</usuario> "
        +"         <senha>SRO</senha>  "
        +"         <tipo>L</tipo>  "
        +"         <resultado>T</resultado>  "
        +"         <lingua>101</lingua> "
        +"         <objetos>"+codigo+"</objetos> "
        +"      </res:buscaEventosLista>  "
        +"   </soapenv:Body> "
        +"</soapenv:Envelope>"
    ;

    final response =
    await http.post("http://webservice.correios.com.br:80/service/rastro",
        headers: {"Content-Type": "text/xml",
        },body: envelope,);

    Objeto objeto = Objeto(xml.parse(response.body).findAllElements("objeto"));


    setState(() {
      resposta =
          "Número:"+objeto.numero+"\n"
              +"Categoria:"+objeto.categoria+"\n"
              +"Descrição:"+objeto.descricao+"\n"
              +"Data:"+objeto.data+"\n"
              +"Hora:"+objeto.hora+"\n";
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text(resposta),),
      floatingActionButton: FloatingActionButton(
        onPressed: _callCorreiosRastreamento,
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
