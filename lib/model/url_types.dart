class UrlTypes {
  static final path = <Types, String>{
    Types.services: 'services',
    Types.queries: 'queries',
    Types.entities: 'entities'
  };
}

enum Types { services, queries, entities }
enum SortTypes { asc, desc }

class ConditionsOperators {
  static final operators = <Operators, String>{
    Operators.equals: '=',
    Operators.notEquals: '<>',
    Operators.less: '<',
    Operators.lessThanEqual: '<=',
    Operators.greater: '>',
    Operators.greaterThanEqual: '>=',
    Operators.startsWith: 'startsWith',
    Operators.endsWith: 'endsWith',
    Operators.contains: 'contains',
    Operators.notEmpty: 'notEmpty',
    Operators.notInList: 'notIn',
    Operators.inList: 'in'
  };
}

enum Operators {
  equals,
  notEquals,
  less,
  lessThanEqual,
  greater,
  greaterThanEqual,
  startsWith,
  endsWith,
  contains,
  notEmpty,
  notInList,
  inList
}
