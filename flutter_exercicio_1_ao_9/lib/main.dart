import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KABUUM',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Color> _textColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange
  ];

  Color _currentTextColor = Colors.white;

  void _changeTextColor() {
    setState(() {
      final random = Random();
      _currentTextColor = _textColors[random.nextInt(_textColors.length)];
    });
  }

  void _onSearchPressed(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "KABUM",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://files.tecnoblog.net/wp-content/uploads/2021/12/kabum-ninja-app-celular.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "KaBum",
                      style: TextStyle(
                        fontSize: 64,
                        color: _currentTextColor,
                      ),
                    ),
                    Text(
                      "Melhor site para você gamer",
                      style: TextStyle(
                        fontSize: 32,
                        color: _currentTextColor,
                      ),
                    ),
                    Text(
                      "Preços baixos explodem por aqui",
                      style: TextStyle(
                        fontSize: 32,
                        color: _currentTextColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search, color: Colors.white),
              onPressed: () {
                _onSearchPressed(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.settings, color: Colors.white),
              onPressed: () {
                _changeTextColor();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final String imageUrl =
      "https://confiavel.net.br/wp-content/uploads/2019/12/kabum-e-confiavel.jpg";

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isLoading = true; // controle de carregamento

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward().whenComplete(() {
      // quando a animação terminar, esconder o ícone de carregamento
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Faça as melhores compras pra você gamer",
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange,
        centerTitle: true,
        leading: IconButton(
          // botão para voltar à HomePage
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            _controller.reverse().then((value) => Navigator.pop(context));
          },
        ),
      ),
      body: Stack(
        // usar um Stack para colocar o CircularProgressIndicator em cima da imagem
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: FadeTransition(
              opacity: _animation,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Visibility(
            // controla a visibilidade do CircularProgressIndicator
            visible: _isLoading,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}
