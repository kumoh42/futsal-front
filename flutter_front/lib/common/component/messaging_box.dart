import 'package:flutter/material.dart';
import 'package:flutter_front/common/styles/styles.dart';
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
      borderRadius: const BorderRadius.all(Radius.circular(kBorderRadiusSize)),
      child: AnimatedContainer(
        width: controller.isHorizontalExpanded ? 400 : kNavigationRailSize,
        height: controller.isVerticalExpanded ? 500 : 70,
        duration: controller.duration,
        curve: Curves.fastEaseInToSlowEaseOut,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(kBorderRadiusSize),
          ),
          color: widget.backgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (controller.isVerticalExpanding)
              _TitleBar(widget.title, widget.bodyTextStyle, controller),
            if (controller.isVerticalExpanded && widget.child != null)
              Expanded(child: SingleChildScrollView(child: widget.child!)),
            controller.isHorizontalExpanded
                ? _MessageTextFormField(
                    controller,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: kPaddingMiddleSize),
        Expanded(
          child: Text(
            title,
            style: textStyle,
          ),
        ),
        IconButton(
          icon: Icon(Icons.message, color: textStyle?.color),
          onPressed: () => controller.show(title),
        ),
        const SizedBox(width: kPaddingSmallSize + kPaddingMiniSize),
      ],
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
      padding: const EdgeInsets.symmetric(vertical: kPaddingSmallSize),
      child: Row(
        children: [
          const SizedBox(width: kPaddingMiddleSize),
          Expanded(child: Text(title, style: textStyle)),
          const SizedBox(width: kPaddingSmallSize),
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
  final TextStyle? bodyTextStyle;
  final Color? textFieldColor;
  final TextStyle? textFiledTextStyle;

  const _MessageTextFormField(
    this.controller,
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
          child: TextFormField(
            controller: controller.messageController,
            decoration: InputDecoration(
              filled: true,
              fillColor: controller.isOpened ? textFieldColor : null,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(kBorderRadiusSize),
                  bottomRight: Radius.circular(kBorderRadiusSize),
                ),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: kPaddingSmallSize,
                horizontal: kPaddingMiddleSize,
              ).copyWith(right: kPaddingLargeSize + kPaddingMiniSize),
              enabled: controller.isOpened,
            ),
            minLines: 1,
            maxLines: 5,
            style: controller.isVerticalExpanded
                ? textFiledTextStyle
                : bodyTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(kPaddingMiniSize),
          child: controller.isSending
              ? const CircularProgressIndicator()
              : IconButton(
                  icon: Icon(
                    Icons.send,
                    color: controller.isOpened
                        ? textFiledTextStyle?.color
                        : bodyTextStyle?.color,
                  ),
                  onPressed: controller.send,
                ),
        ),
      ],
    );
  }
}

enum MessagingBoxState {
  close,
  horizontalExpend,
  verticalExpend,
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
  final Duration _duration30 = const Duration(milliseconds: 30);
  final Duration _duration470 = const Duration(milliseconds: 470);
  final Future Function(String message) onSendClicked;

  MessagingBoxState get state => _state;
  MessagingBoxState _state = MessagingBoxState.close;

  bool get isClosed => state >= MessagingBoxState.close;

  bool get isHorizontalExpanded => state >= MessagingBoxState.horizontalExpend;

  bool get isVerticalExpanded => state >= MessagingBoxState.verticalExpend;

  bool get isVerticalExpanding => state >= MessagingBoxState.verticalExpanding;

  bool get isOpened => state >= MessagingBoxState.open;

  bool get isSending => state >= MessagingBoxState.send;

  final TextEditingController messageController = TextEditingController();

  MessagingBoxController({required this.onSendClicked});

  void show(String title) async {
    messageController.text = title;
    await _changState(MessagingBoxState.horizontalExpend, duration);
    messageController.clear();
    await _changState(MessagingBoxState.verticalExpend, _duration30);
    await _changState(MessagingBoxState.verticalExpanding, _duration470);
    await _changState(MessagingBoxState.open, const Duration());
  }

  void close() async {
    await _changState(MessagingBoxState.close, const Duration());
  }

  void send() async {
    await _changState(MessagingBoxState.send, const Duration(seconds: 1));
    await onSendClicked(messageController.text);
    messageController.clear();
    close();
  }

  Future _changState(MessagingBoxState state, Duration duration) async {
    _state = state;
    notifyListeners();
    await Future.delayed(duration);
  }
}
