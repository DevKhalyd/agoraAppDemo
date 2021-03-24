import 'dart:convert';

import 'package:demo_videocalling/core/utils/utils_global.dart';
import 'package:demo_videocalling/core/utils/utils_ui.dart';
import 'package:demo_videocalling/features/agora/pages/call.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/widgets/mini_widgets.dart';
import '../../../login/domain/models/user_model.dart';
import '../../domain/usecases/cf_dashboard_uc.dart';
import 'package:http/http.dart' as http;

final _cfDashboard = CFDashBoardUseCase();

class DashboardBody extends StatelessWidget {
  const DashboardBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilderCustom<List<UserLocalModel>>(
      stream: _cfDashboard.getContacts(),
      onResponse: (context, snapshot) {
        final list = snapshot.data;

        if (list?.isEmpty ?? true) return CenterText('There is not contacts');

        return _CustomListView(list: list);
      },
    );
  }
}

class _CustomListView extends StatelessWidget {
  const _CustomListView({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<UserLocalModel> list;

  @override
  Widget build(BuildContext context) {
    return ListViewCustom(
      list,
      builder: (_, i) {
        final item = list[i];

        return ListTile(
            title: Text(
              'Id: ${item.id}',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Name: ${item.name}',
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.video_call_sharp,
                color: Colors.deepPurple,
              ),
              onPressed: () => requestForTokenAndChannel(
                  item.token, UtilsGloabals.generateId('channel')),
            ));
      },
    );
  }

  Future<void> requestForTokenAndChannel(
      String tokeDevice, String channelName) async {
    print('Cargando...');

    final body = <String, dynamic>{
      'tokenDevice': tokeDevice,
      'channel': channelName,
    };

    final result = await http.post(
      'https://angora-server.herokuapp.com/requestVideoCall',
      body: body,
    );

    if (result.statusCode != 200) {
      print('Something went wrong');
      return null;
    }

    final bodyResponse = json.decode(result.body);

    print(bodyResponse);

    final resultMap = TempResponse(
      token: bodyResponse['token'],
      channelName: bodyResponse['channel'],
    );
    
    await handleCameraAndMic(Permission.camera);
    await handleCameraAndMic(Permission.microphone);

    Get.to(CallPage(
      channelName: resultMap.channelName,
      token: resultMap.token,
    ));
  }
}

class TempResponse {
  final String token, channelName;
  TempResponse({this.token, this.channelName});
}
