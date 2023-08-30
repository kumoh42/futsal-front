final RegExp passwordRegex =
    RegExp(r'^(?=.*[a-zA-Z])(?=.*[!@#$%^&*])(?=.*[0-9])\S{8,20}$');

String? validatePassword(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    // 공백 입력은 TextFormField에서 막았으므로, Empty인 경우는 입력을 하지 않았을 때 밖에 없음
    return "값을 입력해 주세요.";
  } else if (!passwordRegex.hasMatch(value)) {
    return "비밀번호 양식이 옳지 않습니다.";
  } else {
    return null;
  }
}

String? validateId(String? value) {
  if (value == null) return null;
  if (value.isEmpty) {
    return "값을 입력해 주세요.";
  } else {
    return null;
  }
}
