class CFoo
{
public:
    int m_id;
    string m_name;
    static int m_counter;

    CFoo(void) { Setup("noname"); };
    CFoo(string name) { Setup(name); };
    ~CFoo(void){};

    void Setup(string name){ m_name = name; m_counter++; m_id = m_counter; }
};

int CFoo::m_counter = 0;

void OnStart()
{
   CFoo foo1;
   PrintObject(foo1);

   CFoo *foo2 = new CFoo("kant");
   PrintObject(foo2);

    CFoo foo_objects[5];
    PrintObjectArray(foo_objects);
    
    CFoo *foo_pointers[5];
    for (int i = 0; i < 5; i++)
    {
        foo_pointers[i] = new CFoo("foo_pointer");
    }

    PrintPointerArray(foo_pointers);
    

    //+++++++++++++++++++++++ 删除指针
    delete(foo2);

    int size = ArraySize(foo_pointers);
    for (int i = 0; i < size; i++)
    {
        delete(foo_pointers[i]);
    }
    //+++++++++++++++++++++++ 删除指针 end
    
}

void PrintObject(CFoo &f){
    Print(__FUNCTION__, ": ", f.m_id, " object name=", f.m_name);
}

void PrintObjectArray(CFoo &list[]){
    int size = ArraySize(list);

    for (int i = 0; i < size; i++){
        PrintObject(list[i]);
    }
}

void PrintPointerArray(CFoo* &list[]){
    int size = ArraySize(list);

    for (int i = 0; i < size; i++) {
        PrintObject(list[i]);
    }
    
}