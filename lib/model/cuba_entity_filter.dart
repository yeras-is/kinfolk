import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kinfolk/model/url_types.dart';

class CubaEntityFilter {
  CubaEntityFilter({
    @required this.filter,
    this.view,
    this.returnCount,
    this.limit,
    this.offset,
    this.sort,
    SortTypes sortType,
  }) {
    if (sort != null) {
      this.sort = "${(sortType == SortTypes.asc ? "-" : "+")}${this.sort}";
    }
  }

  Filter filter;
  String view;
  bool returnCount;
  int limit;
  int offset;
  String sort;

  factory CubaEntityFilter.fromJson(String str) =>
      CubaEntityFilter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CubaEntityFilter.fromMap(Map<String, dynamic> json) =>
      CubaEntityFilter(
        filter: Filter.fromMap(json["filter"]),
        view: json["view"],
        returnCount: json["returnCount"],
        limit: json["limit"],
        sort: json["sort"],
        offset: json["offset"],
      );

  Map<String, dynamic> toMap() => {
        "filter": filter.toMap(),
        "view": view,
        "returnCount": returnCount ?? false,
        "limit": limit,
        "sort": sort,
        "offset": offset ?? 0,
        "returnNulls": true
      };
}

class Filter {
  Filter({
    @required this.conditions,
  });

  List<FilterCondition> conditions;

  factory Filter.fromJson(String str) => Filter.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Filter.fromMap(Map<String, dynamic> json) => Filter(
        conditions: List<FilterCondition>.from(
            json["conditions"].map((x) => FilterCondition.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "conditions": List<dynamic>.from(conditions.map((x) => x.toMap())),
      };
}

class FilterCondition {
  FilterCondition({
    this.group,
    this.conditions,
    this.property,
    Operators conditionOperator,
    this.value,
  }) {
    this.conditionOperator = ConditionsOperators.operators[conditionOperator];
  }

  String group;
  List<ConditionCondition> conditions;
  String property;
  String conditionOperator;
  dynamic value;

  factory FilterCondition.fromJson(String str) =>
      FilterCondition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FilterCondition.fromMap(Map<String, dynamic> json) => FilterCondition(
        group: json["group"] == null ? null : json["group"],
        conditions: json["conditions"] == null
            ? null
            : List<ConditionCondition>.from(
                json["conditions"].map((x) => ConditionCondition.fromMap(x))),
        property: json["property"] == null ? null : json["property"],
        conditionOperator: json["operator"] == null ? null : json["operator"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => conditions == null
      ? {
          "property": property == null ? null : property,
          "operator": conditionOperator == null ? null : conditionOperator,
          "value": value,
        }
      : {
          "group": group == null ? null : group,
          "conditions": conditions == null
              ? null
              : List<dynamic>.from(conditions.map((x) => x.toMap())),
          "property": property == null ? null : property,
          "operator": conditionOperator == null ? null : conditionOperator,
          "value": value,
        };
}

class ConditionCondition {
  ConditionCondition(
      {@required this.property,
      @required Operators conditionOperator,
      @required this.value}) {
    this.conditionOperator = ConditionsOperators.operators[conditionOperator];
  }

  String property;
  String conditionOperator;
  dynamic value;

  factory ConditionCondition.fromJson(String str) =>
      ConditionCondition.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConditionCondition.fromMap(Map<String, dynamic> json) =>
      ConditionCondition(
        property: json["property"],
        conditionOperator: json["operator"],
        value: json["value"],
      );

  Map<String, dynamic> toMap() => {
        "property": property,
        "operator": conditionOperator,
        "value": value,
      };
}
