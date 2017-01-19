#include <dlfcn.h>
#include<stdarg.h>
static void *g_chlinkbot_dlhandle;
static int g_chlinkbot_dlcount;

class Widget {
    public:
    Widget();
    ~Widget();

    int a;

};

class TestClass {
    public:
    TestClass();
    ~TestClass();

    void func(Widget &w);

};

Widget::Widget() {
    void *fptr;
    va_list ap;

    if (g_chlinkbot_dlhandle == NULL || g_chlinkbot_dlcount == 0) {
        g_chlinkbot_dlhandle = dlopen("libtest.dl", RTLD_LAZY);
        if (g_chlinkbot_dlhandle == NULL) {
          printf("Error: %s(): dlopen(): %s\n", __class_func__, dlerror());
          return;
       }
    }

    va_start(ap, VA_NOARG);
    fptr = dlsym(g_chlinkbot_dlhandle, "Widget_Widget_chdl");
    if (fptr == NULL) {
       printf("Error: %s(): dlsym(): %s\n", __class_func__, dlerror());
       return;
    }
}

Widget::~Widget() {
    void *fptr;
    fptr = dlsym(g_chlinkbot_dlhandle, "Widget_dWidget_chdl");
    if (fptr == NULL) {
       printf("Error: %s(): dlsym(): %s\n", __class_func__, dlerror());
       return;
    }
    
    dlrunfun(fptr, NULL, NULL, this);
    g_chlinkbot_dlcount--;
    
    if (g_chlinkbot_dlcount <= 0 && g_chlinkbot_dlhandle != NULL) 
       if (dlclose(g_chlinkbot_dlhandle) != 0)
          printf("Error: %s(): dlclose(): %s\n", __class_func__, dlerror());
}

TestClass::TestClass()
{
    void *fptr;
    va_list ap;

    if (g_chlinkbot_dlhandle == NULL || g_chlinkbot_dlcount == 0) {
        g_chlinkbot_dlhandle = dlopen("libtest.dl", RTLD_LAZY);
        if (g_chlinkbot_dlhandle == NULL) {
          printf("Error: %s(): dlopen(): %s\n", __class_func__, dlerror());
          return;
       }
    }

    va_start(ap, VA_NOARG);
    fptr = dlsym(g_chlinkbot_dlhandle, "TestClass_TestClass_chdl");
    if (fptr == NULL) {
       printf("Error: %s(): dlsym(): %s\n", __class_func__, dlerror());
       return;
    }
}

TestClass::~TestClass()
{
    void *fptr;
    fptr = dlsym(g_chlinkbot_dlhandle, "TestClass_dTestClass_chdl");
    if (fptr == NULL) {
       printf("Error: %s(): dlsym(): %s\n", __class_func__, dlerror());
       return;
    }
    
    dlrunfun(fptr, NULL, NULL, this);
    g_chlinkbot_dlcount--;
    
    if (g_chlinkbot_dlcount <= 0 && g_chlinkbot_dlhandle != NULL) 
       if (dlclose(g_chlinkbot_dlhandle) != 0)
          printf("Error: %s(): dlclose(): %s\n", __class_func__, dlerror());
}

void TestClass::func(Widget &w)
{
    void *fptr;
  
    fptr = dlsym(g_chlinkbot_dlhandle, "TestClass_func_chdl");
    if (fptr == NULL) {
       printf("Error: %s(): dlsym(): %s\n", __class_func__, dlerror());
       return;
    }
     
    dlrunfun(fptr, NULL, NULL, this, &w);
}



int main() {
    /* Does not work */
    Widget *w = new Widget();
    printf("0x%X\n", w);
    TestClass t;
    t.func(*w);
 
    /* Works */
    /*
    Widget w;
    TestClass t;
    t.func(w);
    */
}

