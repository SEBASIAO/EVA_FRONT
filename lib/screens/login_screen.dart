import 'package:eva/models/models.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:eva/themes.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, String> formValues = {
      "email": "",
      "password": "",
    };
    return Scaffold(
      backgroundColor: AppTheme.blackColor,
      body: Center(
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 100,
          color: AppTheme.blackColor,
          shadowColor: Colors.white,
          child: Form(
            key: myFormKey,
            onChanged: () {},
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 20, right: 20, left: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Iniciar Sesion",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      backgroundColor: AppTheme.blackColor,
                    ),
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    formProperty: "email",
                    formValues: formValues,
                    hintText: "Correo Electronico",
                  ),
                  const SizedBox(height: 15),
                  CustomInputField(
                    formProperty: "password",
                    formValues: formValues,
                    hintText: "Contraseña",
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!myFormKey.currentState!.validate()) {
                          print("Formulario invalido");
                          return;
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        showAlert("", "", context, true);
                        loginProvider
                            .login(LoginBody(
                                email: formValues["email"].toString(),
                                password: formValues["password"].toString()))
                            .then((value) {
                          if (value.status == 1) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'main',
                              (route) => false,
                            );
                          } else if (value.status == 3) {
                            showAlert("Error", "Usuario no encontrado", context,
                                false);
                          } else if (value.status == 2) {
                            showAlert("Error", "Contraseña incorrecta", context,
                                false);
                          }
                        });
                      },
                      child: const Text("Iniciar Sesion"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(fixedSize: Size.infinite),
                      child: const Text("Volver"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
}
