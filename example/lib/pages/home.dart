import 'package:example/widgets/previewer.dart';
import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isOverlayShown = false;
  String _searchQuery = '';

  void _toggleOverlay() {
    setState(() {
      _isOverlayShown = !_isOverlayShown;
    });
  }

  void _updateSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isShown: _isOverlayShown,
        onBarrierTapped: _toggleOverlay,
        child: SizedBox(
          height: 100.dh,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(ds),
                Expanded(child: _buildWidgetGrid(ds)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppDesignSystem ds) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal:
                constraints.maxWidth > 600 ? 8 * ds.spacing.xl : ds.spacing.l,
            vertical: ds.spacing.l,
          ),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
          ),
          child:
              (constraints.maxWidth > 600)
                  ? Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          text: 'Saturne Pro Core Components',
                          style: CustomTextStyle.headingL,
                          color: ds.colors.primary.shade900,
                        ),
                      ),
                      SizedBox(width: ds.spacing.l),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ds.colors.primary.shade100,
                          borderRadius: ds.borderRadii.radiusS,
                        ),
                        child: TextField(
                          onChanged: _updateSearchQuery,
                          decoration: InputDecoration(
                            hintText: 'Search widgets...',
                            prefixIcon: Icon(
                              SaturneProIcons.search,
                              size: 16,
                              color: ds.colors.primary.shade500,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: ds.spacing.xs,
                    children: [
                      CustomText(
                        text: 'Saturne Pro Core Components',
                        style: CustomTextStyle.headingL,
                        color: ds.colors.primary.shade900,
                      ),
                      SizedBox(width: ds.spacing.l),
                      Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          color: ds.colors.primary.shade100,
                          borderRadius: ds.borderRadii.radiusM,
                        ),
                        child: TextField(
                          onChanged: _updateSearchQuery,
                          decoration: InputDecoration(
                            hintText: 'Search widgets...',
                            prefixIcon: Icon(
                              SaturneProIcons.search,
                              size: 16,
                              color: ds.colors.primary.shade500,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
        );
      },
    );
  }

  Widget _buildWidgetGrid(AppDesignSystem ds) {
    // Define all previewer widgets
    final List<Widget> allPreviewers = [
      _buildCustomTextPreviewer(ds),
      _buildUnderlinedTextPreviewer(ds),
      _buildCustomGapPreviewer(ds),
      _buildCustomDividerPreviewer(ds),
      _buildLoadingIndicatorPreviewer(ds),
      _buildCustomPageIndicatorPreviewer(ds),
      _buildButtonPreviewer(ds),
      _buildPillButtonPreviewer(ds),
      _buildLoadingOverlayPreviewer(ds),
      _buildCustomSwitchPreviewer(ds),
      _buildCustomCheckBoxPreviewer(ds),
      _buildCustomRadioButtonPreviewer(ds),
      _buildSearchBarPreviewer(ds),
      _buildCustomTextFieldPreviewer(ds),
      _buildCustomTabBarPreviewer(ds),
      _buildUploadFileContainerPreviewer(ds),
      _buildOtpTextFieldPreviewer(ds),
      _buildCustomCalendarPreviewer(ds),
      _buildSectionHeaderPreviewer(ds),
      _buildContactSupportCardPreviewer(ds),
      _buildCustomBottomNavBarPreviewer(ds),
      _buildCustomTooltipPreviewer(ds),
      _buildCustomHeaderPreviewer(ds),
      // Add other previewers here
    ];

    // Filter previewers based on search query
    final List<Widget> filteredPreviewers =
        _searchQuery.isEmpty
            ? allPreviewers
            : allPreviewers.where((widget) {
              if (widget is Previewer) {
                return widget.title.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                );
              }
              return false;
            }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsets.only(
                left:
                    constraints.maxWidth > 600
                        ? 8 * ds.spacing.xl
                        : ds.spacing.l,
                right:
                    constraints.maxWidth > 600
                        ? 8 * ds.spacing.xl
                        : ds.spacing.l,
                top: ds.spacing.l,
                bottom: ds.spacing.l,
              ),
              child: CustomText(
                text:
                    'Showing ${filteredPreviewers.length} of ${allPreviewers.length} widgets',
                style: CustomTextStyle.bodyM,
                color: ds.colors.primary.shade700.withValues(alpha: .7),
              ),
            );
          },
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Determine the number of columns based on screen width
              int crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;

              return GridView.count(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: ds.spacing.xl,
                mainAxisSpacing: ds.spacing.xl,
                childAspectRatio:
                    crossAxisCount == 1
                        ? 0.8
                        : 1.2, // Adjust aspect ratio for mobile
                padding: EdgeInsets.only(
                  left:
                      constraints.maxWidth > 600
                          ? 8 * ds.spacing.xl
                          : ds.spacing.l,
                  right:
                      constraints.maxWidth > 600
                          ? 8 * ds.spacing.xl
                          : ds.spacing.l,
                  top: 0,
                  bottom: 3 * ds.spacing.xl,
                ),
                children: filteredPreviewers,
              );
            },
          ),
        ),
      ],
    );
  }

  // Helper methods to create each previewer widget
  Widget _buildCustomTextPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomText',
      description: 'A text component with various styles',
      codeSnippet: '''
      CustomText(
        text: 'This is a CustomText widget',
        style: CustomTextStyle.headingXL,
        color: ds.colors.primary.shade700,
        fontWeight: FontWeight.bold,
        maxLines: 2,
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'This is a CustomText widget',
            style: CustomTextStyle.headingXL,
            color: ds.colors.primary.shade700,
            fontWeight: FontWeight.bold,
            maxLines: 2,
          ),
          SizedBox(height: ds.spacing.l),
          CustomText(text: 'DisplayXL Style', style: CustomTextStyle.displayXL),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'DisplayL Style', style: CustomTextStyle.displayL),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'HeadingXL Style', style: CustomTextStyle.headingXL),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'HeadingL Style', style: CustomTextStyle.headingL),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'HeadingM Style', style: CustomTextStyle.headingM),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'BodyL Style', style: CustomTextStyle.bodyL),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'BodyM Style', style: CustomTextStyle.bodyM),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'BodyS Style', style: CustomTextStyle.bodyS),
          SizedBox(height: ds.spacing.s),
          CustomText(text: 'CaptionM Style', style: CustomTextStyle.captionM),
        ],
      ),
    );
  }

  Widget _buildUnderlinedTextPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'UnderlinedText',
      description: 'A text component with custom underline styling',
      codeSnippet: '''
      UnderlinedText(
        textLines: ['This is an UnderlinedText widget'],
        lineColor: ds.colors.primary.shade500,
        lineThickness: 3.0,
        style: CustomTextStyle.headingM,
        color: ds.colors.primary.shade900,
        fontWeight: FontWeight.bold,
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          UnderlinedText(
            textLines: [
              'Programmer la répétition pour',
              'cette coursedkjsfhs',
              'cetjsfhs',
            ],
            lineColor: ds.colors.secondary.shade500.withValues(alpha: .2),
            lineThickness: 12.0,
            style: CustomTextStyle.headingM,
            color: ds.colors.primary.shade900,
            fontWeight: FontWeight.bold,
          ),
          UnderlinedText(
            textLines: ['Télétransmission'],
            lineColor: ds.colors.secondary.shade500.withValues(alpha: .2),
            style: CustomTextStyle.displayL,
            color: ds.colors.primary.shade500,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomGapPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomGap',
      description: 'A flexible spacing component with predefined sizes',
      codeSnippet: '''
      // Using predefined gap sizes
      CustomGap(gapSize: GapSize.xs),
      CustomGap(gapSize: GapSize.s),
      CustomGap(gapSize: GapSize.l),
      CustomGap(gapSize: GapSize.xl),
      
      // Using custom gap size
      CustomGap(customSizeValue: 32),
      
      // Using as a sliver gap
      CustomGap(gapSize: GapSize.l, isSliverGap: true),
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: ds.colors.primary.shade100,
            padding: EdgeInsets.all(ds.spacing.s),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
                CustomGap(gapSize: GapSize.xs),
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          CustomText(text: 'GapSize.xs', style: CustomTextStyle.bodyS),

          CustomGap(gapSize: GapSize.s),

          Container(
            color: ds.colors.primary.shade100,
            padding: EdgeInsets.all(ds.spacing.s),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
                CustomGap(gapSize: GapSize.s),
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          CustomText(text: 'GapSize.s', style: CustomTextStyle.bodyS),

          CustomGap(gapSize: GapSize.s),

          Container(
            color: ds.colors.primary.shade100,
            padding: EdgeInsets.all(ds.spacing.s),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
                CustomGap(gapSize: GapSize.l),
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          CustomText(text: 'GapSize.l', style: CustomTextStyle.bodyS),

          CustomGap(gapSize: GapSize.s),

          Container(
            color: ds.colors.primary.shade100,
            padding: EdgeInsets.all(ds.spacing.s),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
                CustomGap(gapSize: GapSize.xl),
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          CustomText(text: 'GapSize.xl', style: CustomTextStyle.bodyS),

          CustomGap(gapSize: GapSize.s),

          Container(
            color: ds.colors.primary.shade100,
            padding: EdgeInsets.all(ds.spacing.s),
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
                CustomGap(customSizeValue: 32),
                Container(
                  width: 20,
                  height: 20,
                  color: ds.colors.primary.shade500,
                ),
              ],
            ),
          ),
          CustomText(text: 'customSizeValue: 32', style: CustomTextStyle.bodyS),
        ],
      ),
    );
  }

  Widget _buildCustomDividerPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomDivider',
      description:
          'A divider component with optional label and trailing widget',
      codeSnippet: '''
      // Basic divider
      CustomDivider(),
      
      // Divider with label
      CustomDivider(label: 'Section Title'),
      
      // Divider with trailing widget
      CustomDivider(
        label: 'With Icon',
        trailingWidget: Icon(
          Icons.info_outline,
          size: 16,
          color: ds.colors.primary.shade500,
        ),
      ),
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          CustomText(text: 'Basic Divider', style: CustomTextStyle.captionM),
          CustomDivider(),

          CustomText(
            text: 'Divider with Label',
            style: CustomTextStyle.captionM,
          ),
          CustomDivider(label: 'Details de lot'),

          CustomText(
            text: 'Divider with Label and Icon',
            style: CustomTextStyle.captionM,
          ),
          CustomDivider(
            label: 'Informations de prescripteur',
            trailingWidget: Icon(
              SaturneProIcons.pen,
              size: 16,
              color: ds.colors.primary.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingIndicatorPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'LoadingIndicator',
      description: 'An animated loading indicator with fading dots',
      codeSnippet: '''
      // Basic loading indicator
      LoadingIndicator()
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Default Loading Indicator',
            style: CustomTextStyle.captionM,
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(ds.spacing.l),
            decoration: BoxDecoration(
              color: ds.colors.primary.shade100,
              borderRadius: ds.borderRadii.radiusM,
            ),
            child: const LoadingIndicator(),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomPageIndicatorPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomPageIndicator',
      description: 'A page indicator for multi-page content',
      codeSnippet: '''
      // Basic page indicator
      CustomPageIndicator(
        pagesCount: 5,
        activeIndex: 2,
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Page Indicator Examples',
            style: CustomTextStyle.captionM,
          ),
          Column(
            spacing: ds.spacing.l,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Active page: 0',
                    style: CustomTextStyle.bodyS,
                  ),
                ],
              ),
              CustomPageIndicator(pagesCount: 5, activeIndex: 0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Active page: 2',
                    style: CustomTextStyle.bodyS,
                  ),
                ],
              ),
              CustomPageIndicator(pagesCount: 5, activeIndex: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Active page: 4',
                    style: CustomTextStyle.bodyS,
                  ),
                ],
              ),
              CustomPageIndicator(pagesCount: 5, activeIndex: 4),
            ],
          ),
        ],
      ),
    );
  }

  // Button previewer
  Widget _buildButtonPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'Button',
      description: 'A customizable button with different styles',
      codeSnippet: '''
      Button.filled(
        label: 'Filled Button',
        backgroundColor: ds.gradients.primary,
        labelColor: Colors.white,
        onTap: () {},
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.l,
        children: [
          Button.filled(
            label: 'Filled Button',
            backgroundColor: ds.gradients.primary,
            labelColor: Colors.white,
            onTap: () {},
          ),
          Button.outlined(
            label: 'Outlined Button',
            labelColor: ds.colors.primary.shade700,
            onTap: () {},
          ),
          Button.plain(
            label: 'Plain Button',
            labelColor: ds.colors.primary.shade700,
            onTap: () {},
            expand: false,
          ),
          Button.filled(
            label: 'Disabled Button',
            backgroundColor: ds.gradients.primary,
            labelColor: Colors.white,
            onTap: () {},
            isDisabled: true,
          ),
        ],
      ),
    );
  }

  // PillButton previewer
  Widget _buildPillButtonPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'PillButton',
      description: 'A button with pill shape in different sizes',
      codeSnippet: '''
      PillButton(
        label: 'Pill Button',
        color: ds.colors.primary.shade700,
        onTap: () {},
        size: PillButtonSize.normal,
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.l,
        children: [
          PillButton(
            label: 'Normal Size',
            color: ds.colors.primary.shade700,
            onTap: () {},
            size: PillButtonSize.normal,
          ),
          PillButton(
            label: 'Tiny Size',
            color: ds.colors.secondary.shade500,
            onTap: () {},
            size: PillButtonSize.tiny,
          ),
          Row(
            spacing: ds.spacing.l,
            children: [
              PillButton(
                label: 'Primary',
                color: ds.colors.primary.shade700,
                onTap: () {},
              ),
              PillButton(
                label: 'Secondary',
                color: ds.colors.secondary.shade500,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // LoadingOverlay previewer
  Widget _buildLoadingOverlayPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'LoadingOverlay',
      description: 'An overlay with loading indicator',
      codeSnippet: '''
      LoadingOverlay(
        isShown: _isOverlayShown,
        onBarrierTapped: () {},
        child: YourWidget(),
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.l,
        children: [
          CustomText(
            text: 'Click the button to toggle overlay',
            style: CustomTextStyle.bodyL,
          ),
          Button.outlined(
            label: 'Toggle Loading Overlay',
            labelColor: ds.colors.secondary.shade500,
            onTap: _toggleOverlay,
            expand: false,
          ),
          SizedBox(height: ds.spacing.s),
          CustomText(
            text: 'Note: The overlay is shown at the root level of the app',
            style: CustomTextStyle.bodyM,
            color: ds.colors.primary.shade700.withValues(alpha: .7),
          ),
        ],
      ),
    );
  }

  // CustomSwitch previewer
  Widget _buildCustomSwitchPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomSwitch',
      description:
          'A customizable switch component with enabled/disabled states',
      codeSnippet: '''
      // Basic switch
      CustomSwitch(
        initialValue: true,
        onChanged: (value) {
          // Handle value change
        },
      ),
      
      // Disabled switch
      CustomSwitch(
        initialValue: false,
        onChanged: null,
      ),
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Enabled Switch (On)',
                style: CustomTextStyle.bodyM,
              ),
              CustomSwitch(initialValue: true, onChanged: (value) {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Enabled Switch (Off)',
                style: CustomTextStyle.bodyM,
              ),
              CustomSwitch(initialValue: false, onChanged: (value) {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Disabled Switch (On)',
                style: CustomTextStyle.bodyM,
              ),
              CustomSwitch(initialValue: true, onChanged: null),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Disabled Switch (Off)',
                style: CustomTextStyle.bodyM,
              ),
              CustomSwitch(initialValue: false, onChanged: null),
            ],
          ),
        ],
      ),
    );
  }

  // CustomCheckBox previewer
  Widget _buildCustomCheckBoxPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomCheckBox',
      description: 'A customizable checkbox component',
      codeSnippet: '''
      CustomCheckBox(
        label: 'Checkbox Label',
        value: true,
        onChanged: (value) {
          setState(() {
            // Update state
          });
        },
      )
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.l,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Checked Checkbox',
                style: CustomTextStyle.bodyM,
              ),
              CustomCheckBox(
                checked: true,
                onChanged: (value) {
                  print(
                    'the first check box is ${value ? 'checked' : 'not checked'}',
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Unchecked Checkbox',
                style: CustomTextStyle.bodyM,
              ),
              CustomCheckBox(
                checked: false,
                onChanged: (value) {
                  print(
                    'the second check box is ${value ? 'checked' : 'not checked'}',
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Disabled Checkbox',
                style: CustomTextStyle.bodyM,
              ),
              CustomCheckBox(checked: false),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Circular Checkbox',
                style: CustomTextStyle.bodyM,
              ),
              CustomCheckBox(
                checked: true,
                isCircularShaped: true,
                onChanged: (value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // CustomRadioButton previewer
  Widget _buildCustomRadioButtonPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomRadioButton',
      description:
          'A customizable radio button component with enabled/disabled states',
      codeSnippet: '''
      // Basic radio button
      CustomRadioButton(
        initialChecked: true,
        onChanged: (value) {
          // Handle value change
        },
      ),
      
      // Disabled radio button
      CustomRadioButton(
        initialChecked: false,
        onChanged: null,
      ),
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Enabled Radio Button (Selected)',
                style: CustomTextStyle.bodyM,
              ),
              CustomRadioButton(selected: true, onChanged: (value) {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Enabled Radio Button (Unselected)',
                style: CustomTextStyle.bodyM,
              ),
              CustomRadioButton(selected: false, onChanged: (value) {}),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Disabled Radio Button (Selected)',
                style: CustomTextStyle.bodyM,
              ),
              CustomRadioButton(selected: true, onChanged: null),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: 'Disabled Radio Button (Unselected)',
                style: CustomTextStyle.bodyM,
              ),
              CustomRadioButton(selected: false, onChanged: null),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCalendarPreviewer(AppDesignSystem ds) {
    DateTime? selectedDate;
    List<DateTime> selectedDates = [];
    List<DateTime> selectedRange = [];

    return Previewer(
      title: 'CustomCalendar',
      description:
          'A customizable calendar widget supporting single, range, and multiple date selection',
      codeSnippet: '''
      // Single date selection
      CustomCalendar(
        selectionType: CalendarSelectionType.single,
        initialDate: DateTime.now(),
        onDateSelected: (date) {
          print('Selected date: \$date');
        },
      ),
      
      // Range selection
      CustomCalendar(
        selectionType: CalendarSelectionType.range,
        onDateRangeSelected: (dates) {
          print('Selected range: \$dates');
        },
      ),
      
      // Multiple selection
      CustomCalendar(
        selectionType: CalendarSelectionType.multiple,
        onMultipleDatesSelected: (dates) {
          print('Selected dates: \$dates');
        },
      ),
      ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          // Single Selection Example
          CustomText(
            text: 'Single Date Selection',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w600,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusM,
            ),
            child: CustomCalendar(
              selectionType: CalendarSelectionType.single,
              initialDate: DateTime.now(),
              onDateSelected: (date) {
                selectedDate = date;
                print('Selected date: $date');
              },
            ),
          ),

          // Range Selection Example
          CustomText(
            text: 'Date Range Selection',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w600,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusS,
            ),
            child: CustomCalendar(
              selectionType: CalendarSelectionType.range,
              onDateRangeSelected: (dates) {
                selectedRange = dates;
                print('Selected range: $dates');
              },
            ),
          ),

          // Multiple Selection Example
          CustomText(
            text: 'Multiple Dates Selection',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w600,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusS,
            ),
            child: CustomCalendar(
              selectionType: CalendarSelectionType.multiple,
              onMultipleDatesSelected: (dates) {
                selectedDates = dates;
                print('Selected dates: $dates');
              },
            ),
          ),
        ],
      ),
    );
  }

  // ContactSupportCard previewer
  Widget _buildContactSupportCardPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'ContactSupportCard',
      description:
          'A card component for displaying contact support information with a call-to-action button',
      codeSnippet: '''
        ContactSupportCard(
          contactInfoLabel: 'support@example.com',
          contactInfoContextLabel: 'Need help? Contact us at',
          ctaLabel: 'Contact',
          onCtaPressed: () {
            // Handle contact button press
          },
        )
        ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Contact Support Card Examples',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w500,
          ),
          ContactSupportCard(
            contactInfoLabel: 'support@example.com',
            contactInfoContextLabel: 'Need help? Contact us at',
            ctaLabel: 'Contact',
            onCtaPressed: () {
              // Handle contact button press
            },
          ),
          SizedBox(height: ds.spacing.l),
          ContactSupportCard(
            contactInfoLabel: '+1 (555) 123-4567',
            contactInfoContextLabel: 'Call us at',
            ctaLabel: 'Call',
            onCtaPressed: () {
              // Handle call button press
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCustomBottomNavBarPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomBottomNavBar',
      description:
          'A customizable bottom navigation bar with animated indicators',
      codeSnippet: '''
        CustomBottomNavBar(
          items: [
            BottomNavBarItemData(
              label: 'Home',
              icon: SaturneProIcons.estate,
              isSelected: true,
              onTap: () {},
            ),
            BottomNavBarItemData(
              label: 'Profile',
              icon: SaturneProIcons.user,
              isSelected: false,
              onTap: () {},
            ),
            BottomNavBarItemData(
              label: 'Settings',
              icon: SaturneProIcons.setting,
              isSelected: false,
              onTap: () {},
            ),
          ],
        )
        ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Bottom Navigation Bar Examples',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w500,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusM,
            ),
            child: Column(
              children: [
                CustomBottomNavBar(
                  items: [
                    BottomNavBarItemData(
                      label: 'Home',
                      icon: SaturneProIcons.estate,
                      isSelected: true,
                      onTap: () {},
                    ),
                    BottomNavBarItemData(
                      label: 'Profile',
                      icon: SaturneProIcons.user,
                      isSelected: false,
                      onTap: () {},
                    ),
                    BottomNavBarItemData(
                      label: 'Settings',
                      icon: SaturneProIcons.setting,
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(height: ds.spacing.l),
                CustomBottomNavBar(
                  items: [
                    BottomNavBarItemData(
                      label: 'Home',
                      icon: SaturneProIcons.estate,
                      isSelected: false,
                      onTap: () {},
                    ),
                    BottomNavBarItemData(
                      label: 'Profile',
                      icon: SaturneProIcons.user,
                      isSelected: true,
                      onTap: () {},
                    ),
                    BottomNavBarItemData(
                      label: 'Settings',
                      icon: SaturneProIcons.setting,
                      isSelected: false,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CustomTooltip previewer
  Widget _buildCustomTooltipPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomTooltip',
      description: 'A customizable tooltip widget with consistent styling',
      codeSnippet: '''
        CustomTooltip(
          message: 'This is a tooltip message',
          preferBelow: false,
          verticalOffset: 24,
          child: YourWidget(),
        )
        ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Tooltip Examples',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w500,
          ),
          Row(
            spacing: ds.spacing.xl,
            children: [
              CustomTooltip(
                message: 'Default tooltip',
                child: Container(
                  padding: EdgeInsets.all(ds.spacing.s),
                  decoration: BoxDecoration(
                    color: ds.colors.primary.shade100,
                    borderRadius: ds.borderRadii.radiusS,
                  ),
                  child: Icon(
                    SaturneProIcons.search,
                    color: ds.colors.primary.shade500,
                  ),
                ),
              ),
              CustomTooltip(
                message: 'Tooltip below',
                preferBelow: true,
                child: Container(
                  padding: EdgeInsets.all(ds.spacing.s),
                  decoration: BoxDecoration(
                    color: ds.colors.primary.shade100,
                    borderRadius: ds.borderRadii.radiusS,
                  ),
                  child: Icon(
                    SaturneProIcons.search,
                    color: ds.colors.primary.shade500,
                  ),
                ),
              ),
              CustomTooltip(
                message: 'Custom offset tooltip',
                verticalOffset: 32,
                child: Container(
                  padding: EdgeInsets.all(ds.spacing.s),
                  decoration: BoxDecoration(
                    color: ds.colors.primary.shade100,
                    borderRadius: ds.borderRadii.radiusS,
                  ),
                  child: Icon(
                    SaturneProIcons.search,
                    color: ds.colors.primary.shade500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomHeaderPreviewer(AppDesignSystem ds) {
    return Previewer(
      title: 'CustomHeader',
      description:
          'A customizable header widget that can be used in a CustomScrollView with optional tabs',
      codeSnippet: '''
        // Header with tabs
        CustomHeader.withTabs(
          title: 'Dashboard',
          tabItems: [
            TabItem(label: 'Overview', icon: SaturneProIcons.estate),
            TabItem(label: 'Details', icon: SaturneProIcons.fileContract),
          ],
          onTabChanged: (index) {
            // Handle tab change
          },
        )

        // Header without tabs
        CustomHeader.withoutTabs(
          title: 'Profile',
          smallLabel: 'Welcome back',
        )
        ''',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: ds.spacing.xl,
        children: [
          CustomText(
            text: 'Header with Tabs',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w500,
          ),
          Container(
            height: 204,
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusM,
            ),
            child: CustomScrollView(
              slivers: [
                CustomHeader.withTabs(
                  title: 'Dashboard',
                  smallLabel: 'Overview',
                  tabItems: [
                    TabItem(label: 'Overview', icon: SaturneProIcons.estate),
                    TabItem(
                      label: 'Details',
                      icon: SaturneProIcons.fileContract,
                    ),
                  ],
                  onTabChanged: (index) {
                    print('Tab changed to index: $index');
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: ds.spacing.xl),
          CustomText(
            text: 'Header without Tabs',
            style: CustomTextStyle.bodyM,
            fontWeight: FontWeight.w500,
          ),
          Container(
            height: 160,
            decoration: BoxDecoration(
              border: Border.all(color: ds.colors.primary.shade200),
              borderRadius: ds.borderRadii.radiusM,
            ),
            child: CustomScrollView(
              slivers: [
                CustomHeader.withoutTabs(
                  title: 'Profile',
                  smallLabel: 'Welcome back',
                  trailingWidget: Icon(
                    SaturneProIcons.setting,
                    color: ds.colors.primary.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;
    return Container(
      width: 100.dw,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: 8 * ds.spacing.xl,
        vertical: ds.spacing.xl,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xffE5E7EB))),
      ),
      child: Text(
        'Saturne Pro Widget Book',
        style: ds.typography.displayXL.copyWith(
          fontSize: 2.25.h,
          color: ds.colors.primary.shade900,
        ),
      ),
    );
  }
}

// SearchBar previewer
Widget _buildSearchBarPreviewer(AppDesignSystem ds) {
  return Previewer(
    title: 'CustomSearchBar',
    description: 'A search input component with customizable styling',
    codeSnippet: '''
      CustomSearchBar(
        hintText: 'Search...',
        onChanged: (value) {
          // Handle search input changes
        },
        onSubmit: (value) {
          // Handle search submission
        },
      )
      ''',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: ds.spacing.l,
      children: [
        CustomText(text: 'Basic Search Bar', style: CustomTextStyle.captionM),
        CustomGap(gapSize: GapSize.l),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ds.spacing.xl),
          child: CustomSearchBar(
            hintText: "Recherche l'addresse",
            onChanged: (value) {
              // Handle search input
            },
          ),
        ),
      ],
    ),
  );
}

// UploadFileContainer previewer
Widget _buildUploadFileContainerPreviewer(AppDesignSystem ds) {
  return Previewer(
    title: 'UploadFileContainer',
    description:
        'A file upload container with dotted border and action buttons',
    codeSnippet: '''
      UploadFileContainer(
        onSelectFromLocalFilesTapped: () {
          // Handle file selection
        },
        onTakeAPicTapped: () {
          // Handle taking a picture
        },
        label: 'Allowed file extensions (PDF, JPEG, JPG, PNG)',
      )
      ''',
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: ds.spacing.xl),
      child: UploadFileContainer(
        onSelectFromLocalFilesTapped: () {
          // Handle file selection
        },
        onTakeAPicTapped: () {
          // Handle taking a picture
        },
        label: 'Allowed file extensions (PDF, JPEG, JPG, PNG)',
      ),
    ),
  );
}

// CustomTextField previewer
Widget _buildCustomTextFieldPreviewer(AppDesignSystem ds) {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  return Previewer(
    title: 'CustomTextField',
    description: 'A customizable text input field with validation',
    codeSnippet: '''
      CustomTextField(
        controller: controller,
        focusNode: focusNode,
        labelText: 'Email',
        hintText: 'Enter your email',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
      )
      ''',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: ds.spacing.xl,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: CustomTextField(
            controller: controller,
            focusNode: focusNode,
            labelText: 'Email',
            hintText: 'Enter your email',
            maxLength: 20,
            // errorText: 'Please enter your email',
            suffixWidget: PillButton(
              label: 'Changer',
              color: ds.colors.secondary.shade500,
              onTap: () {},
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ],
    ),
  );
}

// CustomTabBar previewer
Widget _buildCustomTabBarPreviewer(AppDesignSystem ds) {
  return Previewer(
    title: 'CustomTabBar',
    description:
        'A customizable tab bar with support for scrollable and fixed tabs',
    codeSnippet: '''
      // Create a TabController
      TabController controller = TabController(length: 2, vsync: this);
      
      // Create TabItems
      List<TabItem> tabItems = [
        TabItem(label: 'Tab 1', icon: SaturneProIcons.home),
        TabItem(label: 'Tab 2', icon: SaturneProIcons.settings),
      ];
      
      // Create the CustomTabBar
      CustomTabBar(
        controller: controller,
        tabItems: tabItems,
        isScrollable: false,
      )
      ''',
    child: DefaultTabController(
      length: 2,
      child: Builder(
        builder: (context) {
          final TabController fixedController = DefaultTabController.of(
            context,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: ds.spacing.xl,
            children: [
              CustomText(
                text: 'Fixed Tab Bar (max 2 tabs)',
                style: CustomTextStyle.bodyM,
                fontWeight: FontWeight.w500,
              ),
              CustomTabBar(
                controller: fixedController,
                tabItems: [
                  TabItem(
                    label: 'Informations',
                    icon: SaturneProIcons.angleDown,
                  ),
                  const TabItem(label: 'Settings', icon: SaturneProIcons.apple),
                ],
                isScrollable: false,
              ),
              SizedBox(height: ds.spacing.l),

              CustomText(
                text: 'Scrollable Tab Bar',
                style: CustomTextStyle.bodyM,
                fontWeight: FontWeight.w500,
              ),
              StatefulBuilder(
                builder: (context, setState) {
                  final scrollableController = TabController(
                    length: 4,
                    vsync: Scaffold.of(context),
                  );

                  return CustomTabBar(
                    controller: scrollableController,
                    tabItems: [
                      TabItem(label: 'Home', icon: SaturneProIcons.search),
                      TabItem(label: 'Profile', icon: SaturneProIcons.user),
                      TabItem(label: 'Settings', icon: SaturneProIcons.setting),
                      TabItem(
                        label: 'More',
                        icon: SaturneProIcons.fileContract,
                      ),
                    ],
                    isScrollable: true,
                  );
                },
              ),
            ],
          );
        },
      ),
    ),
  );
}

// OtpTextField previewer
Widget _buildOtpTextFieldPreviewer(AppDesignSystem ds) {
  return Previewer(
    title: 'OtpTextField',
    description: 'A customizable OTP input field for verification codes',
    codeSnippet: '''
      OtpTextField(
        onCompleted: (value) {
          // Handle completed OTP input
        },
        onChanged: (value) {
          // Handle OTP input changes
        },
      )
      ''',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: ds.spacing.xl,
      children: [
        CustomText(
          text: 'OTP Input Field',
          style: CustomTextStyle.bodyM,
          fontWeight: FontWeight.w500,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ds.spacing.xs,
            vertical: ds.spacing.l,
          ),
          child: OtpTextField(
            onCompleted: (value) {
              // Handle completed OTP input
            },
            onChanged: (value) {
              // Handle OTP input changes
            },
          ),
        ),
      ],
    ),
  );
}

// SectionHeader previewer
Widget _buildSectionHeaderPreviewer(AppDesignSystem ds) {
  return Previewer(
    title: 'SectionHeader',
    description:
        'A section header with underlined title and optional description',
    codeSnippet: '''
      SectionHeader(
        titleLines: ['This is a section header', 'with multiple lines'],
        description: 'Optional description text that provides more context',
        isCenteredAligned: false,
      )
      ''',
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: ds.spacing.xl,
      children: [
        SectionHeader(
          titleLines: ['This is a section header', 'with multiple lines'],
          description: 'Optional description text that provides more context',
          isCenteredAligned: false,
        ),
        SizedBox(height: ds.spacing.xl),
        SectionHeader(
          titleLines: ['Centered section header'],
          description: 'This header is center-aligned',
          isCenteredAligned: true,
        ),
      ],
    ),
  );
}
