library google_visualization_api.chart.options;

class AggregationTargetOption {
  /// Group selected data by x-value.
  static const AggregationTargetOption CATEGORY = const AggregationTargetOption._('category');

  /// Group selected data by series.
  static const AggregationTargetOption SERIES = const AggregationTargetOption._('series');

  /// Group selected data by x-value if all selections have the same x-value, and by series otherwise.
  static const AggregationTargetOption AUTO = const AggregationTargetOption._('auto');

  /// Show only one tooltip per selection.
  static const AggregationTargetOption NONE = const AggregationTargetOption._('none');

  /// String value
  final String value;

  /// Internal const constructor
  const AggregationTargetOption._(this.value);
}

class AreaChartOptions {
  AggregationTargetOption aggregationTarget;

  var animation_duration;

  var animation_easing;

  AreaChartOptions({
     this.aggregationTarget: AggregationTargetOption.AUTO,
     animation_duration: 0,
     animation_easing: 'linear',
     animation_startup: false,
     annotations_boxStyle: null,
     annotations_highContrast: true,
     annotations_textStyle: null,
     areaOpacity: 0.3,
     axisTitlesPosition: 'out',
     backgroundColor: 'white',
     backgroundColor_stroke: '#666',
     backgroundColor_strokeWidth: 0,
     backgroundColor_fill: 'white',
     chartArea: null,
     chartArea_backgroundColor: 'white',
     chartArea_left,
     chartArea_top,
     chartArea_width,
     chartArea_height,
     colors,
     crosshair: null,
     crosshair_color,
     crosshair_focused,
     crosshair_opacity: 1.0,
     crosshair_orientation: 'both',
     crosshair_selected,
     crosshair_trigger: 'both',
     dataOpacity: 1.0,
     enableInteractivity: true,
     explorer: null,
     explorer_actions: const ['dragToPan', 'rightClickToReset'],
     explorer_axis,
     explorer_keepInBounds: false,
     explorer_maxZoomIn: 0.25,
     explorer_maxZoomOut: 4,
     explorer_zoomDelta: 1.5,
     focusTarget: 'datum',
     fontSize,
     fontName: 'Arial',
     forceIFrame: false,
     hAxis: null,
     hAxis_baseline,
     hAxis_baselineColor: 'black',
     hAxis_direction: 1,
     hAxis_format,
     hAxis_gridlines: null,
     hAxis_gridlines_color: '#CCC',
     hAxis_gridlines_count: 5,
     hAxis_gridlines_units: null,
     hAxis_minorGridlines: null,
     hAxis_minorGridlines_color,
     hAxis_minorGridlines_count: 0,
     hAxis_minorGridlines_units: null,
     hAxis_logScale: false,
     hAxis_textPosition: 'out',
     hAxis_textStyle,
     hAxis_ticks,
     hAxis_title: null,
     hAxis_titleTextStyle,
     hAxis_allowContainerBoundaryTextCufoff: false,
     hAxis_slantedText,
     hAxis_slantedTextAngle: 30,
     hAxis_maxAlternation: 2,
     hAxis_maxTextLines,
     hAxis_minTextSpacing,
     hAxis_showTextEvery,
     hAxis_maxValue,
     hAxis_minValue,
     hAxis_viewWindowMode: 'pretty',
     hAxis_viewWindow: null,
     hAxis_viewWindow_max,
     hAxis_viewWindow_min,
     height,
     interpolateNulls: false,
     isStacked: false,
     legend: null,
     legend_alignment,
     legend_maxLines: 1,
     legend_position: 'right',
     legend_textStyle,
     lineDashStyle: null,
     lineWidth: 2,
     orientation: 'horizontal',
     pointShape: 'circle',
     pointSize: 0,
     reverseCategories: false,
     selectionMode: 'single',
     series,
     theme: null,
     title,
     titlePosition: 'out',
     titleTextStyle,
     tooltip: null,
     tooltip_isHtml: false,
     tooltip_showColorCode,
     tooltip_textStyle,
     tooltip_trigger: 'focus',
     vAxes: null,
     vAxis: null,
     vAxis_baseline,
     vAxis_baselineColor: 'black',
     vAxis_direction: 1,
     vAxis_format,
     vAxis_gridlines: null,
     vAxis_gridlines_color: '#CCC',
     vAxis_gridlines_count: 5,
     vAxis_gridlines_units: null,
     vAxis_minorGridlines: null,
     vAxis_minorGridlines_color: null,
     vAxis_minorGridlines_count: 0,
     vAxis_minorGridlines_units: null,
     vAxis_logScale: false,
     vAxis_textPosition: 'out',
     vAxis_textStyle,
     vAxis_ticks,
     vAxis_title,
     vAxis_titleTextStyle,
     vAxis_maxValue,
     vAxis_minValue,
     vAxis_viewWindowMode: 'pretty',
     vAxis_viewWindow: null,
     vAxis_viewWindow_max,
     vAxis_viewWindow_min,
     width
     }
  );

  Map toMap() {}
}
