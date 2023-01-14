import "package:flutter/material.dart";
import "package:flutter/services.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _a = 0;
  int _b = 0;
  int _sum = 0;

  Future<void> _calcSum() async {
    const channel = MethodChannel("marioguilherme.com.br/nativo");

    try {
      final int? sum = await channel.invokeMethod<int>("calcSum", { "a": this._a, "b": this._b });
      setState(() => this._sum = sum!);
    } on PlatformException {
      setState(() => this._sum = 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nativo")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Soma... ${this._sum}",
                style: const TextStyle(
                  fontSize: 30
                )
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => this._a = int.tryParse(value) ?? 0
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) => this._b = int.tryParse(value) ?? 0
              ),
              RaisedButton(
                onPressed: this._calcSum,
                child: const Text("Somar")
              )
            ]
          )
        )
      )
    );
  }
}
