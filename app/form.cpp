#include "form.h"
#include "ui_form.h"

#include <iostream>

using namespace std;

Form::Form(QWidget *parent) :
    QWidget(parent),
    ui(new Ui::Form)
{
    ui->setupUi(this);
    adder = new MyLib();
    subtr = new OtherLib();

    connect(ui->spinBoxAdd1, SIGNAL(editingFinished()), this, SLOT(additionChanged()));
    connect(ui->spinBoxAdd2, SIGNAL(editingFinished()), this, SLOT(additionChanged()));
    connect(ui->spinBoxSubt1, SIGNAL(editingFinished()), this, SLOT(subtractionChanged()));
    connect(ui->spinBoxSubt2, SIGNAL(editingFinished()), this, SLOT(subtractionChanged()));
}

Form::~Form()
{
    delete ui;
}


void Form::additionChanged()
{
    int result = adder->addition(ui->spinBoxAdd1->value(), ui->spinBoxAdd2->value());
    ui->addAim->setText( QString("= ") + QString::number(result) );
    cout << result << endl;
}

void Form::subtractionChanged()
{
    int result = subtr->subtraction(ui->spinBoxSubt1->value(), ui->spinBoxSubt2->value());
    ui->subtAim->setText( QString("= ") + QString::number(result) );
    cout << result << endl;
}
