/// Convert a String to DateTime value
///
extension ToDateTime on String? {
  DateTime? toDateTime() {
    return this != null && isDate(this!) ? DateTime.parse(this!) : null;
  }
}

// check if a string is a valid date
bool isDate(String str) {
  try {
    DateTime.parse(str);
    return true;
  } catch (e) {
    return false;
  }
}
