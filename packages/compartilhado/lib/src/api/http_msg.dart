extension HttpMensagens on String {
  String toHttpErro() {
    return split(': ')[1].split('}')[0];
  }

  String toExceptionMsg() {
    String res;
    try {
      res = split(':')[1];
    } catch (e) {
      res = this;
    }
    return res;
  }
}
