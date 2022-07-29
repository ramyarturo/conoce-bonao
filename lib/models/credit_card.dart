import 'dart:convert';

class CreditCard {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;

  CreditCard({
    this.cardNumber = "",
    this.expiryDate = "",
    this.cardHolderName = "",
    this.cvvCode = "",
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      cardNumber: map['cardNumber'] as String,
      expiryDate: map['expiryDate'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cvvCode: map['cvvCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) => CreditCard.fromMap(json.decode(source) as Map<String, dynamic>);
}
