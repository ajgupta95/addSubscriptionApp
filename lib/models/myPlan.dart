import 'package:flutter/material.dart';

class Plan {
  int _id;
  String _currency;
  String _amount;
  String _name;

  String _description;
  String _every;
  String _timePeriod;
  String _firstPayment;
  String _expiryDate;

  Color _color;
  String _paymentMethod;
  String _note;
  String _date;

  Plan(
      this._currency,
      this._amount,
      this._name,
      this._description,
      this._every,
      this._timePeriod,
      this._firstPayment,
      this._expiryDate,
      this._color,
      this._paymentMethod,
      this._note,
      this._date);

  Plan.withId(
      this._id,
      this._currency,
      this._amount,
      this._name,
      this._description,
      this._every,
      this._timePeriod,
      this._firstPayment,
      this._expiryDate,
      this._color,
      this._paymentMethod,
      this._note,
      this._date);

  int get id => _id;

  String get currency => _currency;

  String get amount => _amount;
  String get name => _name;

  String get description => _description;
  String get every => _every;
  String get timePeriod => _timePeriod;
  String get firstPayment => _firstPayment;
  String get expiryDate => _expiryDate;
  Color get color => _color;
  String get paymentMethod => _paymentMethod;
  String get note => _note;

  String get date => _date;

  set currency(String newCurrency) {
    this._currency = newCurrency;
  }

  set amount(String newAmount) {
    this._amount = newAmount;
  }

  set name(String newName) {
    this._name = newName;
  }

  set description(String newDescription) {
    this._description = newDescription;
  }

  set every(String newEvery) {
    this._every = newEvery;
  }

  set timePeriod(String newTimePeriod) {
    this._timePeriod = newTimePeriod;
  }

  set firstPayment(String newFirstPayment) {
    this._firstPayment = newFirstPayment;
  }

  set expiryDate(String newExpiryDate) {
    this._expiryDate = newExpiryDate;
  }

  set color(Color newColor) {
    this._color = newColor;
  }

  set paymentMethod(String newPaymentMethod) {
    this._paymentMethod = newPaymentMethod;
  }

  set note(String newNote) {
    this._note = newNote;
  }

  set date(String newDate) {
    this._date = newDate;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['currency'] = _currency;
    map['amount'] = _amount;
    map['name'] = _name;
    map['description'] = _description;
    map['every'] = _every;
    map['timePeriod'] = _timePeriod;
    map['firstPayment'] = _firstPayment;
    map['expiryDate'] = _expiryDate;
    map['color'] = _color;
    map['paymentMethod'] = _paymentMethod;
    map['note'] = _note;
    map['date'] = _date;

    return map;
  }

  Plan.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._currency = map['currency'];

    this._amount = map['amount'];
    this._name = map['name'];
    this._description = map['description'];
    this._every = map['every'];
    this._timePeriod = map['timePeriod'];
    this._firstPayment = map['firstPayment'];

    this._expiryDate = map['expiryDate'];
    this._color = map['color'];
    this._paymentMethod = map['paymentMethod'];
    this._note = map['note'];

    this._date = map['date'];
  }
}
