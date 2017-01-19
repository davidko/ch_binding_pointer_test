#include <ch.h>
#include <stdio.h>
#include <vector>

extern "C" {
EXPORTCH void Widget_Widget_chdl(void *varg);
EXPORTCH void Widget_dWidget_chdl(void *varg);
EXPORTCH void TestClass_TestClass_chdl(void *varg);
EXPORTCH void TestClass_dTestClass_chdl(void *varg);
EXPORTCH void TestClass_func_chdl(void *varg);
}

class Widget {
    public:
    Widget() {}
    ~Widget() {}

    int m;
};

class TestClass {
    public:
    TestClass() {}
    ~TestClass() {}

    void func(Widget& w) {
        _widgets.push_back(&w);
    }

    std::vector<Widget*> _widgets;
};

EXPORTCH void Widget_Widget_chdl(void *varg) {
    ChInterp_t interp;
    ChVaList_t ap;
    class Widget *c;

    Ch_VaStart(interp, ap, varg);  
    c = new Widget();
    Ch_CppChangeThisPointer(interp, c, sizeof(Widget));

    Ch_VaEnd(interp, ap);
    return;
}

EXPORTCH void Widget_dWidget_chdl(void *varg)
{
    ChInterp_t interp;
    ChVaList_t ap;
    class Widget *w;

    Ch_VaStart(interp, ap, varg);
    w=Ch_VaArg(interp, ap, class Widget *);
    if(Ch_CppIsArrayElement(interp)){
        w->~Widget();
    }
    else{
        delete w;
    }
    Ch_VaEnd(interp, ap);
    return;
}

EXPORTCH void TestClass_TestClass_chdl(void *varg) {
    ChInterp_t interp;
    ChVaList_t ap;
    class TestClass *c;

    Ch_VaStart(interp, ap, varg);  
    c = new TestClass();
    Ch_CppChangeThisPointer(interp, c, sizeof(TestClass));

    Ch_VaEnd(interp, ap);
    return;
}

EXPORTCH void TestClass_dTestClass_chdl(void *varg) {
    ChInterp_t interp;
    ChVaList_t ap;
    class TestClass *c;

    Ch_VaStart(interp, ap, varg);
    c=Ch_VaArg(interp, ap, class TestClass *);
    if(Ch_CppIsArrayElement(interp)){
        c->~TestClass();
    }
    else{
        delete c;
    }
    Ch_VaEnd(interp, ap);
    return;
}

EXPORTCH void TestClass_func_chdl(void *varg) {
    ChInterp_t interp;
    ChVaList_t ap;
    class TestClass *c;
    class Widget *w;

    Ch_VaStart(interp, ap, varg);

    c=Ch_VaArg(interp, ap, class TestClass *);
    w=Ch_VaArg(interp, ap, class Widget *);
    c->func(*w);
    Ch_VaEnd(interp, ap);
    return;
}
