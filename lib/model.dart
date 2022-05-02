enum Sexo { MASCULINO, FEMININO }

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  int? getIdade() {
    if (nascimento == null) {
      return null;
    }
    final hoje = DateTime.now();
    final idade = hoje.difference(nascimento!);
    return idade.inDays ~/ 365;
  }

  @override
  String toString() {
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento, idade: ${getIdade()}, sexo: $sexo";
  }
}

class Programador extends Pessoa {
  double? salario;

  @override
  String toString() {
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento, idade: ${getIdade()}, sexo: $sexo,"
        " salario: $salario";
  }
}

void mainEntidades() {
  Programador pessoa = Programador();
  pessoa.nome = "Letícia";
  pessoa.cpf = "090.878.389-21";
  pessoa.nascimento = DateTime(2005, 3, 22);
  pessoa.sexo = Sexo.FEMININO;
  //pessoa.salario = 1500.00;

  print(pessoa);
}


