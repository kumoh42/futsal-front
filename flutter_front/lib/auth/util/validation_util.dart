final RegExp passwordRegex =
    RegExp(r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*])(?=.*[0-9])\S{8,20}$');

String? validatePassword(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else if (!passwordRegex.hasMatch(value)) {
    return "비밀번호 양식이 옳지 않습니다.";
  } else {
    return null;
  }
}

String? validateId(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "공백이 들어갈 수 없습니다.";
  } else {
    return null;
  }
}
