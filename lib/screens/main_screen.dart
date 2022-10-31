import 'package:eva/models/cv.dart';
import 'package:eva/providers/cookie_manager.dart';
import 'package:eva/providers/cv_provider.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CvProvider>(context, listen: true);
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final cookie = CookieManager.getCookie("isAdmin");
    return Scaffold(
      backgroundColor: AppTheme.blackColor,
      appBar: AppBar(
        elevation: 100,
        title: const Text("EVA"),
        actions: [
          if (loginProvider.user?.admin ?? false || cookie == "true") ...[
            TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, 'register', ((route) => false));
                },
                child: const Text("Registrar Usuario",
                    style: TextStyle(color: Colors.white)))
          ],
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'main', ((route) => false));
              },
              child: const Text("Hojas de vida",
                  style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, 'companies', ((route) => false));
              },
              child: const Text(
                "Empresas",
                style: TextStyle(color: Colors.white),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', ((route) => false));
                  },
                  child: const Text("Salir")))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Hojas de vida registradas",
                style: TextStyle(color: Colors.white, fontSize: 22),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'details',
                            arguments: const CvDetailArgument(
                                cv: null, editable: true, flow: 3));
                      },
                      child: const Text("Agregar")),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  itemBuilder: (context, index) {
                    return CvItem(
                      cv: cvProvider.cvList[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Divider(
                        color: Colors.white,
                      ),
                    );
                  },
                  itemCount: cvProvider.cvList.length),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class CvItem extends StatelessWidget {
  const CvItem({
    Key? key,
    required this.cv,
  }) : super(key: key);

  final Cv cv;

  Text _getAvailableText(bool available) {
    var color = Colors.greenAccent;
    var text = "Disponible";
    if (available == false) {
      color = Colors.redAccent;
      text = "No disponible";
    }
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 22,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            cv.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Expanded(
          child: Text(
            cv.profession,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Expanded(
          child: _getAvailableText(cv.available ?? true),
        ),
        Expanded(
            child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'details',
                    arguments:
                        CvDetailArgument(cv: cv, editable: false, flow: 1));
              },
              child: const Text("Consultar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'details',
                    arguments:
                        CvDetailArgument(cv: cv, editable: true, flow: 2));
              },
              child: const Text("Modificar"),
            ),
          ],
        )),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class CvDetailArgument {
  const CvDetailArgument({
    required this.cv,
    required this.editable,
    required this.flow,
  });

  final Cv? cv;
  final bool editable;
  final int flow;
}
