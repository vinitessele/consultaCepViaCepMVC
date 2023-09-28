import 'package:appconsumirapi/controller/consulta_controller.dart' show cepController;
import 'package:appconsumirapi/model/endereco_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

TextEditingController _txtCep = TextEditingController();

class _HomeState extends State<Home> {
  cepController _cepController = cepController();
  late Future<Endereco> _future = _cepController.consutlaCepController('85905583');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consultado CEP via API"),
        backgroundColor: Colors.amber,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: _txtCep,
            ),
            Container(
              child: FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Text(
                        snapshot.data!.localidade+'-'+snapshot.data!.logradouro+'-'+snapshot.data!.uf,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              onPressed: () {
                setState(
                  () {
                    try {
                      _future =
                          _cepController.consutlaCepController(_txtCep.text);
                    } catch (exception) {
                      print('erro$exception');
                    }
                  },
                );
              },
              child: Text(
                "Consultar",
                style: TextStyle(fontSize: 15, color: Colors.cyan),
              ),
            )
          ],
        ),
      ),
    );
  }
}
