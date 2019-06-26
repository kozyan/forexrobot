#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>

//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#define INDENT_LEFT                     11
#define INDENT_TOP                      11
#define CONTROLS_GAP_X                  5
#define CONTROLS_GAP_Y                  5
#define BUTTON_WIDTH                    100
#define BUTTON_HEIGHT                   20
#define EDIT_HEIGHT                     20
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
typedef int (*TAction) (string, int);

int Open(string name, int id){
    PrintFormat("%s function is called (name=%s, id=%d)", __FUNCTION__, name, id);
    return 1;
}

int Save(string name, int id){
    PrintFormat("%s function is called (name=%s, id=%d)", __FUNCTION__, name, id);
    return 2;
}

int Close(string name, int id){
    PrintFormat("%s function is called (name=%s, id=%d)", __FUNCTION__, name, id);
    return 3;
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
class MyButton : public CButton
{
private:
    TAction     m_action;
public:
    MyButton(void){};
    ~MyButton(void){};
    MyButton(string text, TAction act){
        Text(text);
        m_action = act;
    }

    void SetAction(TAction act){ m_action = act; }
    virtual bool OnEvent(const int id, const long &lparam, const double &dparam, const string &sparam) override {
        if (m_action != NULL && lparam == Id()) {
            m_action(sparam, (int)lparam);
            return true;
        }else {
            return CButton::OnEvent(id, lparam, dparam, sparam);
        }
    }
};
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

class CControlDialog : public CAppDialog
{
private:
    CArrayObj m_buttons;
public:
    CControlDialog(void){};
    ~CControlDialog(void){};

    virtual bool Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2) override;
    bool AddButton(MyButton *button) { return(m_buttons.Add(GetPointer(button))); m_buttons.Sort(); };

protected:
    bool CreateButtons(void);
};

bool CControlDialog::Create(const long chart, const string name, const int subwin, const int x1, const int y1, const int x2, const int y2){
    if (!CAppDialog::Create(chart, name, subwin, x1, y1, x2, y2)) {
        return false;
    }

    return CreateButtons();    
}
bool CControlDialog::CreateButtons(void){
    int x1 = INDENT_LEFT;
    int y1 = INDENT_TOP + (EDIT_HEIGHT + CONTROLS_GAP_Y);
    int x2;
    int y2 = y1 + BUTTON_HEIGHT;

    AddButton(new MyButton("Open", Open));
    AddButton(new MyButton("Save", Save));
    AddButton(new MyButton("Close", Close));

    for (int i = 0; i < m_buttons.Total(); i++) {
        MyButton *b = (MyButton *)m_buttons.At(i);

        x1 = INDENT_LEFT + i*(BUTTON_WIDTH + CONTROLS_GAP_X);
        x2 = x1 + BUTTON_WIDTH;

        if (!b.Create(m_chart_id, m_name+"btn"+b.Text(), m_subwin, x1, y1, x2, y2)) {
            PrintFormat("Fail to create button %s, %d", b.Text(), i);
            return false;
        }

        if (!Add(b)) {
            return false;
        }      
        
    }

    return true;
    
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

CControlDialog MyDialog;

int OnInit(){
    if (!MyDialog.Create(0, "controls", 0, 40,40,388,344)) {
        return INIT_FAILED;
    }

    MyDialog.Run();

    return INIT_SUCCEEDED;    
}

void OnDeinit(const int reason){
    MyDialog.Destroy(reason);
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam){
    MyDialog.ChartEvent(id, lparam, dparam, sparam);
}