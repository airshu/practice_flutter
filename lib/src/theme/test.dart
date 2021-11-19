


import 'package:flutter/material.dart';

class ThemeUtil {
  static ThemeData themeData  = ThemeData(
    primarySwatch:Colors.red,
    buttonColor: null,//Material中RaisedButtons使用的默认填充色
    accentColor: null,//前景色
    backgroundColor: null,//与primaryColor对比的颜色
    bottomAppBarColor: null,//BottomAppBar的默认颜色
    canvasColor: null,//MaterialType.canvas 的默认颜色
    cardColor: null,//Card的颜色
    dialogBackgroundColor: null,//Dialog背景色
    disabledColor: null,//widget无效状态的颜色
    dividerColor: null,//Dividers和PopupMenuDividers的颜色，也用于ListTiles中间，和DataTables的每行中间
    errorColor: null,//输入验证错误的颜色
    highlightColor: null,//选中、高亮颜色
    hintColor: null,//提示文本或占位符的文本颜色
    indicatorColor: null,//指示器颜色
    primaryColor: null,//大部分控件的背景色
    primaryColorDark: null,//黑暗样式
    primaryColorLight: null,//白天模式
    scaffoldBackgroundColor: null,//
    secondaryHeaderColor: null,//选定行时PaginatedDataTable标题的颜色
    selectedRowColor: null,//选中行时的高亮颜色
    splashColor: null,//
    textSelectionColor: null,
    textSelectionHandleColor: null,
    toggleableActiveColor: null,//Seitch、Radio、Checkbox等活动状态的颜色
    unselectedWidgetColor: null,//用于Widget处于非活动（但已启用）状态的颜色。 例如，未选中的复选框。 通常与accentColor形成对比。
    focusColor: null,//焦点获取时的颜色
    hoverColor: null,//长按、按住之后的颜色
    cursorColor: null,
    accentIconTheme: null,//

    accentTextTheme: null,//与突出颜色对照的文本主题
    chipTheme: null,//Chip的颜色和样式
    buttonTheme: null,//按钮的默认配置
    primaryIconTheme: null,//与主色对比的图片主题
    primaryTextTheme: null,//与主色对比的文本主题
    iconTheme: null,//与卡片和画布颜色形成对比的图标主题
    inputDecorationTheme: null,
    sliderTheme: null,
    textTheme: null,
    toggleButtonsTheme: null,
    tabBarTheme: null,
    tooltipTheme: null,
    cardTheme: null,
    pageTransitionsTheme: null,
    appBarTheme: null,
    bottomAppBarTheme: null,
    dialogTheme: null,
    floatingActionButtonTheme: null,
    cupertinoOverrideTheme: null,
    snackBarTheme: null,
    bottomSheetTheme: null,
    popupMenuTheme: null,
    bannerTheme: null,
    dividerTheme: null,

    accentColorBrightness: null,
    brightness: null,
    platform: null,
    splashFactory: null,//定义InkWall和InkResponse生成的墨水喷溅的外观。
    primaryColorBrightness: null,
    fontFamily: null,
    applyElevationOverlayColor: true,
    materialTapTargetSize: null,
    colorScheme: null,
    typography: null,

  );
}