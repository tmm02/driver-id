import 'package:action_broadcast/action_broadcast.dart';
import 'package:driverid/models/terminal_model.dart';
import 'package:driverid/models/transaction_model.dart';
import 'package:driverid/utils/session.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../config.dart';


class TransactionProvider extends ChangeNotifier{

  Future<List<TerminalModel>> getTerminalList({int pageOffset = 0, int limit}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/list_terminal");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
      return result.map<TerminalModel>((json) => TerminalModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
    return null;
  }

  Future<List<TransactionModel>> getTransactionList({int pageOffset = 0, int limit, String startDate, String endDate}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_trans_by_period");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body: {
      "start_date":startDate,
      "end_date":endDate
    });

    print('${url} ${startDate} ${endDate} ${response.body}');
    if (response.statusCode == 200) {
      final result = json.decode(response.body)['rows'].cast<Map<String, dynamic>>();
      return result.map<TransactionModel>((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw Exception();
    }
  }

  Future<TransactionModel> getTransactionDetail(dynamic transactionId) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/view_trans_by_id");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body: {
      "transaction_id":"${transactionId}"
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

  Future<dynamic> createTransaction({String truckId, dynamic terminalId, String startDate, String fotoTiket}) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/create_trans");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body:{
      "truck_id":truckId,
      "terminal_id":"${terminalId}",
      "start_date":startDate,
      "foto_tiket":fotoTiket,
    });

    print('${url} ${response.body}');
    if (response.statusCode == 200) {
      sendBroadcast('newTransaction');
      final result = json.decode(response.body);
      return result;
    } else {
      return null;
      throw Exception();
    }
  }

  Future<dynamic> cancelTrans(TransactionModel transactionModel) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/cancel_trans");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body:{
      "transaction_id":"${transactionModel.transaction_id}",
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


  Future<dynamic> getActiveTransaction() async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/get_active_trans");
    final response = await http.get(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
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

  Future<dynamic> sendRating(TransactionModel transactionModel, int rating) async {
    final url = Uri.parse("${Config.SOCMED_END_POINT}/v2/rating_terminal");
    final response = await http.post(url, headers: {
      "Authorization":"Bearer ${await Session.get(Session.TOKEN_SESSION_KEY)}"
    }, body:{
      "terminal_id":'${transactionModel.terminal_id}',
      "transaction_id":'${transactionModel.transaction_id}',
      "rating":'${rating}',
      "comments":"",
      "date_rating": DateFormat(Config.DATE_TIME_SERVER_FORMAT).format(new DateTime.now()),
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


}