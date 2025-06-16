import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/indicators/loading_indicator.dart';

class LoadingOverlay extends StatefulWidget {
  final bool isShown;
  final Widget child;
  final bool withLoadingIndicator;
  final Function()? onBarrierTapped;

  const LoadingOverlay({
    super.key,
    required this.isShown,
    this.withLoadingIndicator = true,
    this.onBarrierTapped,
    required this.child,
  });

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {
  final OverlayPortalController controller = OverlayPortalController();
  static const _animationDuration = Duration(milliseconds: 600);
  static const _animationCurve = Curves.fastLinearToSlowEaseIn;
  bool _isLoadingIndicatorShown = false;
  bool _isBlurryOverlayShown = false;

  @override
  void initState() {
    _animateWidgets();
    super.initState();
  }

  void _animateWidgets({bool reverse = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.isShown) controller.show();
      await Future.delayed(const Duration(milliseconds: 130), () {
        setState(() {
          if (!reverse) {
            _isBlurryOverlayShown = widget.isShown;
          } else {
            _isLoadingIndicatorShown = widget.isShown;
          }
        });
      });
      await Future.delayed(const Duration(milliseconds: 140), () {
        setState(() {
          if (!reverse) {
            _isLoadingIndicatorShown = widget.isShown;
          } else {
            _isBlurryOverlayShown = widget.isShown;
          }
        });
      });
      if (!widget.isShown) controller.hide();
    });
  }

  @override
  void didUpdateWidget(covariant LoadingOverlay oldWidget) {
    _animateWidgets(reverse: oldWidget.isShown);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return OverlayPortal(
      controller: controller,
      overlayChildBuilder:
          (context) => IgnorePointer(
            ignoring: !widget.isShown,
            child: Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    curve: _animationCurve,
                    opacity: _isBlurryOverlayShown ? 1.0 : .0,
                    child: GestureDetector(
                      onTap: widget.onBarrierTapped,
                      child: Container(
                        width: 100.dw,
                        height: 100.dh,
                        color: ds.colors.shade.shade800.withValues(alpha: .6),
                      ),
                    ),
                  ),
                ),
                RepaintBoundary(
                  child: AnimatedOpacity(
                    duration: _animationDuration,
                    curve: _animationCurve,
                    opacity:
                        _isLoadingIndicatorShown && widget.withLoadingIndicator
                            ? 1.0
                            : .0,
                    child: AnimatedScale(
                      duration: _animationDuration,
                      curve: _animationCurve,
                      scale: _isLoadingIndicatorShown ? 1.0 : 1.08,
                      child: FittedBox(
                        child: Container(
                          padding: EdgeInsets.all(2 * ds.spacing.xl),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: ds.borderRadii.radiusM,
                            boxShadow: [
                              BoxShadow(
                                color: ds.colors.shade.shade900.withValues(
                                  alpha: .08,
                                ),
                                blurRadius: 30,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Transform.scale(
                            scale: 1.4,
                            child: const LoadingIndicator(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      child: widget.child,
    );
  }
}
