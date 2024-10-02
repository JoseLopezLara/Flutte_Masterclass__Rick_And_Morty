import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/home/home_screen.dart';
import 'package:masterclass_rick_and_morty_app/presentation/screens/login/controllers/login_controller.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/enum/ui_state.dart';
import 'package:masterclass_rick_and_morty_app/presentation/shared/utils/logger.dart';

// - PASO 5: Donde vas a usar tu provedor, debes de convertir el widget a "ConsumerWidget"
// No olvida añadir el WidgetRef en el contructor
class LoginCard extends ConsumerWidget {
  // - Paso 5.1 Recir provedor e instanciarlo en el contrutor
  final ChangeNotifierProvider<LoginController> loginProvider;

  const LoginCard({super.key, required this.loginProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ----- Sección de variablesd de mi widget -----
    // ----------------------------------------------

    // - PASO 6: Crear variable que permite gestionar mi gestor de estado
    final loginUIStateSelectedState =
        ref.watch(loginProvider.select((login) => login.uiState));
    bool isLoading = loginUIStateSelectedState == UiState.loading;
    logger.i("IS LOADING: $isLoading");

    final TextEditingController usernameController =
        TextEditingController(text: "michaelw");
    final TextEditingController passwordController =
        TextEditingController(text: 'michaelwpass');

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Escribe tu username',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8.0))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    hintText: 'Escribe tu contraseña',
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8.0))),
              ),
            ],
          ),
          Center(
            child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        ref
                            .read(loginProvider)
                            .login(usernameController.text,
                                passwordController.text)
                            .then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                        }).catchError((err, StackTrace) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text(
                                  'Ah ocurrido un problema, intente mas tarde')));
                        });
                      },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.purple.shade800,
                      )
                    : const Text('Iniciar Sessión')),
          )
        ],
      ),
    );
  }
}
