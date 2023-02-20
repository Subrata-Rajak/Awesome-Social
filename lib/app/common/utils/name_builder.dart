class NameBuilder {
  static String buildNameFrom(String userName) {
    var res = "@";

    for (var i = 0; i < userName.length; i++) {
      if (userName[i] == " ") {
        res += "_";
      }
      res += userName[i];
    }
    return res;
  }
}
