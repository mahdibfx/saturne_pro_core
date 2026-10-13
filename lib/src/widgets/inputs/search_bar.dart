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
      height: 12 * ds.spacing.xs,
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.l),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1000),
        border: Border.all(
          color:
              _focusNode.hasFocus
                  ? ds.colors.primary.shade500
                  : ds.colors.shade.shade200,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: ds.spacing.s,
              children: [
                Icon(
                  SaturneProIcons.search,
                  color: ds.colors.shade.shade400,
                  size: 5 * ds.spacing.xs,
                ),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    focusNode: _focusNode,
                    onChanged: widget.onChanged,
                    onSubmitted: widget.onSubmitted,
                    style: ds.typography.bodyS.copyWith(
                      fontWeight: FontWeight.w400,
                      color: ds.colors.primary.shade900,
                    ),
                    cursorColor: ds.colors.primary.shade500,
                    decoration: InputDecoration.collapsed(
                      hintText: widget.hintText,
                      hintFadeDuration: const Duration(milliseconds: 200),
                      hintStyle: ds.typography.bodyS.copyWith(
                        fontWeight: FontWeight.w400,
                        color: ds.colors.shade.shade400,
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
