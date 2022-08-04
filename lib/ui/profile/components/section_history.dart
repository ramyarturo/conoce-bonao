

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants/theme.dart';
import '../../../gen/assets.gen.dart';
import '../../../utils/intent_utils.dart';

class SectionHistory extends StatelessWidget {
  const SectionHistory({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.tagNote.image(
                width: 29,
              ),
              const SizedBox(width: 15),
              Text(
                "#Conocebonao",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const VerticalSpacing(),
          Text(
            "Historia",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const VerticalSpacing(),
          AutoSizeText(
            " El nombre Bonao proviene del cacique taíno quien gobernaba estas tierras durante la llegada de los \n\n colonizadores españoles a la isla. El origen de Bonao se remonta a finales del siglo XV con el levantamiento de una fortaleza para proteger las minas de oro cercanas. Cuando las minas se agotaron, los habitantes abandonaron la región. ",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: const Color(0xff4f4f4f),
                  letterSpacing: 0.3,
                ),
          ),
          const VerticalSpacing(),
          TextButton(
            onPressed: () {
              IntentUtils.openUrl(
                "https://ayuntamientobonao.gob.do/historia/#:~:text=El%20nombre%20Bonao%20proviene%20del,las%20minas%20de%20oro%20cercanas",
              );
            },
            child: const Text("Conoce más aquí..."),
          ),
        ],
      ),
    );
  }
}