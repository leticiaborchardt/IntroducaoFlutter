enum Sexo { MASCULINO, FEMININO }

Sexo? strToSexo(String? str){
  if(str == null){
    return null;
  }
  switch (str.toUpperCase()) {
    case 'MASCULINO':
    case 'M':
      return Sexo.MASCULINO;
    case 'FEMININO':
    case 'F':
      return Sexo.FEMININO;
    default:
      return null;
  }
}

class Pessoa {
  String? nome;
  String? cpf;
  DateTime? nascimento;
  Sexo? sexo;

  // construtor
  Pessoa(this.nome, this.cpf, this.nascimento, this.sexo);

  Pessoa.fromMap(Map<String, String> map) {
    nome = map['nome'];
    cpf = map['cpf'];
    nascimento = DateTime.tryParse(map['nascimento'] ?? '2000-01-01');
    sexo = strToSexo(map['sexo']);
  }

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

  Programador(String? nome, String? cpf, DateTime? nascimento, Sexo? sexo, this.salario) :
        super(nome, cpf, nascimento, sexo);

  Programador.fromMap(Map<String, String> map) : super.fromMap(map) {
    salario = double.tryParse(map['salario'] ?? '0.0');
  }

  @override
  String toString() {
    return "nome: $nome, cpf: $cpf, nascimento: $nascimento, idade: ${getIdade()}, sexo: $sexo,"
        " salario: $salario";
  }
}

void mainEntidades() {
  final map = {
    'nome' : 'Letícia',
    'cpf' : '090.887.889-65',
    'nascimento' : '2005-03-22',
    'sexo' : 'F',
    'salario' : '10000.00'
  };

  Pessoa pessoa = Programador.fromMap(map);

  //Programador pessoa = Programador();
  //pessoa.nome = "Letícia";
  //pessoa.cpf = "090.878.389-21";
  //pessoa.nascimento = DateTime(2005, 3, 22);
  //pessoa.sexo = Sexo.FEMININO;
  //pessoa.salario = 1500.00;

  print(pessoa);
}
