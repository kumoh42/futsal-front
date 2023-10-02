const Map<String, int> majorListWithId = {
  "IT융합학과": 30,
  "건축학부": 21,
  "경영학과": 32,
  "광시스템공학과": 28,
  "교직원": 34,
  "기계공학과": 18,
  "기계설계공학과": 19,
  "대학원": 36,
  "메디컬IT융합공학과": 29,
  "산업공학부": 22,
  "신소재공학부": 23,
  "응용수학과": 31,
  "자치단체": 35,
  "전자공학부": 20,
  "정동아리": 17,
  "컴퓨터공학과": 26,
  "컴퓨터소프트웨어공학과": 27,
  "토목공학과": 25,
  "화학소재융합공학부": 24,
};

final List<String> majorList = majorListWithId.keys.toList();
final majorListForSearch = [
  "전체",
  ...majorList,
];

const Map<String, int> circleListWithId = {
  "ECST": 22,
  "ESC": 25,
  "MAX": 27,
  "NAV": 11,
  "NES": 16,
  "PAX": 20,
  "PVC": 19,
  "SOFT": 15,
  "VIPER": 14,
  "개인": -1,
  "골든크로우": 7,
  "라플라스": 24,
  "레이븐스": 8,
  "레인저": 18,
  "메축": 30,
  "몬스터": 28,
  "발로차": 17,
  "볼케이노": 9,
  "시그마": 13,
  "싸이클론": 26,
  "아키": 31,
  "엔트로피": 10,
  "이글스": 23,
  "챌린저": 12,
  "코브라": 6,
  "코스트": 29,
  "팬텀": 21,
  "하나로": 32,
};

final List<String> circleList = circleListWithId.keys.toList();

final circleListForSearch = [
  '전체',
  ...circleList,
];
const authList = [
  'user',
  'admin',
];
const authListForSearch = [
  'all',
  ...authList,
];

const info = [
  'ID',
  '이름',
  '동아리',
  '소속',
  '전화번호',
];
