#include <winapi/WinUser.mqh>

#define MACRO

#define MUL(a, b) (a * b)

void func1() {
#ifdef MACRO
  Print("MACRO is defined in ", __FUNCTION__);
#else
  Print("MACRO is not defined in ", __FUNCTION__);
#endif
}

#undef MACRO

void func2() {
#ifdef MACRO
  Print("MACRO is defined in ", __FUNCTION__);
#else
  Print("MACRO is not defined in ", __FUNCTION__);
#endif
}

class CDemoClass {
private:
  double m_array[];

public:
  CDemoClass(void){};
  ~CDemoClass(void){};
  void SetArray(double &array[]);
  CDemoClass *GetDemoClass();
};

void CDemoClass::SetArray(double &array[]) {
  if (ArraySize(array) > 0) {
    ArrayResize(m_array, ArraySize(array));
    ArrayCopy(array, m_array);
  }
}

CDemoClass *CDemoClass::GetDemoClass(void) { return GetPointer(this); }

int Counter() {
  static int count;
  count++;

  if (count % 100 == 0)
    Print("Function counter has been called ", count, " times.");
  return count;
}

void OnStart() {
  char x = 'B';

  switch (x) {
  case 'A':
    Print("print a");
    break;
  case 'B':
  case 'C':
    Print("print b or c");
    break;
  default:
    Print("unknow");
    break;
  }

  for (int i = 0; i < 10 && !IsStopped(); i++) {
    Print("print i=", i);
  }

  //++++++++++++++++++++++++++++++++++++++++++++++++++++ fib
  int counterFibonacci = 15;
  int fibNum;
  int i = 0, first = 0, second = 1;
  do {
    fibNum = first + second;
    Print("i= ", i, " fibonacci num: ", fibNum);
    first = second;
    second = fibNum;

    i++;

  } while (i < counterFibonacci && !IsStopped());

  //++++++++++++++++++++++++++++++++++++++++++++++++++++ fib end

  CDemoClass *demo = new CDemoClass();

  delete demo;
  demo = NULL;

  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  int c = 345;
  for (int j = 0; j < 1000; j++) {
    c = Counter();
  }

  Print("c =", c);

  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ MACRO
  func1();
  func2();

  double v = MUL(2, 3);
  Print("v = ", v);
  //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ MACRO END
}