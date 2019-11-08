#property description "Script draws \"Vertical Line\" graphical object."
#property description "Anchor point date is set in percentage of"
#property description "the chart window width in bars."

#property script_show_inputs

input string InpName = "VLine";
input int InpDate = 5;
input color InpColor = clrRed;
input ENUM_LINE_STYLE InpStyle = STYLE_DASH;
input int InpWidth = 3;
input bool InpBack = false;
input bool InpSelection = true;
input bool InpRay = true;
input bool InpHidden = true;
input long InpZOrder = 0;

bool VLineCreate(const long chart_id = 0, const string name = "VLine",
                 const int sub_window = 0, datetime time = 0,
                 const color clr = clrRed,
                 const ENUM_LINE_STYLE style = STYLE_SOLID, const int width = 1,
                 const bool back = false, const bool selection = true,
                 const bool ray = true, const bool hidden = true,
                 const long z_order = 0) {

  if (!time) {
    time = TimeCurrent();
  }

  ResetLastError();

  if (!ObjectCreate(chart_id, name, OBJ_VLINE, sub_window, time, 0)) {
    Print(__FUNCTION__,
          ": failed to create a vertical line! Error code = ", GetLastError());
    return false;
  }

  return true;
}

bool VLineMove(const long chart_id, const string name = "VLine",
               datetime time = 0) {
  if (!time) {
    time = TimeCurrent();
  }

  ResetLastError();

  if (!ObjectMove(chart_id, name, 0, time, 0)) {
    Print(__FUNCTION__,
          ": Failed to move the vertical line! Error Code = ", GetLastError());
    return false;
  }

  return true;
}

bool VLineDelete(const long chart_id, const string name = "VLine") {
  ResetLastError();

  if (!ObjectDelete(chart_id, name)) {
    Print(__FUNCTION__, ": Failed to delete the vertical line! Error Code = ",
          GetLastError());
    return false;
  }

  return true;
}

void OnStart() {
  if (InpDate < 0 || InpDate > 100) {
    Print("Error! Incorrect values of input parameters!");
    return;
  }

  int bars = (int)ChartGetInteger(0, CHART_VISIBLE_BARS);

  datetime date[];
  ArrayResize(date, bars);

  ResetLastError();
  if (CopyTime(Symbol(), Period(), 0, bars, date) == -1) {
    Print("Fail to copy time values! Error Code =", GetLastError());
    return;
  }

  int d = InpDate * (bars - 1) / 100;

  if (!VLineCreate(0, InpName, 0, date[d], InpColor, InpStyle, InpWidth,
                   InpBack, InpSelection, InpRay, InpHidden, InpZOrder)) {
    return;
  }

  ChartRedraw();

  Sleep(1000);

  int h_steps = bars / 2;
  for (int i = 0; i < h_steps; i++) {
    if (d < bars - 1)
      d += 1;

    if (!VLineMove(0, InpName, date[d]))
      return;

    if (IsStopped())
      return;

    ChartRedraw();

    Sleep(30);
  }

  Sleep(1000);

  VLineDelete(0, InpName);

  ChartRedraw();

  Sleep(1000);
}