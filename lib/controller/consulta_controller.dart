import 'dart:convert';
import 'package:appconsumirapi/model/endereco_model.dart';

import 'package:http/http.dart' as http;

class cepController {
  Future<Endereco> consutlaCepController(String txtcep) async {
    try {
      String url = "https://viacep.com.br/ws/${txtcep}/json/";

      final response = await http.get(Uri.parse(url));

      Map<String, dynamic> retorno = json.decode(response.body);
      Endereco endereco = Endereco(
          retorno["cep"],
          retorno["logradouro"],
          retorno["complemento"],
          retorno["bairro"],
          retorno["localidade"],
          retorno["uf"],
          retorno["ibge"]);
      return endereco;
    } catch (ex) {
      throw Exception(ex);
    }
  }
}
