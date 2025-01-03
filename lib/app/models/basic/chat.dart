// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ChatModel {
  bool state;
  String? massege;
  List<Chat>? data;
  ChatModel({
    required this.state,
    this.massege,
    this.data,
  });

  ChatModel copyWith({
    bool? state,
    String? massege,
    List<Chat>? data,
  }) {
    return ChatModel(
      state: state ?? this.state,
      massege: massege ?? this.massege,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'massege': massege,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      state: map['state'] as bool,
      massege: map['massege'] != null ? map['massege'] as String : null,
      data: map['data'] != null
          ? List<Chat>.from(
              (map['data'] as List<dynamic>).map<Chat?>(
                (x) => Chat.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChatModel(state: $state, massege: $massege, data: $data)';

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.massege == massege &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ massege.hashCode ^ data.hashCode;
}

class Chat {
  int? id;
  String? containt;
  int idChat;
  int? idEmp;
  bool? isRecive;
  Chat({
    this.id,
    this.containt,
    required this.idChat,
    this.idEmp,
    this.isRecive,
  });

  Chat copyWith({
    int? id,
    String? containt,
    int? idChat,
    int? idEmp,
    bool? isRecive,
  }) {
    return Chat(
      id: id ?? this.id,
      containt: containt ?? this.containt,
      idChat: idChat ?? this.idChat,
      idEmp: idEmp ?? this.idEmp,
      isRecive: isRecive ?? this.isRecive,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'containt': containt,
      'idChat': idChat,
      'idEmp': idEmp,
      'isRecive': isRecive,
    };
  }

  Map<String, dynamic> toMapDataBase() {
    return <String, dynamic>{
      'containt': containt,
      'idChat': idChat,
      'idEmp': idEmp,
      'isRecive': isRecive,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] != null ? map['id'] as int : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
      idChat: map['idChat'] as int,
      idEmp: map['idEmp'] != null ? map['idEmp'] as int : null,
      isRecive: map['isRecive'] != null ? map['isRecive'] as bool : null,
    );
  }
  factory Chat.fromMapData(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] != null ? map['id'] as int : null,
      containt: map['containt'] != null ? map['containt'] as String : null,
      idChat: map['idChat'] as int,
      idEmp: map['idEmp'] != null ? map['idEmp'] as int : null,
      isRecive: map['isRecive'] != null
          ? map['isRecive'] == 1
              ? true
              : false
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) =>
      Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(id: $id, containt: $containt, idChat: $idChat, idEmp: $idEmp, isRecive: $isRecive)';
  }

  @override
  bool operator ==(covariant Chat other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.containt == containt &&
        other.idChat == idChat &&
        other.idEmp == idEmp &&
        other.isRecive == isRecive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        containt.hashCode ^
        idChat.hashCode ^
        idEmp.hashCode ^
        isRecive.hashCode;
  }
}
