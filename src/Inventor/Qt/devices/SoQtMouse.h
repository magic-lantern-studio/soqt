/**************************************************************************
 *
 *  This file is part of the Coin SoQt GUI binding library.
 *  Copyright (C) 1998-2000 by Systems in Motion.  All rights reserved.
 *
 *  This library is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License version
 *  2.1 as published by the Free Software Foundation.  See the file
 *  LICENSE.LGPL at the root directory of the distribution for all the
 *  details.
 *
 *  If you want to use Coin SoQt for applications not compatible with the
 *  LGPL, please contact SIM to acquire a Professional Edition License.
 *
 *  Systems in Motion, Prof Brochs gate 6, N-7030 Trondheim, NORWAY
 *  http://www.sim.no/ support@sim.no Voice: +47 22114160 Fax: +47 22207097
 *
 **************************************************************************/

//  $Id$

#ifndef SOQT_MOUSE_H
#define SOQT_MOUSE_H

#include <Inventor/Qt/devices/SoQtDevice.h>

class SoMouseButtonEvent;
class SoLocation2Event;

class SOQT_DLL_EXPORT  SoQtMouse : public SoQtDevice {
  typedef SoQtDevice inherited;
  Q_OBJECT

public:
  // FIXME: remove "SoQtMouse" in name, as its redundant. 19990620 mortene.
  enum SoQtMouseEventMask {
    ButtonPressMask = 0x01,
    ButtonReleaseMask = 0x02,
    PointerMotionMask = 0x04,
    ButtonMotionMask = 0x08,

    SO_QT_ALL_MOUSE_EVENTS = 0x0f
  };

  SoQtMouse(SoQtMouseEventMask mask = SO_QT_ALL_MOUSE_EVENTS);
  virtual ~SoQtMouse(void);

  virtual void enable( QWidget * widget, SoQtEventHandler * handler,
    void * closure );
  virtual void disable( QWidget * widget, SoQtEventHandler * handler,
    void * closure );

  virtual const SoEvent * translateEvent( QEvent * event );

private:
  SoMouseButtonEvent * buttonevent;
  SoLocation2Event * locationevent;
  SoQtMouseEventMask eventmask;

}; // class SoQtMouse

#endif // ! SOQT_MOUSE_H
