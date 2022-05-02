enum Sexo { MASCULINO, FEMININO }

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  int? idade;
  Sexo? sexo;
  double? salario;
  bool? programador;

  @override
  String toString() {
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento, idade: $idade, sexo: $sexo, "
        "salario: $salario, é programador? $programador";
  }
}

void mainEntidades() {
  Pessoa pessoa = Pessoa();

  pessoa.nome = "Letícia";
  pessoa.cpf = "090.878.389-21";
  pessoa.nascimento = DateTime(2005, 3, 22);
  pessoa.idade = 17;
  pessoa.sexo = Sexo.FEMININO;
  pessoa.salario = 10500.00;
  pessoa.programador = true;

  print(pessoa);
}
