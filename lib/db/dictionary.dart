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
