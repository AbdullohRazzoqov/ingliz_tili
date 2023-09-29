import 'package:objectbox/objectbox.dart';

@Entity()
class Dicionary {
  @Id()
  int id;
  String uz;
  String ing;
  Dicionary({
     this.id = 0,
    required this.uz,
    required this.ing,
  });
}


@Entity()
class DicionaryList {
  @Id()
  int id;
  String uz;
  String ing;
  DicionaryList({
     this.id = 0,
    required this.uz,
    required this.ing,
  });
}
