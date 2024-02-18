import 'package:flutter/material.dart';

class Reservation {
  int? idRsv;
  int? idUser;
  String? msisdn;
  String? iccid;
  String? category;
  String? dateReservation;
  int? statusReservation;
  String? dateCancelReservation;
  String? dateIccidUpdate;
  String? clientFirstName;
  String? clientMiddleName;
  String? clientLastName;
  String? clientAdress;
  String? clientCurrentMobileNumber;
  String? clientEmailAdress;
  int? referenceId;
  String? rccm;
  String? idnat;
  String? adressCompany;
  String? numberPurpose;
  bool? selected;
  TextEditingController iccidController = TextEditingController();

  Reservation({
    this.idRsv,
    this.adressCompany,
    this.category,
    this.clientAdress,
    this.clientCurrentMobileNumber,
    this.clientEmailAdress,
    this.clientFirstName,
    this.clientLastName,
    this.clientMiddleName,
    this.dateCancelReservation,
    this.dateIccidUpdate,
    this.dateReservation,
    this.iccid,
    this.idUser,
    this.idnat,
    this.msisdn,
    this.numberPurpose,
    this.rccm,
    this.referenceId,
    this.statusReservation,
    this.selected,
  });
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      idRsv: json['idRsv'],
      adressCompany: json['adressCompany'],
      category: json['category'],
      clientAdress: json['clientAdress'],
      clientCurrentMobileNumber: json['clientCurrentMobileNumber'],
      clientEmailAdress: json['clientEmailAdress'],
      clientFirstName: json['clientFirstName'],
      clientLastName: json['clientLastName'],
      clientMiddleName: json['clientMiddleName'],
      dateCancelReservation: json['dateCancelReservation'],
      dateIccidUpdate: json['dateIccidUpdate'],
      dateReservation: json['dateReservation'],
      iccid: json['iccid'],
      idUser: json['idUser'],
      idnat: json['idnat'],
      msisdn: json['msisdn'],
      numberPurpose: json['numberPurpose'],
      rccm: json['rccm'],
      referenceId: json['referenceId'],
      statusReservation: json['statusReservation'],
      selected: false,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'adressCompany': adressCompany,
      'category': category,
      'clientAdress': clientAdress,
      'clientCurrentMobileNumber': clientCurrentMobileNumber,
      'clientEmailAdress': clientEmailAdress,
      'clientFirstName': clientFirstName,
      'clientLastName': clientLastName,
      'clientMiddleName': clientMiddleName,
      'dateCancelReservation': dateCancelReservation,
      'dateIccidUpdate': dateIccidUpdate,
      'dateReservation': dateReservation,
      'iccid': iccid,
      'idUser': idUser,
      'idnat': idnat,
      'msisdn': msisdn,
      'numberPurpose': numberPurpose,
      'rccm': rccm,
      'referenceId': referenceId,
      'statusReservation': statusReservation
    };
  }

  static Future<List<Reservation>> reservation(List<dynamic> data) async {
    return data.map((element) => Reservation.fromJson(element)).toList();
  }
}
