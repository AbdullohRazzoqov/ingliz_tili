import 'package:ingliz_tili/db/dictionary.dart';
import 'package:ingliz_tili/objectbox.g.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';




class ObjectBox {
  late final Store store;
  late final Box<Dicionary> userBox;
  ObjectBox._create(this.store) {
    userBox = store.box<Dicionary>();
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "User"));
    return ObjectBox._create(store);
  }
}
