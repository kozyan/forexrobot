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
    /* code */
  } while (i < counterFibonacci && !IsStopped());

  //++++++++++++++++++++++++++++++++++++++++++++++++++++ fib end
}