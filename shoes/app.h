//
// shoes/app.h
// Abstract windowing for GTK, Quartz (OSX) and Win32.
//
// This is really just a light wrapper around Cairo, which does most of the
// work anyway.  I'm not sure why they don't do this for ya.  Probably so I
// could do it in Shoes!!
//

#ifndef SHOES_APP_H
#define SHOES_APP_H

#include <cairo.h>
#include <ruby.h>

#define SHOES_APP_HEIGHT 500
#define SHOES_APP_WIDTH  600
#define SHOES_SHORTNAME  "shoes"
#define SHOES_APPNAME    "Shoes"
#define SHOES_VLCLASS    "Shoes VLC"
#define SHOES_SLOTCLASS  "Shoes Slot"
#define SHOES_HIDDENCLS  "Shoes Hidden"


#endif
