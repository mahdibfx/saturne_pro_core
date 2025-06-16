import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';

class Previewer extends StatefulWidget {
  /// Title of the preview component
  final String title;

  /// Description text that explains the component
  final String description;

  /// The widget to be displayed in the preview tab
  final Widget child;

  /// Code snippet to be displayed in the code tab
  final String codeSnippet;

  const Previewer({
    super.key,
    required this.title,
    required this.description,
    required this.child,
    required this.codeSnippet,
  });

  @override
  State<Previewer> createState() => _PreviewerState();
}

class _PreviewerState extends State<Previewer> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return Container(
      decoration: BoxDecoration(
        borderRadius: ds.borderRadii.radiusL,
        border: Border.all(color: Color(0xffE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and description
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ds.spacing.l),
              topRight: Radius.circular(ds.spacing.l),
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
              ),
              child: Padding(
                padding: EdgeInsets.all(.5 * ds.spacing.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: ds.typography.displayL.copyWith(
                        fontSize: 2.22.h,
                        color: ds.colors.primary.shade900,
                      ),
                    ),
                    SizedBox(height: .3 * ds.spacing.s),
                    Text(
                      widget.description,
                      style: ds.typography.headingXL.copyWith(
                        fontSize: 1.6.h,
                        color: Color(0xff4b5563),
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Tab bar
          Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
            ),
            child: Row(
              children: [_buildTab('Preview', 0, ds), _buildTab('Code', 1, ds)],
            ),
          ),

          // Tab content
          _selectedTabIndex == 0
              ? Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: EdgeInsets.all(ds.spacing.l),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: constraints.maxWidth,
                          child: Center(child: widget.child),
                        ),
                      ),
                    );
                  },
                ),
              )
              : Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          width: constraints.maxWidth,
                          margin: EdgeInsets.all(ds.spacing.xl),
                          decoration: BoxDecoration(
                            color: ds.colors.shade.shade50,
                            borderRadius: ds.borderRadii.radiusM,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(ds.spacing.l),
                            child: SelectableText(
                              widget.codeSnippet,
                              style: ds.typography.headingM.copyWith(
                                color: ds.colors.shade.shade900,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildTab(String label, int index, AppDesignSystem ds) {
    final isSelected = _selectedTabIndex == index;

    return InkWell(
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: .6 * ds.spacing.xl,
          vertical: .7 * ds.spacing.l,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color:
                  isSelected ? ds.colors.primary.shade500 : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          label,
          style: ds.typography.headingXL.copyWith(
            fontSize: 1.5.h,
            color:
                isSelected
                    ? ds.colors.primary.shade700
                    : ds.colors.shade.shade600,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
