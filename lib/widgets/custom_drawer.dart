import 'package:flutter/material.dart';
import 'package:loja_virtual_thiago/models/user_model.dart';
import 'package:loja_virtual_thiago/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import '../titles/drawer_titles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildDrawerBack() => Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 233, 99, 99),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 214, 212, 212),
                Color.fromARGB(255, 214, 212, 212),
                Color.fromARGB(255, 163, 161, 161),
                Color.fromARGB(255, 111, 109, 109),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: const EdgeInsets.only(left: 32, top: 16),
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: [
                    const Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        'Thiago\'s  Flutter \n          Store',
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Text(
                                  'Olá,${!model.isLoadingIn() ? "" : model.userData['name']}' ,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoadingIn() ?
                                    'Entre ou Cadastre-se > '
                                    : 'Sair',
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  onTap: () {
                                    if(!model.isLoadingIn()) {
                                      Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));
                                    } else{
                                      model.signOut();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        )),
                  ],
                ),
              ),
              const Divider(),
              DrawerTitle(
                icon: Icons.home,
                text: 'Inicio',
                controller: pageController,
                page: 0,
              ),
              DrawerTitle(
                icon: Icons.list,
                text: 'Produtos',
                controller: pageController,
                page: 1,
              ),
              DrawerTitle(
                icon: Icons.location_on,
                text: 'Lojas',
                controller: pageController,
                page: 2,
              ),
              DrawerTitle(
                icon: Icons.playlist_add_check,
                text: 'Meus Pedidos',
                controller: pageController,
                page: 3,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
