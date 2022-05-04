import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool _incrementando = true;
  int _contador = 0;
  List<int> _historico = [];
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HOME',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementarOuDecrementar,
        tooltip: _incrementando ? 'Incrementar' : 'Decrementar',
        child: Icon(_incrementando ? Icons.add : Icons.remove),
      ),
    );
  }

  Center _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Contador:', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20.0,),
          Text(
            '$_contador',
            style: const TextStyle(color: Colors.pink, fontSize: 50.0),
          ),
          const SizedBox(height: 40.0,),
          const Text(
            'Histórico:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(_historico.isEmpty ? '(Vazio)' : _historico.join(', '),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade600)
            ),
          ),
          const SizedBox(height: 20.0,),
          const Text(
            'Total do Histórico:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '$_total', style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage("https://images4.alphacoders.com/100/1008904.png"),
                    fit: BoxFit.cover)
            ),
            child: Text('Drawer', style: TextStyle(color: Colors.white, fontSize: 24),),
          ),
          ListTile(
            leading: const Icon(Icons.clear),
            title: const Text('Zerar Contador', style: TextStyle(fontSize: 16),),
            onTap: _zerar
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text('Inverter Contador', style: TextStyle(fontSize: 16),),
            onTap: _inverter,
          ),
          ListTile(
            leading: const Icon(Icons.memory),
            title: const Text('Memorizar Contador', style: TextStyle(fontSize: 16),),
            onTap: _memorizar,
          ),
        ],
      ),
    );
  }

  void _incrementarOuDecrementar() {
    setState(() {
      if (_incrementando) {
        _contador++;
      } else {
        _contador--;
      }
    });
  }

  void _zerar() {
    Navigator.of(context).pop();
    setState(() {
      _contador = 0;
      _historico.clear();
      _total = 0;
    });
  }

  void _inverter(){
    Navigator.of(context).pop();
    setState(() {
      _incrementando = !_incrementando;
    });
  }

  void _memorizar(){
    Navigator.of(context).pop();
    setState(() {
      _historico.add(_contador);
      _total = _historico.isNotEmpty ? _historico.reduce((a, b) => a + b) : 0;
    });
  }

}