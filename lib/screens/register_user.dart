import 'package:eva/models/user.dart';
import 'package:eva/providers/cookie_manager.dart';
import 'package:eva/providers/login_provider.dart';
import 'package:eva/screens/screens.dart';
import 'package:eva/themes.dart';
import 'package:eva/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterUserScreen extends StatefulWidget {
  const RegisterUserScreen({Key? key}) : super(key: key);

  @override
  State<RegisterUserScreen> createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  bool sliderEnable = false;
  String name = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context, listen: true);
    final cookie = CookieManager.getCookie("isAdmin");
    final GlobalKey<FormState> myFormKey = GlobalKey<FormState>();
    final Map<String, dynamic> formValues = {
      'name': name,
      'email': email,
      'password': password,
      'admin': sliderEnable
    };

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
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 100),
                  child: Text(
                    "Registrar Usuario",
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
                          formProperty: "name",
                          formValues: formValues,
                          labelText: "Nombre",
                          initialValue: name,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomInputField(
                          formProperty: "email",
                          formValues: formValues,
                          labelText: "Email",
                          initialValue: email,
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
                          formProperty: "password",
                          formValues: formValues,
                          labelText: "Contraseña",
                          obscureText: true,
                          initialValue: password,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SwitchListTile.adaptive(
                          title: const Text(
                            "Administrador",
                            style: TextStyle(color: Colors.white),
                          ),
                          activeColor: Colors.redAccent,
                          value: sliderEnable,
                          onChanged: (value) {
                            setState(() {
                              sliderEnable = value;
                              name = formValues["name"];
                              email = formValues["email"];
                              password = formValues["password"];
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50)),
                      onPressed: () async {
                        if (!myFormKey.currentState!.validate()) {
                          print("Formulario invalido");
                          return;
                        }
                        FocusManager.instance.primaryFocus?.unfocus();
                        showAlert("", "", context, true);
                        loginProvider
                            .addUser(User(
                          name: formValues["name"].toString(),
                          email: formValues["email"].toString(),
                          password: formValues["password"].toString(),
                          admin: sliderEnable,
                        ))
                            .then((value) {
                          if (value) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              'main',
                              (route) => false,
                            );
                          } else {
                            showAlert(
                                "Error", "Algo salió mal", context, false);
                          }
                        });
                      },
                      child: const Text("Agregar Usuario")),
                ),
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
