#define KEY_NUMPAD_5 12
#define KEY_LEFT 37
#define KEY_UP 38
#define KEY_RIGHT 39
#define KEY_DOWN 40
#define KEY_NUMLOCK_DOWN 98
#define KEY_NUMLOCK_LEFT 100
#define KEY_NUMLOCK_5 101
#define KEY_NUMLOCK_RIGHT 102
#define KEY_NUMLOCK_UP 104

int OnInit() {
  Print("The expert with name ", MQL5InfoString(MQL5_PROGRAM_NAME),
        " is running.");

  ChartSetInteger(ChartID(), CHART_EVENT_OBJECT_CREATE, true);

  ChartSetInteger(ChartID(), CHART_EVENT_OBJECT_DELETE, true);

  ChartRedraw();

  return INIT_SUCCEEDED;
}

void OnChartEvent(const int id, const long &lparam, const double &dparam,
                  const string &sparam) {
  if (id == CHARTEVENT_CLICK) {
    Print("The coordinates of the mouse click on the chart are: x=", lparam,
          " y=", dparam);
  }

  if (id == CHARTEVENT_OBJECT_CLICK) {
    Print("The mouse has been clicked on the object with name '" + sparam +
          "'");
  }

  if (id == CHARTEVENT_KEYDOWN) {
    switch ((int)lparam) {
    case KEY_NUMLOCK_LEFT:
      Print("The KEY_NUMLOCK_LEFT has been pressed");
      break;
    case KEY_LEFT:
      Print("The KEY_LEFT has been pressed");
      break;
    case KEY_NUMLOCK_UP:
      Print("The KEY_NUMLOCK_UP has been pressed");
      break;
    case KEY_UP:
      Print("The KEY_UP has been pressed");
      break;
    case KEY_NUMLOCK_RIGHT:
      Print("The KEY_NUMLOCK_RIGHT has been pressed");
      break;
    case KEY_RIGHT:
      Print("The KEY_RIGHT has been pressed");
      break;
    case KEY_NUMLOCK_DOWN:
      Print("The KEY_NUMLOCK_DOWN has been pressed");
      break;
    case KEY_DOWN:
      Print("The KEY_DOWN has been pressed");
      break;
    case KEY_NUMLOCK_5:
      Print("The KEY_NUMLOCK_5 has been pressed");
      break;
    case KEY_NUMPAD_5:
      Print("The KEY_NUMPAD_5 has been pressed");
      break;
    default:
      Print("Some no list key has been pressed");
      break;
    }

    ChartRedraw();
  }

  if (id == CHARTEVENT_OBJECT_DELETE) {
    Print("The object with name ", sparam, " has been deleted.");
  }

  if (id == CHARTEVENT_OBJECT_CREATE) {
    Print("The object with name ", sparam, " has been created.");
  }

  if (id == CHARTEVENT_OBJECT_DRAG) {
    Print("The anchor point coordinates of the object with name ", sparam,
          " has been changed.");
  }

  if (id == CHARTEVENT_OBJECT_ENDEDIT) {
    Print("The text in the edit field of the object with name ", sparam,
          " has been changed.");
  }
}