import 'package:flutter/material.dart';
import 'package:tecnofit_app/api/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;
  final User principalUser;

  const UserDetailScreen({
    Key? key,
    required this.user,
    required this.principalUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isPrincipalUser = user == principalUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isPrincipalUser ? 'SEU PERFIL' : '${user.firstName.toUpperCase()} ${user.lastName.toUpperCase()}',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xffF8EA63),
                  Color(0xff1a1a1a),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Card com avatar, nome e email
                      Container(
                        width: isMobile ? screenWidth * 0.8 : 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            // Avatar
                            Container(
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                              ),
                              child: Image.network(
                                user.avatar,
                                fit: BoxFit.cover,
                                height: 300,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Nome e email
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${user.firstName} ${user.lastName}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    user.email,
                                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isPrincipalUser) ...[
                        const SizedBox(height: 20),
                        // Botão de logout se for o perfil do usuário principal
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF8EA63),
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              '/login',
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text(
                            'Logout',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    'Criado por: Giordano Horacio',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
