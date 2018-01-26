#include "form.h"
#include "ui_form.h"

#include <iostream>
#include <QPainter>
#include <QDateTime>
#include <QtSvg>

using namespace std;

Form::Form(QWidget *parent) : QWidget(parent),
    ui(new Ui::Form)
{
    ui->setupUi(this);
    adder = new MyLib();
    subtr = new OtherLib();

    QFont font("Monospace");
    font.setStyleHint(QFont::TypeWriter);
    setFont(font);

    startTimer(333);
}

Form::~Form()
{
    delete ui;
}

// Render background svg logo
void Form::paintEvent(QPaintEvent *event)
{
    QPixmap pixmap = QIcon(":/cuteproject.svg").pixmap(size());
    if( pixmap.isNull() ) pixmap = QIcon(":/cuteproject.icns").pixmap(size());
    if( pixmap.isNull() ) pixmap = QIcon(":/cuteproject.ico").pixmap(size());
    if( pixmap.isNull() ) pixmap = QIcon(":/cuteproject.png").pixmap(size());
    pixmap = pixmap.scaled(size(), Qt::KeepAspectRatio, Qt::SmoothTransformation);

    QPainter painter(this);
    painter.setRenderHint(QPainter::Antialiasing);
    QPoint pixmapSize(pixmap.width()-1, pixmap.height()-1);
    QPoint position = window()->rect().bottomRight()/2 - pixmapSize/2;
    painter.drawPixmap(position, pixmap);

    QWidget::paintEvent(event);
}

// Draw random binary numbers art style
void Form::timerEvent(QTimerEvent *event)
{
    qsrand(QDateTime::currentMSecsSinceEpoch());
    double random1 = qrand();
    double random2 = qrand();
    int random3 = qrand();
    int random4 = qrand();

    ui->label_1->setText(QString("%1").arg((int)random1, 0, 2).left(8).replace("0", ".").replace("1", "|"));
    ui->label_2->setText(QString("%1").arg((int)random2, 0, 2).left(8).replace("0", ".").replace("1", "|"));
    ui->label_3->setText(QString("%1").arg(random3, 0, 2).left(8).replace("0", ".").replace("1", "|"));
    ui->label_4->setText(QString("%1").arg(random4, 0, 2).left(8).replace("0", ".").replace("1", "|"));

    QString addResult = QString("%1").arg((int)adder->addition(random1, random2), 0, 2).left(8);
    QString subResult = QString("%1").arg(subtr->subtraction(random3, random4), 0, 2).left(8);

    QString finalText;
    if( addResult == subResult )
        finalText = ".";

    ui->labelCenter->setText(finalText);

    QWidget::timerEvent(event);
}
