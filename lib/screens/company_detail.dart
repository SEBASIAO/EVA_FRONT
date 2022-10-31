import 'package:eva/models/company.dart';
import 'package:eva/providers/company_provider.dart';
import 'package:eva/providers/cookie_manager.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/screens/screens.dart';
import 'package:eva/themes.dart';
import 'package:eva/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompanyDetail extends StatelessWidget {
  const CompanyDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companiesProvider =
        Provider.of<CompanyProvider>(context, listen: true);
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final cookie = CookieManager.getCookie("isAdmin");
    final CompanyDetailArgument arguments =
        ModalRoute.of(context)?.settings.arguments as CompanyDetailArgument;
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      'name': arguments.company?.name ?? "",
      'nit': arguments.company?.nit ?? "",
      'address': arguments.company?.address ?? "",
      'phone': arguments.company?.phone ?? "",
      'manager': arguments.company?.manager ?? "",
      'manager_doc_number': arguments.company?.managerDocNumber ?? "",
      'manager_phone_number': arguments.company?.managerPhoneNumber ?? "",
    };
    String flowTitle = "";
    if (arguments.flow == 1) {
      flowTitle = "Consultar";
    } else if (arguments.flow == 2) {
      flowTitle = "Modificar";
    } else {
      flowTitle = "Agregar";
    }
    ;
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
        child: Form(
          key: myFormKey,
          onChanged: () {},
          child: Scrollbar(
            child: Column(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        flowTitle,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                        textAlign: TextAlign.start,
                      ),
                      if (loginProvider.user?.admin ??
                          false || cookie == "true")
                        ElevatedButton(
                            onPressed: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              showAlert("", "", context, true);
                              companiesProvider
                                  .deleteCompany(arguments.company?.id ?? "")
                                  .then((value) {
                                if (value) {
                                  companiesProvider.getCompanies();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    'companies',
                                    (route) => false,
                                  );
                                } else {
                                  showAlert("Error", "Algo salió mal", context,
                                      false);
                                }
                              });
                            },
                            child: const Text("Eliminar")),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          formProperty: "name",
                          formValues: formValues,
                          initialValue: arguments.company?.name,
                          enabled: arguments.editable,
                          labelText: "Nombre",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "nit",
                          formValues: formValues,
                          initialValue: arguments.company?.nit,
                          enabled: arguments.editable,
                          labelText: "Nit",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          formProperty: "address",
                          formValues: formValues,
                          initialValue: arguments.company?.address,
                          enabled: arguments.editable,
                          labelText: "Dirección",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "phone",
                          formValues: formValues,
                          initialValue: arguments.company?.phone.toString(),
                          enabled: arguments.editable,
                          labelText: "Telefono",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          formProperty: "manager",
                          formValues: formValues,
                          initialValue: arguments.company?.manager.toString(),
                          enabled: arguments.editable,
                          labelText: "Encargado",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "manager_docnumber",
                          formValues: formValues,
                          initialValue:
                              arguments.company?.managerDocNumber.toString(),
                          enabled: arguments.editable,
                          labelText: "Documento del encargado",
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomInputField(
                          formProperty: "manager_phone",
                          formValues: formValues,
                          initialValue: arguments.company?.managerPhoneNumber,
                          enabled: arguments.editable,
                          labelText: "Telefono del encargado",
                        ),
                      ),
                    ],
                  ),
                ),
                if (arguments.flow == 2 || arguments.flow == 3) ...[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Volver")),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(50)),
                              onPressed: () async {
                                if (!myFormKey.currentState!.validate()) {
                                  print("Formulario invalido");
                                  return;
                                }
                                if (arguments.flow == 3) {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  showAlert("", "", context, true);
                                  companiesProvider
                                      .addCompany(Company(
                                    name: formValues["name"].toString(),
                                    nit: formValues["nit"].toString(),
                                    address: formValues["address"].toString(),
                                    phone: formValues["phone"].toString(),
                                    managerDocNumber:
                                        formValues["manager_docnumber"]
                                            .toString(),
                                    managerPhoneNumber:
                                        formValues["manager_phone"].toString(),
                                    manager: formValues["manager"].toString(),
                                  ))
                                      .then((value) {
                                    if (value) {
                                      companiesProvider.getCompanies();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'companies',
                                        (route) => false,
                                      );
                                    } else {
                                      showAlert("Error", "Algo salió mal",
                                          context, false);
                                    }
                                  });
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  showAlert("", "", context, true);
                                  companiesProvider
                                      .updateCompany(Company(
                                    id: arguments.company?.id,
                                    name: formValues["name"].toString(),
                                    nit: formValues["nit"].toString(),
                                    address: formValues["address"].toString(),
                                    phone: formValues["phone"].toString(),
                                    managerDocNumber:
                                        formValues["manager_docnumber"]
                                            .toString(),
                                    managerPhoneNumber:
                                        formValues["manager_phone"].toString(),
                                    manager: formValues["manager"].toString(),
                                  ))
                                      .then((value) {
                                    if (value) {
                                      companiesProvider.getCompanies();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'companies',
                                        (route) => false,
                                      );
                                    } else {
                                      showAlert("Error", "Algo salió mal",
                                          context, false);
                                    }
                                  });
                                }
                              },
                              child: Text(flowTitle)),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Volver")),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlert(String title, String body, BuildContext context, bool isLoading) {
  if (isLoading) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
            elevation: 5,
            backgroundColor: AppTheme.blackColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(15)),
            content: const CircularProgressIndicator());
      },
    );
  } else {
    Navigator.of(context, rootNavigator: true).pop();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          backgroundColor: AppTheme.blackColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(15)),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(body, style: const TextStyle(color: Colors.white)),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"))
          ],
        );
      },
    );
  }
}
