import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/sizes.dart';
import 'package:flutter_front/common/utils/validation_util.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingBox extends ConsumerStatefulWidget {
  final String title;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final TextStyle? bodyTextStyle;
  final Color? textFieldColor;
  final TextStyle? textFiledTextStyle;
  final Widget? child;
  late final ChangeNotifierProvider<MessagingBoxController> provider;

  MessagingBox({
    Key? key,
    required MessagingBoxController controller,
    required this.title,
    this.width,
    this.height,
    this.backgroundColor,
    this.bodyTextStyle,
    this.textFieldColor,
    this.textFiledTextStyle,
    this.child,
  }) : super(key: key) {
    provider = ChangeNotifierProvider((ref) => controller);
  }

  @override
  ConsumerState<MessagingBox> createState() => _MessagingBoxState();
}

class _MessagingBoxState extends ConsumerState<MessagingBox> {
  late MessagingBoxController controller;

  @override
  Widget build(BuildContext context) {
    controller = ref.watch(widget.provider);
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadiusSize)),
      child: AnimatedContainer(
        width: controller.isHorizontalExpanded ? 400 : 70,
        height: controller.isVerticalExpanded ? 461 : 70,
        duration: controller.duration,
        curve: Curves.fastEaseInToSlowEaseOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(kBorderRadiusSize),
          ),
          color: widget.backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isVerticalExpanding)
              _TitleBar(widget.title, widget.bodyTextStyle, controller),
            if (controller.isVerticalExpanded && widget.child != null)
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kPaddingMiddleSize,
                  ),
                  child: SingleChildScrollView(child: widget.child!),
                ),
              ),
            controller.isHorizontalExpanded
                ? _MessageTextFormField(
                    controller,
                    widget.backgroundColor,
                    widget.bodyTextStyle,
                    widget.textFieldColor,
                    widget.textFiledTextStyle,
                  )
                : _DefaultWidget(
                    controller,
                    widget.bodyTextStyle,
                    widget.title,
                  ),
          ],
        ),
      ),
    );
  }
}

class _DefaultWidget extends StatelessWidget {
  final MessagingBoxController controller;
  final String title;
  final TextStyle? textStyle;

  const _DefaultWidget(
    this.controller,
    this.textStyle,
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.open(title),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
/*          SizedBox(width: kPaddingMiddleSize),
          Expanded(
            child: Text(
              title,
              style: textStyle,
            ),
          ),*/
          Icon(Icons.message, color: textStyle?.color),
//          SizedBox(width: kPaddingSmallSize + kPaddingMiniSize),
        ],
      ),
    );
  }
}

class _TitleBar extends StatelessWidget {
  final MessagingBoxController controller;
  final TextStyle? textStyle;
  final String title;

  const _TitleBar(this.title, this.textStyle, this.controller, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPaddingSmallSize),
      child: Row(
        children: [
          SizedBox(width: kPaddingMiddleSize),
          Expanded(child: Text(title, style: textStyle)),
          SizedBox(width: kPaddingSmallSize),
          IconButton(
            onPressed: controller.close,
            icon: Icon(Icons.close, color: textStyle?.color),
          ),
        ],
      ),
    );
  }
}

class _MessageTextFormField extends StatelessWidget {
  final MessagingBoxController controller;
  final Color? backgroundColor;
  final TextStyle? bodyTextStyle;
  final Color? textFieldColor;
  final TextStyle? textFiledTextStyle;

  const _MessageTextFormField(
    this.controller,
    this.backgroundColor,
    this.bodyTextStyle,
    this.textFieldColor,
    this.textFiledTextStyle, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: controller.isVerticalExpanded
          ? Alignment.bottomRight
          : Alignment.centerRight,
      children: [
        SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kBorderRadiusSize),
                bottomRight: Radius.circular(kBorderRadiusSize),
              ),
              color: controller.isOpened ? backgroundColor : null,
            ),
            child: Form(
              key: controller.sendKey,
              child: Column(
                children: [
                  if (controller.isVerticalExpanding)
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: kPaddingMiddleSize),
                      child: Column(
                        children: [
                          Divider(color: textFieldColor),
                          _CustomTextField(
                            controller: controller,
                            bodyTextStyle: bodyTextStyle,
                            textFieldColor: textFieldColor,
                            textFiledTextStyle: textFiledTextStyle,
                            labelText: 'email',
                            prefixIcon: Icons.email,
                            textController: controller.emailController,
                            validator: validateEmail,
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: kPaddingMiddleSize),
                    child: _CustomTextField(
                      controller: controller,
                      bodyTextStyle: bodyTextStyle,
                      textFieldColor: controller.isVerticalExpanding
                          ? textFieldColor
                          : backgroundColor,
                      textFiledTextStyle: controller.isVerticalExpanding
                          ? textFiledTextStyle
                          : bodyTextStyle,
                      labelText: 'message',
                      prefixIcon: Icons.message,
                      minLine: controller.isVerticalExpanding ? 10 : 1,
                      maxLine: 11,
                      textController: controller.messageController,
                    ),
                  ),
                  if (controller.isVerticalExpanding)
                    SizedBox(height: kPaddingMiddleSize),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(kPaddingSmallSize).copyWith(
            bottom: kPaddingSmallSize,
          ),
          child: controller.isSending
              ? const CircularProgressIndicator()
              : IconButton(
                  icon: Icon(
                    Icons.send,
                    color: controller.isVerticalExpanding
                        ? backgroundColor
                        : bodyTextStyle?.color,
                  ),
                  onPressed: controller.send,
                ),
        ),
      ],
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final MessagingBoxController controller;
  final TextEditingController textController;
  final TextStyle? bodyTextStyle;
  final Color? textFieldColor;
  final TextStyle? textFiledTextStyle;

  final String labelText;
  final IconData prefixIcon;
  final int minLine;
  final int maxLine;

  final String? Function(String?)? validator;

  const _CustomTextField({
    Key? key,
    required this.controller,
    this.bodyTextStyle,
    this.textFieldColor,
    this.textFiledTextStyle,
    required this.labelText,
    required this.prefixIcon,
    this.minLine = 1,
    this.maxLine = 1,
    this.validator,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (controller.isVerticalExpanding)
          Column(
            children: [
              SizedBox(height: kPaddingSmallSize),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    prefixIcon,
                    size: kIconMiniSize,
                    color: bodyTextStyle?.color,
                  ),
                  SizedBox(width: kPaddingSmallSize),
                  Text(
                    labelText,
                    style: textFiledTextStyle?.copyWith(
                      color: bodyTextStyle?.color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: kPaddingSmallSize),
            ],
          ),
        TextFormField(
          controller: textController,
          minLines: minLine,
          maxLines: maxLine,
          validator: validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: textFieldColor,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              vertical: kPaddingSmallSize,
              horizontal: kPaddingMiniSize,
            ),
            enabled: controller.isOpened,
          ),
          style: controller.isVerticalExpanded
              ? textFiledTextStyle
              : bodyTextStyle,
        ),
      ],
    );
  }
}

enum MessagingBoxState {
  close,
  horizontalExpand,
  horizontalExpanding,
  verticalExpand,
  verticalExpanding,
  open,
  send;
}

extension _EnumComparisonOperators<T extends Enum> on T {
  bool operator <(T other) {
    return index < other.index;
  }

  bool operator <=(T other) {
    return index <= other.index;
  }

  bool operator >(T other) {
    return index > other.index;
  }

  bool operator >=(T other) {
    return index >= other.index;
  }
}

class MessagingBoxController extends ChangeNotifier {
  final Duration duration = const Duration(milliseconds: 500);
  final Duration _duration250 = const Duration(milliseconds: 250);
  final Future Function(String email, String message) onSendClicked;

  MessagingBoxState get state => _state;
  MessagingBoxState _state = MessagingBoxState.close;

  bool get isClosed => state >= MessagingBoxState.close;

  bool get isHorizontalExpanded => state >= MessagingBoxState.horizontalExpand;

  bool get isHorizontalExpanding =>
      state >= MessagingBoxState.horizontalExpanding;

  bool get isVerticalExpanded => state >= MessagingBoxState.verticalExpand;

  bool get isVerticalExpanding => state >= MessagingBoxState.verticalExpanding;

  bool get isOpened => state >= MessagingBoxState.open;

  bool get isSending => state >= MessagingBoxState.send;

  final TextEditingController messageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final sendKey = GlobalKey<FormState>();

  MessagingBoxController({required this.onSendClicked});

  void open(String title) async {
    await _changState(MessagingBoxState.horizontalExpand, _duration250);
    messageController.text = title;
    await _changState(MessagingBoxState.horizontalExpanding, _duration250);
    messageController.clear();
    await _changState(MessagingBoxState.verticalExpand, _duration250);
    await _changState(MessagingBoxState.verticalExpanding, _duration250);
    await _changState(MessagingBoxState.open, const Duration());
  }

  void close() async {
    await _changState(MessagingBoxState.close, const Duration());
  }

  void send() async {
    if (!(sendKey.currentState?.validate() ?? false)) return;
    await _changState(MessagingBoxState.send, const Duration(seconds: 1));
    await onSendClicked(emailController.text, messageController.text);
    emailController.clear();
    messageController.clear();
    close();
  }

  Future _changState(MessagingBoxState state, Duration duration) async {
    _state = state;
    notifyListeners();
    await Future.delayed(duration);
  }
}
