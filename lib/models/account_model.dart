import 'dart:convert';

import 'package:driverid/config.dart';
import 'package:intl/intl.dart';

class AccountModel {
  dynamic id;
  String email;
  String name;
  String address;
  String phone;
  String date_birth;
  String place_birth;
  String emergency_call;
  String pas_foto;

  String sim_number;
  String sim_foto;

  String social_id;
  String social_id_foto;

  String sertifikasi_1;
  String sertifikasi_no_1;
  String sertifikasi_2;
  String sertifikasi_no_2;

  String foto_with_ktp_sim;
  String id_card_company;
  String truck_company;
  String driver_id;
  String date_expired;
  String status;
  dynamic login_mobile_id;

  
  AccountModel({
    this.id,
    this.address,
    this.date_birth,
    this.email,
    this.phone,
    this.emergency_call,
    this.place_birth,
    this.name,
    this.pas_foto,
    this.sim_number,
    this.sim_foto,

    this.social_id,
    this.social_id_foto,

    this.sertifikasi_1,
    this.sertifikasi_no_1,
    this.sertifikasi_2,
    this.sertifikasi_no_2,

    this.foto_with_ktp_sim,
    this.id_card_company,
    this.truck_company,
    this.driver_id,
    this.date_expired,
    this.status,
    this.login_mobile_id,
  });

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': '${id}',
    if (address != null) 'address': address,
    if (date_birth != null) 'date_birth': date_birth,
    //if (email != null) 'email': email,
    'email': email == null ? '' : email,
    if (phone != null) 'phone': phone,
    if (emergency_call != null) 'emergency_call': emergency_call,
    if (place_birth != null) 'place_birth': place_birth,
    if (name != null) 'name': name,
    if (pas_foto != null) 'pas_foto': pas_foto,

    if (sim_number != null) 'sim_number': sim_number,
    if (sim_foto != null) 'sim_foto': sim_foto,

    if (social_id != null) 'social_id': social_id,
    if (social_id_foto != null) 'social_id_foto': social_id_foto,

    if (sertifikasi_1 != null) 'sertifikasi_1': sertifikasi_1,
    if (sertifikasi_no_1 != null) 'sertifikasi_no_1': sertifikasi_no_1,
    if (sertifikasi_2 != null) 'sertifikasi_2': sertifikasi_2,
    if (sertifikasi_no_2 != null) 'sertifikasi_no_2': sertifikasi_no_2,

    if (foto_with_ktp_sim != null) 'foto_with_ktp_sim': foto_with_ktp_sim,
    if (id_card_company != null) 'id_card_company': id_card_company,
    if (truck_company != null) 'truck_company': truck_company,
    if (driver_id != null) 'driver_id': driver_id,
    if (date_expired != null) 'date_expired': date_expired,
    if (status != null) 'status': status,
    if (login_mobile_id != null) 'login_mobile_id': '${login_mobile_id}',
  };

  factory AccountModel.fromSession(String jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    }

    Map<String, dynamic> data = json.decode(jsonString);
    return AccountModel(
      id: data['id'],
      address: data['address'],
      date_birth: data['date_birth'],
      email: data['email'],
      phone: data['phone'],
      emergency_call: data['emergency_call'],
      place_birth: data['place_birth'],
      name: data['name'],
      pas_foto: data['pas_foto'],

      sim_number: data['sim_number'],
      sim_foto: data['sim_foto'],

      social_id: data['social_id'],
      social_id_foto: data['social_id_foto'],

      sertifikasi_1: data['sertifikasi_1'],
      sertifikasi_no_1: data['sertifikasi_no_1'],
      sertifikasi_2: data['sertifikasi_2'],
      sertifikasi_no_2: data['sertifikasi_no_2'],

      foto_with_ktp_sim: data['foto_with_ktp_sim'],
      id_card_company: data['id_card_company'],
      truck_company: data['truck_company'],
      driver_id: data['driver_id'],
      date_expired: data['date_expired'],
      status: data['status'],
      login_mobile_id: data['login_mobile_id'],
    );
  }


  factory AccountModel.fromAuthJson(Map<String, dynamic> json) => AccountModel(
    id: json['id'],
    address: json['address'],
    date_birth: json['date_birth'],
    place_birth: json['place_birth'],
    name: json['name'] == null ?  json['lm_username'] :  json['name'],
    pas_foto: json['pas_foto'],
    email: json['email'],
    emergency_call: json['emergency_call'],
    phone: json['lm_phone'],
    sim_number: json['sim_number'],
    sim_foto: json['sim_foto'],
    social_id: json['social_id'],
    social_id_foto: json['social_id_foto'],

    sertifikasi_1: json['sertifikasi_1'],
    sertifikasi_no_1: json['sertifikasi_no_1'],
    sertifikasi_2: json['sertifikasi_2'],
    sertifikasi_no_2: json['sertifikasi_no_2'],

    foto_with_ktp_sim: json['foto_with_ktp_sim'],
    id_card_company: json['id_card_company'],
    truck_company: json['truck_company'],
    driver_id: json['driver_id'],
    date_expired: json['date_expired'] != null && json['date_expired'] != '' ? new DateFormat(Config.DATE_SERVER_FORMAT).format(new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(json['date_expired'])) : '',
    status: json['status'],
    login_mobile_id: json['login_mobile_id'],

  );
}
