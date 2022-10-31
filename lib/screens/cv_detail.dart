import 'package:eva/models/cv.dart';
import 'package:eva/providers/cookie_manager.dart';
import 'package:eva/providers/cv_provider.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/screens/screens.dart';
import 'package:eva/themes.dart';
import 'package:eva/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CvDetailScreen extends StatelessWidget {
  const CvDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CvDetailArgument arguments =
        ModalRoute.of(context)?.settings.arguments as CvDetailArgument;
    final cvProvider = Provider.of<CvProvider>(context, listen: true);
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final cookie = CookieManager.getCookie("isAdmin");
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      "name": arguments.cv?.name ?? "",
      "email": arguments.cv?.email ?? "",
      "doc_type": arguments.cv?.docType ?? "",
      "doc_number": arguments.cv?.docNumber ?? 0,
      "phone": arguments.cv?.phone ?? 0,
      "born_date": arguments.cv?.bornDate ?? "",
      "profession": arguments.cv?.profession ?? "",
      "education_level": arguments.cv?.educationLevel ?? "",
      "state": arguments.cv?.state ?? "",
      "city": arguments.cv?.city ?? "",
      "address": arguments.cv?.address ?? "",
      "health_care": arguments.cv?.healthCare ?? "",
      "pension_fund": arguments.cv?.pensionFund ?? "",
      "marital_status": arguments.cv?.maritalStatus ?? "",
      "additional_info": arguments.cv?.additionalInfo ?? "",
      "assigned_company": arguments.cv?.assignedCompany?.id ?? "",
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
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: myFormKey,
            onChanged: () {},
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
                              cvProvider
                                  .deleteCv(arguments.cv?.id ?? "")
                                  .then((value) {
                                if (value) {
                                  cvProvider.getCvs();
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    'main',
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
                          initialValue: arguments.cv?.name,
                          enabled: arguments.editable,
                          labelText: "Nombre",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "email",
                          formValues: formValues,
                          initialValue: arguments.cv?.email,
                          enabled: arguments.editable,
                          labelText: "Email",
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
                          formProperty: "doc_type",
                          formValues: formValues,
                          initialValue: arguments.cv?.docType,
                          enabled: arguments.editable,
                          labelText: "Tipo de documento",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "doc_number",
                          formValues: formValues,
                          initialValue: arguments.cv?.docNumber.toString(),
                          enabled: arguments.editable,
                          labelText: "Numero de documento",
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
                          formProperty: "phone",
                          formValues: formValues,
                          initialValue: arguments.cv?.phone.toString(),
                          enabled: arguments.editable,
                          labelText: "Telefono",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "born_date",
                          formValues: formValues,
                          initialValue: arguments.cv?.bornDate.toString(),
                          enabled: arguments.editable,
                          labelText: "Fecha de nacimiento",
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
                          formProperty: "profession",
                          formValues: formValues,
                          initialValue: arguments.cv?.profession,
                          enabled: arguments.editable,
                          labelText: "Profesión",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "education_level",
                          formValues: formValues,
                          initialValue: arguments.cv?.educationLevel,
                          enabled: arguments.editable,
                          labelText: "Nivel de educación",
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
                          formProperty: "state",
                          formValues: formValues,
                          initialValue: arguments.cv?.state,
                          enabled: arguments.editable,
                          labelText: "Departamento",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "city",
                          formValues: formValues,
                          initialValue: arguments.cv?.city,
                          enabled: arguments.editable,
                          labelText: "Municipio",
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
                          initialValue: arguments.cv?.address,
                          enabled: arguments.editable,
                          labelText: "Dirección",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "health_care",
                          formValues: formValues,
                          initialValue: arguments.cv?.healthCare,
                          enabled: arguments.editable,
                          labelText: "EPS",
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
                          formProperty: "pension_fund",
                          formValues: formValues,
                          initialValue: arguments.cv?.pensionFund,
                          enabled: arguments.editable,
                          labelText: "Fondo de pensiones",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "marital_status",
                          formValues: formValues,
                          initialValue: arguments.cv?.maritalStatus,
                          enabled: arguments.editable,
                          labelText: "Estado civil",
                        ),
                      ),
                    ],
                  ),
                ),
                if (arguments.cv?.assignedCompany != null ||
                    arguments.flow == 3 ||
                    arguments.flow == 2) ...[
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            validate: false,
                            formProperty: "",
                            formValues: {},
                            initialValue: arguments.cv?.assignedCompany?.name,
                            enabled: false,
                            labelText: "Empresa",
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomInputField(
                            validate: false,
                            formProperty: "assigned_company",
                            formValues: formValues,
                            initialValue: arguments.cv?.assignedCompany?.nit,
                            enabled: arguments.editable,
                            labelText: "Nit empresa",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (arguments.cv?.additionalInfo != "" ||
                    arguments.flow == 3 ||
                    arguments.flow == 2) ...[
                  const SizedBox(height: 20),
                  IntrinsicWidth(
                    child: CustomInputField(
                      validate: false,
                      formProperty: "additional_info",
                      formValues: formValues,
                      hintText: arguments.cv?.additionalInfo,
                      enabled: arguments.editable,
                      labelText: "Información adicional",
                    ),
                  ),
                ],
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
                                  cvProvider
                                      .addCv(Cv(
                                          id: arguments.cv?.id ?? "",
                                          name: formValues["name"],
                                          email: formValues["email"],
                                          docType: formValues["doc_type"],
                                          docNumber: int.parse(
                                              formValues["doc_number"]),
                                          phone: int.parse(formValues["phone"]),
                                          bornDate: formValues["born_date"],
                                          profession: formValues["profession"],
                                          educationLevel:
                                              formValues["education_level"],
                                          state: formValues["state"],
                                          city: formValues["city"],
                                          address: formValues["address"],
                                          healthCare: formValues["health_care"],
                                          pensionFund:
                                              formValues["pension_fund"],
                                          maritalStatus:
                                              formValues["marital_status"],
                                          additionalInfo:
                                              formValues["additional_info"],
                                          assignedCompanyId: (formValues[
                                                          "assigned_company"]
                                                      as String)
                                                  .isEmpty
                                              ? null
                                              : formValues["assigned_company"]))
                                      .then((value) {
                                    if (value) {
                                      cvProvider.getCvs();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'main',
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
                                  cvProvider
                                      .updateCv(Cv(
                                          id: arguments.cv?.id ?? "",
                                          name: formValues["name"],
                                          email: formValues["email"],
                                          docType: formValues["doc_type"],
                                          docNumber: formValues["doc_number"],
                                          phone: formValues["phone"],
                                          bornDate: formValues["born_date"],
                                          profession: formValues["profession"],
                                          educationLevel:
                                              formValues["education_level"],
                                          state: formValues["state"],
                                          city: formValues["city"],
                                          address: formValues["address"],
                                          healthCare: formValues["health_care"],
                                          pensionFund:
                                              formValues["pension_fund"],
                                          maritalStatus:
                                              formValues["marital_status"],
                                          additionalInfo:
                                              formValues["additional_info"],
                                          assignedCompanyId: (formValues[
                                                          "assigned_company"]
                                                      as String)
                                                  .isEmpty
                                              ? null
                                              : formValues["assigned_company"]))
                                      .then((value) {
                                    if (value) {
                                      cvProvider.getCvs();
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        'main',
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
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
