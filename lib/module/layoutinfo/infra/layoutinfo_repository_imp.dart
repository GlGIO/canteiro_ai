import 'dart:convert';

import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutinfo_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/entities/layoutplan_entity.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/addnewlayout_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getalllayouts_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/params/getlayoutplan_params.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/typedefs/layoutinfo_typedef.dart';
import 'package:canteiro_ai/util/db.dart';
import 'package:canteiro_ai/module/layoutinfo/domain/repository/layoutinfo_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LayoutInfoRepositoryImp implements LayoutInfoRepository {
  final DatabaseSQFlite localDatabase;

  LayoutInfoRepositoryImp({required this.localDatabase});

  get networkInfo => null;

  @override
  GetAllLayoutsResult getAllLayouts(GetAllLayoutsParams params) async {
    final List<Map<String, dynamic>> list =
        await localDatabase.query('layout_info');

    debugPrint('maps: $list');

    return list
        .map<LayoutInfoEntity>((e) => LayoutInfoEntity(
              id: e['id'] as int,
              title: e['title'] as String,
              local: e['local'] as String,
              description: e['description'] as String,
              date: e['date'] as String,
              typeEdf: e['typeEdf'] as String,
              typeCant: e['typeCant'] as String,
              stage: e['stage'] as String,
              largura: e['largura'] as double,
              profundidade: e['profundidade'] as double,
              inicioACX: e['inicioACX'] as double,
              fimACX: e['fimACX'] as double,
              inicioACY: e['inicioACY'] as double,
              fimACY: e['fimACY'] as double,
            ))
        .toList();
  }

  @override
  GetLayoutPlanResult getLayoutPlan(GetLayoutPlanParams params) async {
    final List<Map<String, dynamic>> list = await localDatabase.queryPlan(
      'layout_plan',
      'layout_info_id = ?',
      [params.id],
    );

    debugPrint('maps: $list');

    return list
        .map<LayoutPlanEntity>((e) => LayoutPlanEntity(
              areaName: e['area_name'] as String,
              x1: e['x1'] as double,
              y1: e['y1'] as double,
              x2: e['x2'] as double,
              y2: e['y2'] as double,
            ))
        .toList();
  }

  @override
  AddNewLayoutResult addNewLayout(AddNewLayoutParams params) async {
    final Map<String, dynamic> layoutInfoMap = {
      'title': params.title,
      'local': params.local,
      'description': params.description,
      'date': DateTime.now().toString(),
      'typeEdf': params.typeEdf,
      'typeCant': params.typeCant,
      'stage': params.stage,
      'largura': params.largura,
      'profundidade': params.profundidade,
      'inicioACX': params.inicioACXController,
      'fimACX': params.fimACXController,
      'inicioACY': params.inicioACYController,
      'fimACY': params.fimACYController,
    };

    String script = """
   "Area construida":{
      "area_name":"Area construida",
      "x1":${params.inicioACXController},
      "y1":${params.inicioACYController},
      "x2":${params.fimACXController},
      "y2":${params.fimACYController}
   },
    "Acesso":{
      "area_name":"Acesso",
      "x1":${params.largura / 4},
      "y1":0,
      "x2":${params.largura / 4 * 3},
      "y2":2
   },
   "Almocharifado":{
      "area_name":"Almocharifado",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Escritórios":{
      "area_name":"Escritórios",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Refeitorio":{
      "area_name":"Refeitorio",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Vestiários":{
      "area_name":"Vestiários",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Banheiros":{
      "area_name":"Banheiros",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Áreas de Montagem":{
      "area_name":"Áreas de Montagem",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Cimento":{
      "area_name":"Cimento",
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Areia e Brita":{
      "area_name":"Areia e Brita",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Equipamentos":{
      "area_name":"Equipamentos",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   },
   "Áreas de Descarte":{
      "area_name":"Áreas de Descarte",
      "x1":0,
      "y1":0,
      "x2":0,
      "y2":0
   }
  """;

    String apiKey = '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';
    String endpoint = 'https://api.openai.com/v1/chat/completions';

    final dio = Dio();

    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $apiKey';

    Map<String, dynamic> requestBody = {
      'model': 'gpt-4-1106-preview',
      'messages': [
        {
          'role': 'system',
          'content':
              'Distribua os pontos de layout para cada área, exceto Área Construída e Acesso, utilizando o modelo de mapa fornecido. Certifique-se de que os valores de x1, y1, x2 e y2 para cada área se encaixem nas seguintes restrições: x não deve ultrapassara ${params.largura}, y não deve ultrapassar ${params.profundidade}. Garanta que todos os valores atribuídos sejam únicos para cada área. A resposta deve incluir SOMENTE E APENAS o mapa modificado.'
        },
        {'role': 'user', 'content': script},
      ],
    };

    debugPrint('chamou o dio');

    Response response = await dio.post(endpoint, data: jsonEncode(requestBody));

    String jsonResponse = response.data['choices'][0]['message']['content'];

    jsonResponse = jsonResponse.replaceAll('```json', '');
    jsonResponse = jsonResponse.replaceAll('```', '');

    debugPrint('jsonResponse: $jsonResponse');

    try {
      final Map<String, dynamic> layoutPlanMap = json.decode(jsonResponse);

      final layoutInfoId = await localDatabase.insert(
        'layout_info',
        layoutInfoMap,
      );

      for (final entry in layoutPlanMap.entries) {
        final Map<String, dynamic> areaMap = entry.value;

        await localDatabase.insert(
          'layout_plan',
          {
            'layout_info_id': layoutInfoId,
            'area_name': areaMap['area_name'],
            'x1': areaMap['x1'],
            'y1': areaMap['y1'],
            'x2': areaMap['x2'],
            'y2': areaMap['y2'],
          },
        );
      }
    } catch (e) {
      const int cont = 3;
      // Tratamento da exceção
      debugPrint('Erro ao decodificar o JSON: $e');

      // Tenta novamente cont vezes
      for (int i = 0; i < cont; i++) {
        Response response =
            await dio.post(endpoint, data: jsonEncode(requestBody));

        if (response.statusCode == 200) {
          String jsonResponse = response.data['choices'][0]['text'];

          try {
            final Map<String, dynamic> layoutPlanMap =
                json.decode(jsonResponse);
            debugPrint('layoutPlanMap: $layoutPlanMap');

            final layoutInfoId = await localDatabase.insert(
              'layout_info',
              layoutInfoMap,
            );

            for (final entry in layoutPlanMap.entries) {
              final Map<String, dynamic> areaMap = entry.value;

              await localDatabase.insert(
                'layout_plan',
                {
                  'layout_info_id': layoutInfoId,
                  'area_name': areaMap['area_name'],
                  'x1': areaMap['x1'],
                  'y1': areaMap['y1'],
                  'x2': areaMap['x2'],
                  'y2': areaMap['y2'],
                },
              );
            }
            // Se chegou até aqui sem lançar exceção, sai do loop
            break;
          } catch (e) {
            // Tratamento da exceção ao tentar novamente
            debugPrint('Erro ao decodificar o JSON na tentativa $i: $e');
          }
        }
      }
    }
    return;
  }
}
