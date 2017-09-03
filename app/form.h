#ifndef FORM_H
#define FORM_H

#include <QWidget>
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

private:
    Ui::Form *ui;
    MyLib *adder;
    OtherLib *subtr;

private slots:
    void additionChanged(int value = 0);
    void subtractionChanged(int value = 0);
};

#endif // FORM_H
