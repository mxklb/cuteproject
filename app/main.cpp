#include <QApplication>
#include <QIcon>
#include "form.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    a.setWindowIcon(QIcon(":/cuteproject.ico"));
    Form w;
    w.show();
    return a.exec();
}
