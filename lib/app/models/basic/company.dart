// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';

import 'category.dart' as cat;

class Company {
  int? id;
  String? name;
  String? phone;
  // int? idCategoryService;
  String? address;
  DateTime? timeUpdate;
  DateTime? timeAdd;
  List<ServiceMine>? servicesCompanyProvider;
  Company({
    this.id,
    this.name,
    this.phone,
    // this.idCategoryService,
    this.address,
    this.timeUpdate,
    this.timeAdd,
    this.servicesCompanyProvider,
  }) {
    servicesCompanyProvider ??= [];
  }

  Company copyWith({
    int? id,
    String? name,
    String? phone,
    int? idCategoryService,
    String? address,
    DateTime? timeUpdate,
    DateTime? timeAdd,
    List<ServiceMine>? servicesCompanyProvider,
  }) {
    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      // idCategoryService: idCategoryService ?? this.idCategoryService,
      address: address ?? this.address,
      timeUpdate: timeUpdate ?? this.timeUpdate,
      timeAdd: timeAdd ?? this.timeAdd,
      servicesCompanyProvider:
          servicesCompanyProvider ?? this.servicesCompanyProvider,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phone': phone,
      // 'idCategoryService': idCategoryService,
      'address': address,
      'timeUpdate': timeUpdate?.millisecondsSinceEpoch,
      'timeAdd': timeAdd?.millisecondsSinceEpoch,
      'servicesCompanyProvider':
          servicesCompanyProvider?.map((x) => x.toMap()).toList(),
    };
  }

  factory Company.fromMap(Map<String, dynamic> map) {
    return Company(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      // idCategoryService: map['idCategoryService'] != null
      //     ? map['idCategoryService'] as int
      //     : null,
      address: map['address'] != null ? map['address'] as String : null,
      timeUpdate: map['timeUpdate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeUpdate'] as int)
          : null,
      timeAdd: map['timeAdd'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['timeAdd'] as int)
          : null,
      servicesCompanyProvider: map['servicesCompanyProvider'] != null
          ? List<ServiceMine>.from(
              (map['servicesCompanyProvider'] as List<dynamic>)
                  .map<ServiceMine?>(
                (x) => ServiceMine.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) =>
      Company.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Company(id: $id, name: $name, phone: $phone, , address: $address, timeUpdate: $timeUpdate, timeAdd: $timeAdd, servicesCompanyProvider: $servicesCompanyProvider)';
  }

  @override
  bool operator ==(covariant Company other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phone == phone &&
        // other.idCategoryService == idCategoryService &&
        other.address == address &&
        other.timeUpdate == timeUpdate &&
        other.timeAdd == timeAdd &&
        listEquals(other.servicesCompanyProvider, servicesCompanyProvider);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        // idCategoryService.hashCode ^
        address.hashCode ^
        timeUpdate.hashCode ^
        timeAdd.hashCode ^
        servicesCompanyProvider.hashCode;
  }
}

class ServiceMine extends Equatable {
  int? idServ;
  cat.Category? category;
  String? name;
  ServiceMine({
    this.idServ,
    this.category,
    this.name,
  });

  ServiceMine copyWith({
    int? idServ,
    cat.Category? category,
    String? name,
  }) {
    return ServiceMine(
      idServ: idServ ?? this.idServ,
      category: category ?? this.category,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServ': idServ,
      'category': category?.toMap(),
      'name': name,
    };
  }

  factory ServiceMine.fromMap(Map<String, dynamic> map) {
    return ServiceMine(
      idServ: map['idServ'] != null ? map['idServ'] as int : null,
      category: map['category'] != null
          ? cat.Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceMine.fromJson(String source) =>
      ServiceMine.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ServiceMine(idServ: $idServ, category: $category, name: $name)';

  @override
  bool operator ==(covariant ServiceMine other) {
    if (identical(this, other)) return true;

    return other.idServ == idServ &&
        other.category == category &&
        other.name == name;
  }

  @override
  int get hashCode => idServ.hashCode ^ category.hashCode ^ name.hashCode;

  @override
  List<Object?> get props => [idServ, category, name];
}

class ServicesCompanyProvider {
  int idServices;
  ServicesCompanyProvider({
    required this.idServices,
  });

  ServicesCompanyProvider copyWith({
    int? idServices,
  }) {
    return ServicesCompanyProvider(
      idServices: idServices ?? this.idServices,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idServices': idServices,
    };
  }

  factory ServicesCompanyProvider.fromMap(Map<String, dynamic> map) {
    return ServicesCompanyProvider(
      idServices: map['idServices'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesCompanyProvider.fromJson(String source) =>
      ServicesCompanyProvider.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ServicesCompanyProvider(idServices: $idServices)';

  @override
  bool operator ==(covariant ServicesCompanyProvider other) {
    if (identical(this, other)) return true;

    return other.idServices == idServices;
  }

  @override
  int get hashCode => idServices.hashCode;
}

class CompanyModel {
  bool state;
  String? message;
  List<Company>? data;
  CompanyModel({
    required this.state,
    this.message,
    this.data,
  });

  CompanyModel copyWith({
    bool? state,
    String? message,
    List<Company>? data,
  }) {
    return CompanyModel(
      state: state ?? this.state,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'state': state,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      state: map['state'] as bool,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? List<Company>.from(
              (map['data'] as List<dynamic>).map<Company?>(
                (x) => Company.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CompanyModel(state: $state, message: $message, data: $data)';

  @override
  bool operator ==(covariant CompanyModel other) {
    if (identical(this, other)) return true;

    return other.state == state &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => state.hashCode ^ message.hashCode ^ data.hashCode;
}
