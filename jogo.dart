import 'dart:io';
import 'dart:math';

void main() {
  print("Bem-vindo ao jogo de adivinhação!");
  print("Escolha o modo de jogo:");
  print("1 - Um Jogador: Você contra o computador.");
  print(
      "2 - Modo de Dois Jogadores: Dois jogadores se revezam como adivinhador e mestre dos números.");
  print(
      "3 - Máquina adivinha: Você pensa em um número e a máquina tenta adivinhá-lo.");
  stdout.write("Escolha uma opção: ");

  var modo = int.parse(stdin.readLineSync()!);

  if (modo == 1) {
    jogarUmJogador();
  } else if (modo == 2) {
    jogarDoisJogadores();
  } else if (modo == 3) {
    maquinaAdivinha();
  } else {
    print("Opção inválida. Tente novamente.");
  }
}

void jogarUmJogador() {
  print("Escolha a modalidade de jogo:");
  print("1 - Números Inteiros (0-50): 5 tentativas.");
  print("2 - Números Inteiros (0-100): 5 tentativas.");
  print("3 - Números Inteiros (0-500): 5 tentativas.");
  print("4 - Números Ímpares (0-50): 5 tentativas.");
  print("5 - Números Ímpares (0-100): 5 tentativas.");
  print("6 - Números Pares (0-50): 5 tentativas.");
  print("7 - Números Pares (0-100): 5 tentativas.");
  stdout.write("Escolha uma opção: ");

  var opcao = int.parse(stdin.readLineSync()!);

  int tentativas, numeroLimite;
  if (opcao == 1) {
    tentativas = 5;
    numeroLimite = 50;
  } else if (opcao == 2) {
    tentativas = 5;
    numeroLimite = 100;
  } else if (opcao == 3) {
    tentativas = 5;
    numeroLimite = 500;
  } else if (opcao == 4) {
    tentativas = 5;
    numeroLimite = 50;
    numeroLimite = numeroLimite % 2 == 0 ? numeroLimite - 1 : numeroLimite;
  } else if (opcao == 5) {
    tentativas = 5;
    numeroLimite = 100;
    numeroLimite = numeroLimite % 2 == 0 ? numeroLimite - 1 : numeroLimite;
  } else if (opcao == 6) {
    tentativas = 5;
    numeroLimite = 50;
    numeroLimite = numeroLimite % 2 == 0 ? numeroLimite : numeroLimite - 1;
  } else if (opcao == 7) {
    tentativas = 5;
    numeroLimite = 100;
    numeroLimite = numeroLimite % 2 == 0 ? numeroLimite : numeroLimite - 1;
  } else {
    print("Opção inválida. Tente novamente.");
    return;
  }

  var numeroSecreto = Random().nextInt(numeroLimite + 1);
  var pontuacao = 100;

  print("Você tem $pontuacao pontos.");

  while (tentativas > 0) {
    stdout.write("Dê um palpite: ");
    var chute = int.parse(stdin.readLineSync()!);

    if (chute < 0 || chute > numeroLimite) {
      print("Número fora do intervalo permitido. Tente novamente.");
      continue;
    }

    var acertou = numeroSecreto == chute;

    if (acertou) {
      print("Acertou!");
      print("Você ganhou com $pontuacao pontos!");
      return;
    } else {
      print("Errou!");
      if (chute > numeroSecreto) {
        print("O chute está maior do que o número secreto.");
      } else {
        print("O chute está menor do que o número secreto.");
      }
      tentativas -= 1;
      pontuacao -= 20;
      print("Você tem $pontuacao pontos.");
    }
  }

  print("Você perdeu! O número secreto era $numeroSecreto.");
}

void jogarDoisJogadores() {
  stdout.write("Jogador 1, escolha um número secreto: ");
  var numeroSecreto = int.parse(stdin.readLineSync()!);
  print("Jogador 2, tente adivinhar o número secreto!");

  int tentativasRestantes = 5;
  while (tentativasRestantes > 0) {
    stdout.write("Dê um palpite: ");
    var chute = int.parse(stdin.readLineSync()!);

    var acertou = numeroSecreto == chute;

    if (acertou) {
      print("Acertou!");
      break;
    } else {
      print("Errou!");
      if (chute > numeroSecreto) {
        print("O chute está maior do que o número secreto.");
      } else {
        print("O chute está menor do que o número secreto.");
      }
      tentativasRestantes -= 1;
    }
  }

  if (tentativasRestantes > 0) {
    print("Parabéns! Jogador 2 ganhou!");
  } else {
    print("Jogador 2 perdeu! O número secreto era $numeroSecreto.");
  }
}

void maquinaAdivinha() {
  print("Pense em um número entre 0 e 100 e a máquina tentará adivinhá-lo!");
  print("Quando a máquina acertar, digite 's' para sim ou 'n' para não.");

  var min = 0;
  var max = 100;
  var acertou = false;

  while (!acertou) {
    var tentativa = Random().nextInt(max - min + 1) + min;
    print("A máquina chutou: $tentativa");
    stdout.write("Acertou? (s/n): ");
    var resposta = stdin.readLineSync()!.toLowerCase();

    if (resposta == 's') {
      acertou = true;
      print("A máquina acertou!");
    } else {
      stdout.write(
          "O número é maior ou menor do que o chutado pela máquina? (maior/menor): ");
      var dica = stdin.readLineSync()!.toLowerCase();
      if (dica == 'maior') {
        min = tentativa + 1;
      } else if (dica == 'menor') {
        max = tentativa - 1;
      } else {
        print("Resposta inválida. Por favor, responda 'maior' ou 'menor'.");
      }
    }
  }
}
