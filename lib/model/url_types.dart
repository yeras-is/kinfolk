class UrlTypes {
  static final path = <Types, String>{
    Types.services: 'services',
    Types.queries: 'queries',
    Types.entities: 'entities'
  };
}

enum Types { services, queries, entities }
