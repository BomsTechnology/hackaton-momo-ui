import 'dart:convert';

import 'package:hackaton_momo/models/user.dart';

class Transaction {
  final int id;
  final String amount;
  final String currency;
  final String type;
  final String payerMessage;
  final String payeeNote;
  final Map<String, dynamic> sender;
  final Map<String, dynamic> receiver;
  final String date;

  Transaction(
    this.id,
    this.amount,
    this.currency,
    this.type,
    this.payerMessage,
    this.payeeNote,
    this.sender,
    this.receiver,
    this.date,
  );

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        amount = json['amount'],
        currency = json['currency'],
        type = json['type'],
        payerMessage = json['payerMessage'],
        payeeNote = json['payeeNote'],
        sender = json['sender'],
        receiver = json['receiver'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'currency': currency,
        'type': type,
        'receiver': receiver,
        'sender': sender,
        'payerMessage': payerMessage,
        'payeeNote': payeeNote,
        'date': date,
      };
}
