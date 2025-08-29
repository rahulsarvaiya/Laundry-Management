import 'package:flutter/material.dart';

class CustomMarqueeWidget extends StatefulWidget {
  final Widget? child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;
  final bool showShadow;
  final EdgeInsetsGeometry? padding;

  const CustomMarqueeWidget({
    super.key,
    @required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(seconds: 3),
    this.backDuration = const Duration(seconds: 1),
    this.pauseDuration = const Duration(seconds: 1),
    this.showShadow = true,
    this.padding,
  });

  @override
  State<CustomMarqueeWidget> createState() => _CustomMarqueeWidgetState();
}

class _CustomMarqueeWidgetState extends State<CustomMarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 0.0);
    WidgetsBinding.instance.addPostFrameCallback(scrollMarquee);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.showShadow
        ? ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.transparent,
            Colors.black,
            Colors.black,
            Colors.transparent
          ],
          stops: [0.0, 0.1, 0.9, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: SingleChildScrollView(
        padding: widget.padding ?? EdgeInsets.zero,
        scrollDirection: widget.direction,
        controller: scrollController,
        child: widget.child,
      ),
    )
        : SingleChildScrollView(
      scrollDirection: widget.direction,
      controller: scrollController,
      child: widget.child,
    );
  }

  void scrollMarquee(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.easeOut,
        );
      }

      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}
