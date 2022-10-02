import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(28, 29, 38, 1),
      appBar: AppBar(
        elevation: 100,
        title: const Text("EVA"),
        actions: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'login');
                  },
                  child: const Text("Iniciar Sesion")))
        ],
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "EVA",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  Text(
                    "¡ Gestiona tus trabajadores aquí !Consulta, modifica y registra la información de las hojas de vida de tus trabajadores.",
                    style: TextStyle(fontSize: 13, color: Colors.white),
                  )
                ],
              ),
            ),
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(30),
              child: Image.asset("logo.jpg"),
            )),
          ],
        ),
      ),
    );
  }
}
