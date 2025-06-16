import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:saturne_pro_core/saturne_pro_core.dart';
import 'package:saturne_pro_core/src/assets/icons.dart';
import 'package:saturne_pro_core/src/helpers/helpers.dart';
import 'package:saturne_pro_core/src/widgets/base/base.dart';

/// Defines the selection mode for the calendar widget.
enum CalendarSelectionType {
  /// Single date selection mode.
  single,

  /// Date range selection mode.
  range,

  /// Multiple dates selection mode.
  multiple,
}

/// A customizable calendar widget that supports single, range, and multiple date selection.
///
/// This widget wraps the CalendarDatePicker2 and provides a consistent design
/// system integration with proper styling and callbacks for different selection modes.
class CustomCalendar extends StatelessWidget {
  /// The selection mode for the calendar.
  final CalendarSelectionType selectionType;

  /// Initial date for single selection mode.
  final DateTime? initialDate;

  /// Initial start date for range selection mode.
  final DateTime? initialStartDate;

  /// Initial end date for range selection mode.
  final DateTime? initialEndDate;

  /// Initial selected dates for multiple selection mode.
  final List<DateTime> initialSelectedDates;

  /// Callback fired when a single date is selected.
  /// Only used when [selectionType] is [CalendarSelectionType.single].
  final ValueChanged<DateTime>? onDateSelected;

  /// Callback fired when a date range is selected.
  /// Only used when [selectionType] is [CalendarSelectionType.range].
  final ValueChanged<List<DateTime>>? onDateRangeSelected;

  /// Callback fired when multiple dates are selected.
  /// Only used when [selectionType] is [CalendarSelectionType.multiple].
  final ValueChanged<List<DateTime>>? onMultipleDatesSelected;

  /// The earliest date the user is permitted to select.
  final DateTime? firstDate;

  /// The latest date the user is permitted to select.
  final DateTime? lastDate;

  /// Whether the calendar is enabled for interaction.
  final bool isEnabled;

  /// Creates a [CustomCalendar] widget.
  const CustomCalendar({
    super.key,
    this.selectionType = CalendarSelectionType.single,
    this.initialDate,
    this.initialStartDate,
    this.initialEndDate,
    this.initialSelectedDates = const [],
    this.onDateSelected,
    this.onDateRangeSelected,
    this.onMultipleDatesSelected,
    this.firstDate,
    this.lastDate,
    this.isEnabled = true,
  }) : assert(
         selectionType != CalendarSelectionType.single ||
             (onDateRangeSelected == null && onMultipleDatesSelected == null),
         'onDateRangeSelected and onMultipleDatesSelected should not be used with single selection type',
       ),
       assert(
         selectionType != CalendarSelectionType.range ||
             (onDateSelected == null && onMultipleDatesSelected == null),
         'onDateSelected and onMultipleDatesSelected should not be used with range selection type',
       ),
       assert(
         selectionType != CalendarSelectionType.multiple ||
             (onDateSelected == null && onDateRangeSelected == null),
         'onDateSelected and onDateRangeSelected should not be used with multiple selection type',
       );

  /// Builds the calendar configuration based on the design system.
  CalendarDatePicker2Config _buildCalendarConfig(AppDesignSystem ds) {
    return CalendarDatePicker2Config(
      calendarType: _getCalendarType(),
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime(2100),

      // Control styling
      controlsHeight: 1.4 * ds.spacing.xl,
      controlsTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.primary.shade500,
        fontWeight: FontWeight.w500,
      ),
      lastMonthIcon: Icon(
        SaturneProIcons.angleLeft,
        color: ds.colors.primary.shade500,
        size: 0.9 * ds.spacing.xl,
      ),
      nextMonthIcon: Icon(
        SaturneProIcons.angleRight,
        color: ds.colors.primary.shade500,
        size: 0.9 * ds.spacing.xl,
      ),
      customModePickerIcon: Icon(
        SaturneProIcons.angleDown,
        color: ds.colors.primary.shade500,
        size: 0.9 * ds.spacing.xl,
      ),

      // Weekday styling
      weekdayLabels: const ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'],
      weekdayLabelTextStyle: ds.typography.bodyS.copyWith(
        color: ds.colors.primary.shade900.withValues(alpha: 0.3),
        fontWeight: FontWeight.w500,
      ),

      // Day styling
      dayTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.primary.shade900,
        fontWeight: FontWeight.w400,
      ),
      todayTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.primary.shade900,
        fontWeight: FontWeight.w400,
      ),
      selectedDayTextStyle: ds.typography.bodyL.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      selectedDayHighlightColor: ds.colors.secondary.shade500,

      // Range selection styling
      rangeBidirectional: true,
      selectedRangeHighlightColor: ds.colors.secondary.shade200,
      selectedRangeDayTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.secondary.shade900,
        fontWeight: FontWeight.w500,
      ),

      // Year and month styling
      yearTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.primary.shade900,
        fontWeight: FontWeight.w400,
      ),
      selectedYearTextStyle: ds.typography.bodyL.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      monthTextStyle: ds.typography.bodyL.copyWith(
        color: ds.colors.primary.shade900,
        fontWeight: FontWeight.w400,
      ),
      selectedMonthTextStyle: ds.typography.bodyL.copyWith(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  /// Returns the appropriate calendar type based on selection mode.
  CalendarDatePicker2Type _getCalendarType() {
    switch (selectionType) {
      case CalendarSelectionType.single:
        return CalendarDatePicker2Type.single;
      case CalendarSelectionType.range:
        return CalendarDatePicker2Type.range;
      case CalendarSelectionType.multiple:
        return CalendarDatePicker2Type.multi;
    }
  }

  /// Gets the initial value for the calendar based on selection type.
  List<DateTime> _getInitialValue() {
    switch (selectionType) {
      case CalendarSelectionType.single:
        if (initialDate != null) {
          return [initialDate!];
        }
        if (initialSelectedDates.isNotEmpty) {
          return [initialSelectedDates.first];
        }
        return [];

      case CalendarSelectionType.range:
        final dates = <DateTime>[];
        if (initialStartDate != null) {
          dates.add(initialStartDate!);
        }
        if (initialEndDate != null) {
          dates.add(initialEndDate!);
        }
        if (dates.isEmpty && initialSelectedDates.isNotEmpty) {
          dates.addAll(initialSelectedDates.take(2));
        }
        return dates;

      case CalendarSelectionType.multiple:
        return initialSelectedDates;
    }
  }

  /// Handles value changes and calls the appropriate callback.
  void _handleValueChanged(List<DateTime?> dates) {
    final nonNullDates = dates.whereType<DateTime>().toList();

    switch (selectionType) {
      case CalendarSelectionType.single:
        if (nonNullDates.isNotEmpty) {
          onDateSelected?.call(nonNullDates.first);
        }
        break;

      case CalendarSelectionType.range:
        onDateRangeSelected?.call(nonNullDates);
        break;

      case CalendarSelectionType.multiple:
        onMultipleDatesSelected?.call(nonNullDates);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.designSystem;

    return CustomCard(
      padding: EdgeInsets.all(ds.spacing.xs),
      child: CalendarDatePicker2(
        config: _buildCalendarConfig(ds),
        value: _getInitialValue(),
        onValueChanged: isEnabled ? _handleValueChanged : null,
      ),
    );
  }
}
