import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: const MyHomePage(title: 'Jogo da Velha'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //VARIAVEIS DA LÓGICA
  var squares;
  late bool isXnext;
  //AQUI VAMOS INICIALIZAR ESSAS VARIAVEIS
  initialize() {
    setState(() {
      squares = List.filled(9, '');
      isXnext = true;
    });
  }

  @override
  void initState() {
    super.initState();
    initialize();
  }

//AQUI FICA TODA INTERFACE DO CÓDIGO
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white),
              ),
              child: Text(
                "Vez do ${isXnext ? 'Jogador 1' : 'Jogador 2'}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeSqaure(0),
                makeSqaure(1),
                makeSqaure(2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeSqaure(3),
                makeSqaure(4),
                makeSqaure(5),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeSqaure(6),
                makeSqaure(7),
                makeSqaure(8),
              ],
            ),
          ],
        ),
      ),
    );
  }
//Função para exibir as mensagens de aviso quando o jogador ganhar ou quando não tiver nenhum resultado.
  showAlert(String msg) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("Avisozinho pra você :)"),
              content: Text(
                msg,
                style: TextStyle(fontSize: 22),
              ),
              actions: [
                FloatingActionButton(
                  onPressed: () {
                    initialize();
                    Navigator.pop(ctx);
                  },
                  child: Text("Fechar"))
              ],
            ));
  }

  markSqaure(int number) {
    setState(() {
      squares[number] = isXnext ? 'X' : 'O';
      isXnext = !isXnext;
    });
    if (checkWinner()) {
      showAlert("O ${isXnext ? 'Jogador 2' : 'Jogador 1'} venceu! 8)");
    } else {
      if (!squares.contains('')) {
        showAlert("Xiiii...Deu velha! Jogue denovo.");
      }
    }
  }

  bool checkWinner() {
    var lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    for (var i in lines) {
      int a = i[0];
      int b = i[1];
      int c = i[2];
      if (squares[a] != '' &&
          squares[a] == squares[b] &&
          squares[b] == squares[c]) {
        return true;
      }
    }
    return false;
  }

//Função para fazer os quadrados do jogo da velha
  makeSqaure(int number) {
    return SizedBox(
      height: 75,
      width: 75,
      child: InkWell(
        onTap: () {
          //FUNÇÃO PARA NÃO DEIXAR O JOGADOR SOBRESCREVER O OUTRO
          if (squares[number] == '') {
            markSqaure(number);
          }
        },
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(color: Color.fromARGB(255, 32, 2, 167)),
          ], border: Border.all(width: 10, color: Colors.white)),
          child: Center(
            child: Text(
              "${squares[number]}",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
