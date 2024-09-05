# Tecnofit App - Login Screen

## Descrição do Projeto

Este projeto Flutter consiste em uma tela de login que se comunica com um backend REST, utilizando a API pública [Reqres](https://reqres.in). O aplicativo foi projetado para ser responsivo, funcionando de maneira eficiente em iOS, Android e Web. Após o login, o usuário é redirecionado para uma nova tela onde seus dados ficam acessíveis para todas as telas subsequentes.

---

## Requisitos Atendidos

- **Comunicação com Backend REST**: A tela de login realiza requisições HTTP para a API pública [Reqres](https://reqres.in). Ao enviar o e-mail e a senha, uma requisição de login é feita e, com sucesso, o token retornado pelo backend é armazenado para futuras requisições.
  
- **Design Responsivo**: O design foi implementado para ser totalmente responsivo, ajustando automaticamente os componentes da tela para diferentes tamanhos de dispositivos, seja em mobile ou web.
  
- **Compatibilidade Multiplataforma**: O projeto foi desenvolvido utilizando Flutter, garantindo compatibilidade com **iOS**, **Android** e **Web**.
  
- **Persistência de Dados do Usuário**: Após o login, o token do usuário e suas informações ficam acessíveis por meio do gerenciador de estado para qualquer tela subsequente.

- **Gerenciador de Estado**: Foi utilizado o **Bloc (Business Logic Component)** para o gerenciamento de estado. Os motivos da escolha do Bloc incluem:
  - **Separação clara de responsabilidades**.
  - **Escalabilidade**.
  - **Testabilidade**.
  - **Consistência** do estado em toda a navegação do app.

---

## Tecnologias Utilizadas

- **Flutter**: Framework para desenvolvimento multiplataforma.
- **Dart**: Linguagem utilizada pelo Flutter.
- **Bloc (flutter_bloc)**: Gerenciador de estado utilizado no projeto.
- **HTTP**: Para requisições REST.
- **Reqres**: API pública usada para autenticação.

---

## Funcionalidades

1. **Tela de Login**:
   - Inputs de e-mail e senha.
   - Validação de campos.
   - Autenticação com o backend via API REST.
   - Mensagens de erro dinâmicas.
   - Responsividade garantida.

2. **Navegação após Login**:
   - Após o login bem-sucedido, o usuário é redirecionado para uma lista de usuários.
   - Os dados do usuário logado ficam acessíveis em todas as telas subsequentes.

3. **Dicas para Login**:
   - Um **Floating Action Button** com um ícone de interrogação fornece ao usuário uma dica de e-mail e senha de exemplo para login. O usuário pode copiar esses dados diretamente com um clique.

---

## Como Rodar o Projeto

1. **Pré-requisitos**:
   - Flutter SDK instalado ([Instruções de Instalação](https://flutter.dev/docs/get-started/install)).
   - Configurar ambiente de desenvolvimento para iOS/Android (Android Studio, Xcode).
   - Acesso à internet para a API [Reqres](https://reqres.in).

2. **Passos**:
   1. Clone o repositório:
      ```bash
      git clone <url-do-repositorio>
      ```
   2. Instale as dependências:
      ```bash
      flutter pub get
      ```
   3. Rode o projeto:
      ```bash
      flutter run
      ```
   - Para rodar na web:
     ```bash
     flutter run -d chrome
     ```


