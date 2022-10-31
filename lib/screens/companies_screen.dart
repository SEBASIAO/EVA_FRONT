import 'package:eva/models/company.dart';
import 'package:eva/providers/company_provider.dart';
import 'package:eva/providers/cookie_manager.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companiesProvider =
        Provider.of<CompanyProvider>(context, listen: true);
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
                "Empresas registradas",
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
                        Navigator.pushNamed(context, 'companyDetail',
                            arguments: const CompanyDetailArgument(
                                company: null, editable: true, flow: 3));
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
                    return CompanyItem(
                      company: companiesProvider.companies[index],
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
                  itemCount: companiesProvider.companies.length),
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

class CompanyItem extends StatelessWidget {
  const CompanyItem({
    Key? key,
    required this.company,
  }) : super(key: key);

  final Company company;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            company.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        Expanded(
          child: Text(
            'Nit ${company.nit}',
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
                Navigator.pushNamed(context, 'companyDetail',
                    arguments: CompanyDetailArgument(
                        company: company, editable: false, flow: 1));
              },
              child: const Text("Consultar"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'companyDetail',
                    arguments: CompanyDetailArgument(
                        company: company, editable: true, flow: 2));
              },
              child: const Text("Modificar"),
            ),
          ],
        )),
      ],
    );
  }
}

class CompanyDetailArgument {
  const CompanyDetailArgument({
    required this.company,
    required this.editable,
    required this.flow,
  });

  final Company? company;
  final bool editable;
  final int flow;
}
