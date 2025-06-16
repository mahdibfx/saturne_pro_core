import 'package:flutter/material.dart';
import 'package:saturne_pro_core/src/assets/assets.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;

  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.onChanged,
    this.onSubmitted,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late FocusNode _focusNode;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    _focusNode = FocusNode();
    _textEditingController = TextEditingController();
    _focusNode.addListener(() {
      setState(() {});
    });
    _textEditingController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastLinearToSlowEaseIn,
      padding: EdgeInsets.symmetric(
        horizontal: ds.spacing.l + 1.75 * ds.spacing.xs,
        vertical: ds.spacing.l,
      ),
      decoration: BoxDecoration(
        color: ds.colors.primary.shade900.withValues(alpha: .03),
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(
          color:
              _focusNode.hasFocus
                  ? ds.colors.primary.shade500.withValues(alpha: .4)
                  : ds.colors.primary.shade900.withValues(alpha: .05),
          width: _focusNode.hasFocus ? .6 : .2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: ds.spacing.l,
              children: [
                Icon(
                  SaturneProIcons.search,
                  color: ds.colors.primary.shade800,
                  size: ds.spacing.l + ds.spacing.xs,
                ),
                SizedBox(
                  height: ds.spacing.l + 1.8 * ds.spacing.xs,
                  child: VerticalDivider(
                    thickness: 1.0,
                    width: 1.0,
                    color: ds.colors.primary.shade500.withValues(alpha: .1),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: ds.typography.bodyL.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ds.colors.primary.shade900,
                    ),
                    cursorColor: ds.colors.primary.shade500,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                      hintFadeDuration: const Duration(milliseconds: 200),
                      hintStyle: ds.typography.bodyL.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ds.colors.primary.shade800.withValues(alpha: .3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Semantics(
            button: true,
            label: 'Clear search',
            child: GestureDetector(
              onTap: () {
                _textEditingController.clear();
              },
              child: IgnorePointer(
                ignoring: _textEditingController.text.isEmpty,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastLinearToSlowEaseIn,
                  opacity: _textEditingController.text.isNotEmpty ? 1 : .0,
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                    scale: _textEditingController.text.isNotEmpty ? 1 : .9,
                    child: Container(
                      width: ds.spacing.l + .5 * ds.spacing.s,
                      height: ds.spacing.l + .5 * ds.spacing.s,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ds.colors.primary.shade500,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        SaturneProIcons.times,
                        color: Colors.white,
                        size: ds.spacing.l,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
