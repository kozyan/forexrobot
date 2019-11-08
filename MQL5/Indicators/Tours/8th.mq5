void OnStart() {
  string chart_name = "test_chart_name";

  Print("Let's try to create a chart object with the name ", chart_name);

  if (ObjectFind(0, chart_name) < 0) {
    ObjectCreate(0, chart_name, OBJ_CHART, 0, 0, 0, 0, 0);
  }

  ObjectSetString(0, chart_name, OBJPROP_SYMBOL, "EURUSDm");
  ObjectSetInteger(0, chart_name, OBJPROP_XDISTANCE, 100);
  ObjectSetInteger(0, chart_name, OBJPROP_YDISTANCE, 100);
  ObjectSetInteger(0, chart_name, OBJPROP_XSIZE, 400);
  ObjectSetInteger(0, chart_name, OBJPROP_YSIZE, 300);
  ObjectSetInteger(0, chart_name, OBJPROP_PERIOD, PERIOD_D1);
  ObjectSetDouble(0, chart_name, OBJPROP_SCALE, 4);
  ObjectSetInteger(0, chart_name, OBJPROP_SELECTABLE, false);

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  bool ret;
  ChartIsObject(ret);

  Print("The result is: ", ret);
}

bool ChartIsObject(bool &result, const long chart_id = 0) {
  long value;
  ResetLastError();

  if (!ChartGetInteger(chart_id, CHART_IS_OBJECT, 0, value)) {
    Print(__FUNCTION__, ", Error Code = ", GetLastError());
    return false;
  }

  result = value;
  return true;
}

bool ChartBringToTop(const long chart_id = 0) {
  ResetLastError();

  if (!ChartSetInteger(chart_id, CHART_BRING_TO_TOP, 0, true)) {
    Print(__FUNCTION__, ", Error Code = ", GetLastError());
    return false;
  }

  return true;
}