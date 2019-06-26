class CBar{};
class CFoo: CBar {
};

//+------------------------------------------------------------------+ 
//| 默认构造函数的类                                                   | 
//+------------------------------------------------------------------+ 
class CDuck 
  { 
   datetime          m_call_time;     // 最近一次对象调用时间 
public: 
   //--- 带有默认值参数的构造函数不是默认构造函数 
                     CDuck(const datetime t=0){m_call_time=t;}; 
   //--- 复制构造函数 
                     CDuck(const CDuck &foo){m_call_time=foo.m_call_time;}; 
  
   string ToString(){return(TimeToString(m_call_time,TIME_DATE|TIME_SECONDS));}; 
  }; 

struct CustomMqlTick
{
    datetime    time;
    double      bid;
    double      ask;
    double      last;
    ulong       volume;
    long        time_msc;
    uint        flags;
};

struct simple_structure pack(4)
{
    char        c;
    short       s;
    int         i;
    double      d;
};



bool CompareDoubles(double dVal, float fVal){
    if (NormalizeDouble(dVal - fVal, 8) == 0){
        return true;
    }
    
    return false;
}

/********************************************/
typedef int (*Action)(int, int);

int add(int a, int b) { return a + b; };
int sub(int a, int b) { return a - b; }
int neg(int a) { return ~a; }

/********************************************/

void OnStart(){
    CBar bar;
    CFoo *foo = dynamic_cast<CFoo *>(&bar);

    Print(foo);

    //foo = (CFoo *)&bar;
    //Print(foo);

    double dVal = 0.3;
    float fVal = 0.3f;
    if (CompareDoubles(dVal,fVal)){
        Print(dVal, "eq", fVal);
    } else {
        Print("Diff: dVal=", DoubleToString(dVal), " fVal=", DoubleToString(fVal));
    }
    

    MqlTick last_tick;
    CustomMqlTick my_tick1, my_tick2;

    if (SymbolInfoTick(Symbol(), last_tick)) {
        // my_tick1 = last_tick;

        my_tick1.time = last_tick.time;
        my_tick1.bid = last_tick.bid;
        my_tick1.ask = last_tick.ask;
        my_tick1.volume = last_tick.volume;
        my_tick1.time_msc = last_tick.time_msc;
        my_tick1.flags = last_tick.flags;

        my_tick2 = my_tick1;

        CustomMqlTick arr[2];
        arr[0] = my_tick1;
        arr[1] = my_tick2;

        ArrayPrint(arr);
    }

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++
    simple_structure s;
    Print("sizeof(s.c)=", sizeof(s.c));
    Print("sizeof(s.s)=", sizeof(s.s));
    Print("sizeof(s.i)=", sizeof(s.i));
    Print("sizeof(s.d)=", sizeof(s.d));
    Print("sizeof(simple_structure)=",sizeof(simple_structure)); 
    //+++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    CDuck duck;
    CDuck duck1(TimeCurrent());
    CDuck duck2=D'2009.09.09';

    CDuck *pduck = new CDuck();

    Print("duck.m_call_time=", duck.ToString());
    Print("duck1.m_call_time=", duck1.ToString());
    Print("duck2.m_call_time=", duck2.ToString());

    Print("pduck.m_call_time=", pduck.ToString());
    delete pduck;

    Action handler = add;
    Print(handler(4, 3));

    handler = sub;
    Print(handler(9, 7));
}
