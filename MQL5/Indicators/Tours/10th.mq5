#property description "Script draws \"Horizontal Line\" graphical object."
#property description "Anchor point price is set in percentage of height of"
#property description "the chart window."

#property script_show_inputs

input string InpName = "HLine";
input int InpPrice = 25;
input color InpColor = clrRed;
input ENUM_LINE_STYLE InpStyle = STYLE_DASH;
input int InpWidth = 3;
input bool InpBack = false;
input bool InpSelection = true;
input bool InpHidden = true;
input long InpZOrder = true;

bool HLineCreate(const long chart_id = 0, const string name = "HLine",
                 const int sub_window = 0, double price = 0,
                 const color clr = clrRed,
                 const ENUM_LINE_STYLE style = STYLE_SOLID, const int width = 1,
                 const bool back = false, const bool selection = true,
                 const bool hidden = true, const bool z_order = 0) {

  if (!price) {
    price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
  }

  ResetLastError();

  if (!ObjectCreate(chart_id, name, OBJ_HLINE, sub_window, 0, price)) {
    Print(__FUNCTION__, ": Failed to create a horizontal line! Error Code = ",
          GetLastError());
    return false;
  }

  ObjectSetInteger(chart_id, name, OBJPROP_COLOR, clr);

  ObjectSetInteger(chart_id, name, OBJPROP_STYLE, style);

  ObjectSetInteger(chart_id, name, OBJPROP_WIDTH, width);

  ObjectSetInteger(chart_id, name, OBJPROP_BACK, back);

  ObjectSetInteger(chart_id, name, OBJPROP_SELECTABLE, selection);
  ObjectSetInteger(chart_id, name, OBJPROP_SELECTED, selection);

  ObjectSetInteger(chart_id, name, OBJPROP_HIDDEN, hidden);
  ObjectSetInteger(chart_id, name, OBJPROP_ZORDER, z_order);

  return true;
}

bool HLineMove(const long chart_id, const string name = "HLine",
               double price = 0) {
  if (!price) {
    price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
  }

  ResetLastError();

  if (!ObjectMove(chart_id, name, 0, 0, price)) {
    Print(__FUNCTION__,
          " Failed to move horizontal line! Error Code = ", GetLastError());
    return false;
  }

  return true;
}

bool HLineDelete(const long chart_id, const string name = "HLine") {
  ResetLastError();

  if (!ObjectDelete(chart_id, name)) {
    Print(__FUNCTION__,
          " Failed to delete horizontal line! Error Code = ", GetLastError());
    return false;
  }

  return true;
}

void OnStart() {
  if (InpPrice < 0 || InpPrice > 100) {
    Print("Error! Incorrect values of input parameters!");
    return;
  }

  int accuracy = 1000;
  double price[];

  ArrayResize(price, accuracy);

  double max_price = ChartGetDouble(0, CHART_PRICE_MAX);
  double min_price = ChartGetDouble(0, CHART_PRICE_MIN);

  double step = (max_price - min_price) / accuracy;
  for (int i = 0; i < accuracy; i++) {
    price[i] = min_price + i * step;
  }

  int p = InpPrice * (accuracy - 1) / 100;

  if (!HLineCreate(0, InpName, 0, price[p], InpColor, InpStyle, InpWidth,
                   InpBack, InpSelection, InpHidden, InpZOrder)) {
    return;
  }

  ChartRedraw();

  Sleep(1000);

  int v_step = accuracy / 2;
  for (int i = 0; i < v_step; i++) {
    if (p < accuracy - 1) {
      p += 1;
    }

    if (!HLineMove(0, InpName, price[p])) {
      return;
    }

    if (IsStopped())
      return;

    ChartRedraw();
  }

  Sleep(1000);

  HLineDelete(0, InpName);

  ChartRedraw();

  Sleep(1000);
}