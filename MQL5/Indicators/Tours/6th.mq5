struct Name {
  string first_name;
  string last_name;
};

class CPerson {
private:
  Name m_name;

public:
  CPerson(void){};
  ~CPerson(){};
  string GetName() { return m_name.first_name + " " + m_name.last_name; };
  void SetName(string name);

protected:
  string GetFirstName(string full_name);
  string GetLastName(string full_name);
};

void CPerson::SetName(string n) {
  m_name.first_name = GetFirstName(n);
  m_name.last_name = GetLastName(n);
}

string CPerson::GetFirstName(string n) {
  int pos = StringFind(n, " ");
  if (pos > -1)
    StringSetCharacter(n, pos, 0);
  return n;
}

string CPerson::GetLastName(string n) {
  int pos = StringFind(n, " ");
  if (pos > -1) {
    n = StringSubstr(n, pos + 1);
  }

  return n;
}

void OnStart() {
  CPerson *p = new CPerson();
  p.SetName("jintian yang");

  Print(p.GetName());

  delete (p);
}