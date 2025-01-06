class AValidtor {
  static String? validateEmptyText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Tidak Boleh Kosong';
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh Kosong.';
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Email tidak Valid';
    }

    return null;
  }

  static String? validatorPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password tidak boleh kosong';
    }

    if (value.length < 6) {
      return 'password terlalu pendek';
    }

    return null;
  }
}