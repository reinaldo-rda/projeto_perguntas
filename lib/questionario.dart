import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import './questao.dart';
import './resposta.dart';

class Questionario extends StatelessWidget {
  final int perguntaSelecionada;
  final List<Map<String, Object>> perguntas;
  final void Function(int) responder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.responder,
  });

  bool get isNext {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas =
        isNext ? perguntas[perguntaSelecionada]['respostas'] : null;

    return Column(
      children: [
        StepProgressIndicator(
          totalSteps: perguntas.length,
          currentStep: perguntaSelecionada,
          size: 20,
          selectedColor: Colors.orangeAccent,
          unselectedColor: Colors.grey,
        ),
        Questao(perguntas[perguntaSelecionada]['texto']),
        ...respostas.map((resp) {
          return Resposta(resp['texto'], () => responder(resp['pontuacao']));
        }).toList(),
      ],
    );
  }
}
