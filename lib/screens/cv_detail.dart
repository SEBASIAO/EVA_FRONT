import 'package:eva/screens/main_screen.dart';
import 'package:eva/themes.dart';
import 'package:eva/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CvDetailScreen extends StatelessWidget {
  const CvDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CvDetailArgument arguments =
        ModalRoute.of(context)?.settings.arguments as CvDetailArgument;
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
                  "Consultar",
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
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.name,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.email,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.docType,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.docNumber.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.phone.toString(),
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.bornDate.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.profession,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.educationLevel,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.state,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.city,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.address,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.healthCare,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.pensionFund,
                      ),
                    ),
                    Expanded(
                      child: CustomInputField(
                        formProperty: "",
                        formValues: {},
                        hintText: arguments.cv.maritalStatus,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              IntrinsicWidth(
                child: CustomInputField(
                  formProperty: "",
                  formValues: {},
                  hintText: arguments.cv.additionalInfo,
                ),
              ),
              const SizedBox(
                height: 10,
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
          ),
        ),
      ),
    );
  }
}
