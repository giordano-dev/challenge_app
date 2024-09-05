import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tecnofit_app/api/models/user_model.dart';
import 'user_detail_screen.dart';

class UserListScreen extends StatefulWidget {
  final List<User> users;
  final User principalUser;
  final Function(User) onUserTap;

  const UserListScreen({
    Key? key,
    required this.users,
    required this.principalUser,
    required this.onUserTap,
  }) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Scaffold(
      backgroundColor: const Color(0xFFF8EA63),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'LISTA DE USUÁRIOS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.white),
            onPressed: () {
              // Navega para os detalhes do principalUser (usuário logado)
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetailScreen(
                    user: widget.principalUser,
                    principalUser: widget.principalUser,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: widget.users.isNotEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  'Role para o lado para visualizar mais usuários',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: widget.users.length,
                    itemBuilder: (context, index, realIndex) {
                      final user = widget.users[index];
                      final isCurrent = index == _current;
                      return _buildUserCard(user, isCurrent, screenWidth, context);
                    },
                    options: CarouselOptions(
                      height: isMobile ? 400 : 500,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction: isMobile ? 0.9 : 0.6,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          : const Center(child: Text('Nenhum usuário encontrado')),
    );
  }

  Widget _buildUserCard(User user, bool isCurrent, double screenWidth, BuildContext context) {
    final bool isMobile = screenWidth < 600;
    return Opacity(
      opacity: isCurrent ? 1.0 : 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: GestureDetector(
          onTap: () {
            // Ao clicar no card, navega para a página de detalhes do usuário
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserDetailScreen(
                  user: user, // Usuário selecionado
                  principalUser: widget.principalUser, // Usuário principal (logado)
                ),
              ),
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: isMobile ? screenWidth * 0.9 : screenWidth * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(user.avatar),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${user.firstName} ${user.lastName}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.email,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
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
}
