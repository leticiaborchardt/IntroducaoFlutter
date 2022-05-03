import 'package:introducao_flutter/model.dart';

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  Pessoa({this.nome, this.cpf, this.nascimento, this.sexo});

  @override
  String toString() {
    return 'nome: $nome, CPF: $cpf, nasc: $nascimento, sexo: $sexo';
  }
}

class NotaFiscal {
  int? numero;
  DateTime? emissao;
  Pessoa? cliente;
  String? enderecoEntrega;
  List<ItemNF> itens = [];

  NotaFiscal({this.numero, this.emissao, this.cliente, this.enderecoEntrega});

  double calcularValorTotal() {
    double total = 0.0;
    for (int i = 0; i < itens.length; i++) {
     total += itens[i].calcularValorTotal();
    }
    return total;
  }

  double calcularTotalDescontos() {
    double totalDescontos = 0.0;
    for (ItemNF item in itens) {
      totalDescontos += item.desconto;
    }
    return totalDescontos;
  }

  double calcularTotalAcrescimos() {
    double totalAcrescimos = 0.0;
    for (ItemNF item in itens) {
      totalAcrescimos += item.acrescimo;
    }
    return totalAcrescimos;
  }

  ItemNF? getProdutoMaisBarato() {
    ItemNF? itemMaisBarato;
    for (ItemNF item in itens) {
      if (itemMaisBarato == null) {
        itemMaisBarato = item;
      } else
      if (item.calcularValorTotal() < itemMaisBarato.calcularValorTotal()) {
        itemMaisBarato = item;
      }
    }
    return itemMaisBarato;
  }

  ItemNF? getProdutoMaisCaro() {
    ItemNF? itemMaisCaro;
    for (ItemNF item in itens) {
      if (itemMaisCaro == null) {
        itemMaisCaro = item;
      } else
      if (item.calcularValorTotal() > itemMaisCaro.calcularValorTotal()) {
        itemMaisCaro = item;
      }
    }
    return itemMaisCaro;
  }

  ItemNF? addItem({
    required String produto,
    required double valor,
    double desconto = 0.0,
    double acrescimo = 0.0}) {
  ItemNF item = ItemNF(
      numSeq: itens.length + 1,
      produto: produto,
      valor: valor,
      desconto: desconto,
      acrescimo: acrescimo);
    itens.add(item);
    return item;
  }
}

class ItemNF {
  int numSeq;
  String produto;
  double valor;
  double desconto;
  double acrescimo;

  ItemNF({
    required this.numSeq,
    required this.produto,
    required this.valor,
    this.desconto = 0.0,
    this.acrescimo = 0.0});

  double calcularValorTotal() {
    return valor + acrescimo - desconto;
  }

  @override
  String toString() {
    return '{numero: $numSeq, produto: $produto, valor: $valor, descontos: $desconto, acréscimos: $acrescimo, valor total: ${calcularValorTotal()}}';
  }
}


void mainNotaFiscal (){

  final pessoa = Pessoa(
      nome: 'Letícia',
      cpf: '090.878.878-36',
      nascimento: DateTime(2005,3,22),
  );

  final nota = NotaFiscal(
    cliente: pessoa,
    emissao: DateTime(2022,3,5),
    enderecoEntrega: 'Rua Figueira 185',
    numero: 561
  );

  nota.addItem(produto: 'computador', valor: 1500.50, desconto: 100);
  nota.addItem(produto: 'celular', valor: 2000, desconto: 100, acrescimo: 200);


  print('Nota Fiscal: ${nota.numero}, ${nota.cliente}, ${nota.emissao}, ${nota.enderecoEntrega},'
      '\n Valor Total: ${nota.calcularValorTotal()}, '
      '\n Itens: ${nota.itens}, '
      '\n Item mais Caro: ${nota.getProdutoMaisCaro()}, '
      '\n Item mais Barato: ${nota.getProdutoMaisBarato()}');
}