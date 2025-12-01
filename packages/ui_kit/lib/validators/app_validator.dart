class AppValidators {
  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'El correo es requerido';
    }

    if (!_emailRegExp.hasMatch(value)) {
      return 'Ingresa un correo válido';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida';
    }

    // 8 characters
    if (value.length < 8) {
      return 'Debe tener al menos 8 caracteres';
    }

    // Upper letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Debe contener al menos una mayúscula';
    }

    // Lower letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Debe contener al menos una minúscula';
    }
    // Number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Debe contener al menos un número';
    }

    // Special character (!@#\$&*)
    if (!value.contains(RegExp(r'[!@#\$&*~]'))) {
      return 'Debe contener un carácter especial ej. !@#\\\$&*';
    }

    return null;
  }
}
