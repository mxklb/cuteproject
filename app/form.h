#ifndef FORM_H
#define FORM_H

#include <QWidget>
#include <QPaintEvent>

#include "mylib.h"
#include "otherlib.h"

namespace Ui {
class Form;
}

class Form : public QWidget
{
    Q_OBJECT

public:
    explicit Form(QWidget *parent = 0);
    ~Form();

protected:
    void timerEvent(QTimerEvent *event);
    void paintEvent(QPaintEvent *event);

private:
    Ui::Form *ui;
    MyLib *adder;
    OtherLib *subtr;
};

#endif // FORM_H
