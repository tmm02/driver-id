import 'package:driverid/models/redeem_model.dart';
import 'package:driverid/models/terminal_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config.dart';


class RedeemProvider extends ChangeNotifier{

  Future<List<dynamic>> getCompensationList({int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_compensation");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    } else {
      throw Exception();
    }
  }

  Future<List<dynamic>> getCompensationDetailList(dynamic terminalId, {int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_comp_detail");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body: {
      "terminal_id":"${terminalId}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      return json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
    } else {
      throw Exception();
    }
  }

  Future<List<dynamic>> getRedeemList(dynamic terminalId, {int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_redeem");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body: {
      'terminal_id':'${terminalId}'
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'];//.cast<Map<String, dynamic>>();
      return result;
      //return result.map<RedeemModel>((json) => RedeemModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  Future<List<RedeemModel>> getRedeemListByTerminal(int terminalId, {int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_reward_per_term");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body: {
      "terminal_id": "${terminalId}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
      return result.map<RedeemModel>((json) => RedeemModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  Future<TransactionModel> getTransactionDetail(String contentId) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/posts/${contentId}");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return TransactionModel.fromJson(result);
    } else {
      return null;
      throw Exception();
    }
  }



  Future<dynamic> createTransaction({String truckId, dynamic terminalId, String startDate}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/create_trans");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body:{
      "truck_id":truckId,
      "terminal_id":"${terminalId}",
      "start_date":startDate
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      return null;
      throw Exception();
    }
  }

  Future<dynamic> redeemPoint(dynamic compensationHeader, RedeemModel redeemModel) async {
    print("${compensationHeader['compensation_header_id']} ${redeemModel.reward_id} ${redeemModel.qty_point}");
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/redeem_point");
    final response = await http.post(url, headers: {
    "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body:{
      "compensation_header_id":"${compensationHeader['compensation_header_id']}",
      "reward_id":"${redeemModel.reward_id}",
      "point_use":"${redeemModel.qty_point}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      return result;
    } else {
      return null;
      throw Exception();
    }
  }

  Future<List<RedeemModel>> getRedeemApproveList(int terminalId, {int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_reward_approve");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
      return result.map<RedeemModel>((json) => RedeemModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }


  Future<List<RedeemModel>> getRedeemRejectList(int terminalId, {int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_reward_approve");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
      return result.map<RedeemModel>((json) => RedeemModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }


}