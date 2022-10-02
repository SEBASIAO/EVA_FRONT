import 'package:eva/models/cv.dart';
import 'package:eva/providers/cv_provider.dart';
import 'package:eva/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cvProvider = Provider.of<CvProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppTheme.blackColor,
      appBar: AppBar(
        elevation: 100,
        title: const Text("EVA"),
        actions: [
          TextButton(
              onPressed: () {},
              child: const Text("Hojas de vida",
                  style: TextStyle(color: Colors.white))),
          TextButton(
              onPressed: () {},
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
        child: Scrollbar(
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
                        onPressed: () {}, child: const Text("Agregar")),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Filtrar")),
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
            ],
          ),
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
            child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'details',
                    arguments: CvDetailArgument(cv: cv, editable: false));
              },
              child: const Text("Consultar"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Modificar"),
            ),
          ],
        )),
      ],
    );
  }
}

class CvDetailArgument {
  const CvDetailArgument({
    required this.cv,
    required this.editable,
  });

  final Cv cv;
  final bool editable;
}
