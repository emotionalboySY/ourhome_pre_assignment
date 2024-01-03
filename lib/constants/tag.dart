import 'dart:ui';

enum Tag {
  newProduct('신규', Color(0xff12a14e)),
  popular('인기', Color(0xff1414e0)),
  best('BEST', Color(0xffd41313));

  final String name;
  final Color color;

  const Tag(this.name, this.color);
}