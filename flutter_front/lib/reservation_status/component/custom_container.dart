import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';

// 네모나고 모서리가 둥근 박스
class CustomContainer extends StatelessWidget {
  final String? title;
  final double? width;
  final double? height;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final double? boarderRadius;
  final double? boarderWidth;
  final Color? boarderColor;
  final Color? color;
  final bool isBackground;
  final Widget child;

  CustomContainer({
    Key? key,
    this.title,
    this.width,
    this.height,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.boarderRadius,
    this.boarderWidth,
    this.boarderColor,
    this.color,
    this.isBackground = false,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // 주어진 크기 범위 내에서 가로 너비와 세로 높이를 제한하는 제약 조건을 설정
      constraints: BoxConstraints(
        minWidth: minWidth ?? 500,
        minHeight: minHeight ?? 0,
        maxWidth: maxWidth ?? double.infinity,
        maxHeight: maxHeight ?? double.infinity,
      ),
      // Card->Material Design 스타일의 위젯 중 하나로, 정보를 간단하게 표시하거나 그룹화할 때 사용되는 컨테이너
      child: Card(
        elevation: isBackground ? 0 : 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(boarderRadius ?? kBorderRadiusSize),
          ),
          side: boarderColor != null
              ? BorderSide(width: boarderWidth ?? 0, color: boarderColor!)
              : BorderSide.none,
        ),
        color: color,
        child: Padding(
          padding: EdgeInsets.all(isBackground ? 0 : kPaddingMiddleSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // 자식 요소들의 최소 필요 공간만 차지
            mainAxisSize: MainAxisSize.min,
            children: [
              // 컨테이너의 제목, title
              if (title != null) Text(title!, style: kTextMainStyleLarge),
              if (title != null) SizedBox(height: kPaddingMiddleSize),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
