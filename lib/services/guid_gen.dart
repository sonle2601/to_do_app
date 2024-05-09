import 'package:uuid/uuid.dart';

class UUIDGenerator {
  static final _uuid = Uuid();

  // Phương thức generate() tạo ra UUID phiên bản 4
  static String generate() {
    return _uuid.v4(); // Tạo UUID phiên bản 4
  }
}
