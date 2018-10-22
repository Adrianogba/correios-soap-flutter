import 'package:xml/xml.dart' as xml;

class Objeto{

  String erro;

  String numero;
  String sigla;
  String nome;
  String categoria;

  String tipo;
  String status;
  String data;
  String hora;
  String descricao;
  String detalhe;
  String local;
  String codigo;
  String cidade;
  String uf;


  Objeto(Iterable<xml.XmlElement> obj){
    try{
      erro=obj.first.findElements("erro").first.text;

    }catch(e){

      numero=obj.first.findElements("numero").first.text;
      sigla=obj.first.findElements("sigla").first.text;
      nome=obj.first.findElements("nome").first.text;
      categoria=obj.first.findElements("categoria").first.text;

      tipo=obj.first.findAllElements("evento").toList()[0].findElements("tipo").first.text;
      status=obj.first.findAllElements("evento").toList()[0].findElements("status").first.text;
      data=obj.first.findAllElements("evento").toList()[0].findElements("data").first.text;
      hora=obj.first.findAllElements("evento").toList()[0].findElements("hora").first.text;
      descricao=obj.first.findAllElements("evento").toList()[0].findElements("descricao").first.text;
      detalhe=obj.first.findAllElements("evento").toList()[0].findElements("detalhe").first.text;
      local=obj.first.findAllElements("evento").toList()[0].findElements("local").first.text;
      codigo=obj.first.findAllElements("evento").toList()[0].findElements("codigo").first.text;
      cidade=obj.first.findAllElements("evento").toList()[0].findElements("cidade").first.text;
      uf=obj.first.findAllElements("evento").toList()[0].findElements("uf").first.text;

    }

  }

}