class NullOrEmptyArgument extends Error {
  NullOrEmptyArgument(this.name);
  final String name;
  String toString() => "$name argument is Null or Empty";
}
