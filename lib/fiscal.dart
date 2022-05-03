import 'dart:collection';
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
    return itens.map((e) => e.calcularValorTotal()).reduce((a, b) => a + b);
  }

  double calcularTotalDescontos() {
    return itens.map((e) => e.desconto).reduce((a, b) => a + b);
  }

  bool possuiDesconto() {
    return itens.map((e) => e.desconto).any((d) => true);
  }

  List<ItemNF> itensComDesconto() {
    return itens.where((e) => e.desconto > 0).toList();
  }

  double calcularTotalAcrescimos() {
    return itens.map((e) => e.acrescimo).reduce((a, b) => a + b);
  }

  ItemNF? getProdutoMaisBarato() {
    return itens.reduce((a, b) => a.valor < b.valor ? a : b);
  }

  ItemNF? getProdutoMaisCaro() {
    return itens.reduce((a, b) => a.valor > b.valor ? a : b);
  }

  String getStrItens() {
    return itens.map((i) => "${i.numSeq}: ${i.produto} = R\$${i.valor}").join(", ");
  }

  ItemNF? addItem({required String produto,
    required double valor,
    double desconto = 0.0,
    double acrescimo = 0.0}) {
    if (valor == 0.00) {
      throw Exception('O valor não pode ser 0!');
    }
    if (produto == '') {
      throw Exception('O produto precisa ser informado!');
    }
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

  ItemNF({required this.numSeq,
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

void mainNotaFiscal() {
  try {
    final pessoa = Pessoa(
      nome: 'Letícia',
      cpf: '090.878.878-36',
      nascimento: DateTime(2005, 3, 22),
    );

    final nota = NotaFiscal(
        cliente: pessoa,
        emissao: DateTime(2022, 3, 5),
        enderecoEntrega: 'Rua Figueira 185',
        numero: 561
    );

  nota.addItem(produto: 'Computador', valor: 5400.0, desconto: 115);
  nota.addItem(produto: 'Celular', valor: 1990, acrescimo: 20);
  nota.addItem(produto: 'Teclado', valor: 175.50, desconto: 10, acrescimo: 15);
  nota.addItem(produto: 'Mouse', valor: 100, desconto: 20, acrescimo: 10);


  print(
    'Valor Total: ${nota.calcularValorTotal()}, '
    '\n Total Descontos: ${nota.calcularTotalDescontos()}'
    '\n Total Acréscimos: ${nota.calcularTotalAcrescimos()}'
    '\n Itens: ${nota.getStrItens()},'
    '\n Itens com Desconto: ${nota.itensComDesconto()}'
    '\n Item mais Caro: ${nota.getProdutoMaisCaro()}, '
    '\n Item mais Barato: ${nota.getProdutoMaisBarato()}');
  } on Exception catch (e) {
    print(e.toString());
  }

}
