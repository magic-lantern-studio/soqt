/**************************************************************************\
 *
 *  This file is part of the Coin GUI toolkit libraries.
 *  Copyright (C) 1998-2002 by Systems in Motion.  All rights reserved.
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public License
 *  version 2.1 as published by the Free Software Foundation.  See the
 *  file LICENSE.LGPL at the root directory of this source distribution
 *  for more details.
 *
 *  If you want to use this library with software that is incompatible
 *  licensewise with the LGPL, and / or you would like to take
 *  advantage of the additional benefits with regard to our support
 *  services, please contact Systems in Motion about acquiring a Coin
 *  Professional Edition License.  See <URL:http://www.coin3d.org> for
 *  more information.
 *
 *  Systems in Motion, Prof Brochs gate 6, 7030 Trondheim, NORWAY
 *  <URL:http://www.sim.no>, <mailto:support@sim.no>
 *
\**************************************************************************/

/*!
  \class SoQtKeyboard SoQtKeyboard.h Inventor/Qt/devices/SoQtKeyboard.h
  \brief The SoQtKeyboard class ...
  \ingroup devices

  FIXME: write class doc
*/

#include <qevent.h>
#include <qkeycode.h>

#include <Inventor/SbDict.h>
#include <Inventor/events/SoKeyboardEvent.h>

#include <soqtdefs.h>
#include <Inventor/Qt/SoQtBasic.h>
#include <Inventor/Qt/devices/SoQtKeyboard.h>

#if HAVE_CONFIG_H
#include <config.h>
#endif // HAVE_CONFIG_H

#include <qmetaobject.h>
#include <moc_SoQtKeyboard.cpp>

// The reason for this is that SoQt _compiled_ against Qt versions
// 2.0.0 <= X < 2.2.0 should still detect keypad presses when _run_
// against Qt versions >= 2.2.0.
#define QT_KEYPAD_MASK_ASSUMED 0x4000

#if HAVE_QT_KEYPAD_DEFINE
#define QT_KEYPAD_MASK Qt::Keypad
#else // !HAVE_QT_KEYPAD_DEFINE
#define QT_KEYPAD_MASK QT_KEYPAD_MASK_ASSUMED
#endif // !HAVE_QT_KEYPAD_DEFINE

// *************************************************************************

SOQT_OBJECT_SOURCE(SoQtKeyboard);

// *************************************************************************

/*!
  \enum SoQtKeyboard::Events
  FIXME: write doc
*/

/*!
  \var SoQtKeyboard::Events SoQtKeyboard::KEY_PRESS
  FIXME: write doc
*/

/*!
  \var SoQtKeyboard::Events SoQtKeyboard::KEY_RELEASE
  FIXME: write doc
*/

/*!
  \var SoQtKeyboard::Events SoQtKeyboard::ALL_EVENTS
  FIXME: write doc
*/

// *************************************************************************

#if QT_VERSION < 200
#error Qt version too old!
#endif // QT_VERSION < 200

struct key1map {
  int from;                // Qt val
  SoKeyboardEvent::Key to; // So val
  char printable;
};

static struct key1map QtToSoMapping[] = {
  {Qt::Key_Escape, SoKeyboardEvent::ESCAPE, '.'},
  {Qt::Key_Tab, SoKeyboardEvent::TAB, '.'},
  {Qt::Key_Backspace, SoKeyboardEvent::BACKSPACE, '.'},
  {Qt::Key_Return, SoKeyboardEvent::RETURN, '.'},
  {Qt::Key_Enter, SoKeyboardEvent::ENTER, '.'},
  {Qt::Key_Insert, SoKeyboardEvent::INSERT, '.'},
#ifdef HAVE_SOKEYBOARDEVENT_DELETE
  {Qt::Key_Delete, SoKeyboardEvent::DELETE, '.'},
#else
  {Qt::Key_Delete, SoKeyboardEvent::KEY_DELETE, '.'},
#endif
  {Qt::Key_Pause, SoKeyboardEvent::PAUSE, '.'},
  {Qt::Key_Print, SoKeyboardEvent::PRINT, '.'},
  {Qt::Key_Home, SoKeyboardEvent::HOME, '.'},
  {Qt::Key_End, SoKeyboardEvent::END, '.'},
  {Qt::Key_Left, SoKeyboardEvent::LEFT_ARROW, '.'},
  {Qt::Key_Up, SoKeyboardEvent::UP_ARROW, '.'},
  {Qt::Key_Right, SoKeyboardEvent::RIGHT_ARROW, '.'},
  {Qt::Key_Down, SoKeyboardEvent::DOWN_ARROW, '.'},
  {Qt::Key_Prior, SoKeyboardEvent::PRIOR, '.'},
  {Qt::Key_PageUp, SoKeyboardEvent::PAGE_UP, '.'},
  {Qt::Key_Next, SoKeyboardEvent::NEXT, '.'},
  {Qt::Key_PageDown, SoKeyboardEvent::PAGE_DOWN, '.'},

  {Qt::Key_Shift, SoKeyboardEvent::LEFT_SHIFT, '.'},
  {Qt::Key_Control, SoKeyboardEvent::LEFT_CONTROL, '.'},
  {Qt::Key_Meta, SoKeyboardEvent::LEFT_ALT, '.'},
  {Qt::Key_Alt, SoKeyboardEvent::LEFT_ALT, '.'},
  {Qt::Key_CapsLock, SoKeyboardEvent::CAPS_LOCK, '.'},
  {Qt::Key_NumLock, SoKeyboardEvent::NUM_LOCK, '.'},
  {Qt::Key_ScrollLock, SoKeyboardEvent::SCROLL_LOCK, '.'},

  {Qt::Key_F1, SoKeyboardEvent::F1, '.'},
  {Qt::Key_F2, SoKeyboardEvent::F2, '.'},
  {Qt::Key_F3, SoKeyboardEvent::F3, '.'},
  {Qt::Key_F4, SoKeyboardEvent::F4, '.'},
  {Qt::Key_F5, SoKeyboardEvent::F5, '.'},
  {Qt::Key_F6, SoKeyboardEvent::F6, '.'},
  {Qt::Key_F7, SoKeyboardEvent::F7, '.'},
  {Qt::Key_F8, SoKeyboardEvent::F8, '.'},
  {Qt::Key_F9, SoKeyboardEvent::F9, '.'},
  {Qt::Key_F10, SoKeyboardEvent::F10, '.'},
  {Qt::Key_F11, SoKeyboardEvent::F11, '.'},
  {Qt::Key_F12, SoKeyboardEvent::F12, '.'},
  {Qt::Key_Space, SoKeyboardEvent::SPACE, ' '},
  {Qt::Key_Exclam, SoKeyboardEvent::NUMBER_1, '!'},
  {Qt::Key_QuoteDbl, SoKeyboardEvent::APOSTROPHE, '\"'},
  {Qt::Key_NumberSign, SoKeyboardEvent::NUMBER_3, '#'},
  {Qt::Key_Dollar, SoKeyboardEvent::NUMBER_4, '$'},
  {Qt::Key_Percent, SoKeyboardEvent::NUMBER_5, '%'},
  {Qt::Key_Ampersand, SoKeyboardEvent::NUMBER_6, '^'},
  {Qt::Key_Apostrophe, SoKeyboardEvent::APOSTROPHE, '\''},
  {Qt::Key_ParenLeft, SoKeyboardEvent::NUMBER_9, '('},
  {Qt::Key_ParenRight, SoKeyboardEvent::NUMBER_0, ')'},
  {Qt::Key_Asterisk, SoKeyboardEvent::NUMBER_8, '*'},
  {Qt::Key_Plus, SoKeyboardEvent::EQUAL, '+'},
  {Qt::Key_Comma, SoKeyboardEvent::COMMA, ','},
  {Qt::Key_Minus, SoKeyboardEvent::MINUS, '-'},
  {Qt::Key_Period, SoKeyboardEvent::PERIOD, '.'},
  {Qt::Key_Slash, SoKeyboardEvent::SLASH, '/'},
  {Qt::Key_0, SoKeyboardEvent::NUMBER_0, '0'},
  {Qt::Key_1, SoKeyboardEvent::NUMBER_1, '1'},
  {Qt::Key_2, SoKeyboardEvent::NUMBER_2, '2'},
  {Qt::Key_3, SoKeyboardEvent::NUMBER_3, '3'},
  {Qt::Key_4, SoKeyboardEvent::NUMBER_4, '4'},
  {Qt::Key_5, SoKeyboardEvent::NUMBER_5, '5'},
  {Qt::Key_6, SoKeyboardEvent::NUMBER_6, '6'},
  {Qt::Key_7, SoKeyboardEvent::NUMBER_7, '7'},
  {Qt::Key_8, SoKeyboardEvent::NUMBER_8, '8'},
  {Qt::Key_9, SoKeyboardEvent::NUMBER_9, '9'},
  {Qt::Key_Colon, SoKeyboardEvent::SEMICOLON, ':'},
  {Qt::Key_Semicolon, SoKeyboardEvent::SEMICOLON, ';'},
  {Qt::Key_Less, SoKeyboardEvent::COMMA, '<'},
  {Qt::Key_Equal, SoKeyboardEvent::EQUAL, '='},
  {Qt::Key_Greater, SoKeyboardEvent::PERIOD, '>'},
  {Qt::Key_Question, SoKeyboardEvent::BACKSLASH, '?'},
  {Qt::Key_At, SoKeyboardEvent::NUMBER_2, '@'},

  // zero means let SoKeyboardEvent handle the printable character
  {Qt::Key_A, SoKeyboardEvent::A, 0},
  {Qt::Key_B, SoKeyboardEvent::B, 0},
  {Qt::Key_C, SoKeyboardEvent::C, 0},
  {Qt::Key_D, SoKeyboardEvent::D, 0},
  {Qt::Key_E, SoKeyboardEvent::E, 0},
  {Qt::Key_F, SoKeyboardEvent::F, 0},
  {Qt::Key_G, SoKeyboardEvent::G, 0},
  {Qt::Key_H, SoKeyboardEvent::H, 0},
  {Qt::Key_I, SoKeyboardEvent::I, 0},
  {Qt::Key_J, SoKeyboardEvent::J, 0},
  {Qt::Key_K, SoKeyboardEvent::K, 0},
  {Qt::Key_L, SoKeyboardEvent::L, 0},
  {Qt::Key_M, SoKeyboardEvent::M, 0},
  {Qt::Key_N, SoKeyboardEvent::N, 0},
  {Qt::Key_O, SoKeyboardEvent::O, 0},
  {Qt::Key_P, SoKeyboardEvent::P, 0},
  {Qt::Key_Q, SoKeyboardEvent::Q, 0},
  {Qt::Key_R, SoKeyboardEvent::R, 0},
  {Qt::Key_S, SoKeyboardEvent::S, 0},
  {Qt::Key_T, SoKeyboardEvent::T, 0},
  {Qt::Key_U, SoKeyboardEvent::U, 0},
  {Qt::Key_V, SoKeyboardEvent::V, 0},
  {Qt::Key_W, SoKeyboardEvent::W, 0},
  {Qt::Key_X, SoKeyboardEvent::X, 0},
  {Qt::Key_Y, SoKeyboardEvent::Y, 0},
  {Qt::Key_Z, SoKeyboardEvent::Z, 0},
  {Qt::Key_BracketLeft, SoKeyboardEvent::BRACKETLEFT, '['},
  {Qt::Key_Backslash, SoKeyboardEvent::BACKSLASH, '\\'},
  {Qt::Key_BracketRight, SoKeyboardEvent::BRACKETRIGHT, ']'},
  {Qt::Key_AsciiCircum, SoKeyboardEvent::NUMBER_7, '&'},
  {Qt::Key_Underscore, SoKeyboardEvent::MINUS, '_'},
  {Qt::Key_BraceLeft, SoKeyboardEvent::BRACKETLEFT, '{'},
  {Qt::Key_Bar, SoKeyboardEvent::BACKSLASH, '|'},
  {Qt::Key_BraceRight, SoKeyboardEvent::BRACKETRIGHT, '}'},
  {Qt::Key_AsciiTilde, SoKeyboardEvent::GRAVE, '~'},
  {Qt::Key_unknown, SoKeyboardEvent::ANY, 0}
};

static struct key1map QtToSoMapping_kp[] = {
  {Qt::Key_Home, SoKeyboardEvent::PAD_7, '.'},
  {Qt::Key_End, SoKeyboardEvent::PAD_1, '.'},
  {Qt::Key_Left, SoKeyboardEvent::PAD_4, '.'},
  {Qt::Key_Up, SoKeyboardEvent::PAD_8, '.'},
  {Qt::Key_Right, SoKeyboardEvent::PAD_6, '.'},
  {Qt::Key_Down, SoKeyboardEvent::PAD_2, '.'},
  {Qt::Key_PageUp, SoKeyboardEvent::PAD_9, '.'},
  {Qt::Key_PageDown, SoKeyboardEvent::PAD_3, '.'},
  {Qt::Key_Enter, SoKeyboardEvent::PAD_ENTER, '.'},
  {Qt::Key_Delete, SoKeyboardEvent::PAD_DELETE, '.'},
  {Qt::Key_Insert, SoKeyboardEvent::PAD_INSERT, '.'},
  {Qt::Key_Plus, SoKeyboardEvent::PAD_ADD, '+'},
  {Qt::Key_Minus, SoKeyboardEvent::PAD_SUBTRACT, '-'},
  {Qt::Key_Period, SoKeyboardEvent::PAD_PERIOD, '.'},
  {Qt::Key_Asterisk, SoKeyboardEvent::PAD_MULTIPLY, '*'},
  {Qt::Key_Slash, SoKeyboardEvent::PAD_DIVIDE, '/'},
  {Qt::Key_Space, SoKeyboardEvent::PAD_SPACE, ' '},
  {Qt::Key_Tab, SoKeyboardEvent::PAD_TAB, '.'},
  {Qt::Key_F1, SoKeyboardEvent::PAD_F1, '.'},
  {Qt::Key_F2, SoKeyboardEvent::PAD_F2, '.'},
  {Qt::Key_F3, SoKeyboardEvent::PAD_F3, '.'},
  {Qt::Key_F4, SoKeyboardEvent::PAD_F4, '.'},
  {Qt::Key_0, SoKeyboardEvent::PAD_0, '0'},
  {Qt::Key_1, SoKeyboardEvent::PAD_1, '1'},
  {Qt::Key_2, SoKeyboardEvent::PAD_2, '2'},
  {Qt::Key_3, SoKeyboardEvent::PAD_3, '3'},
  {Qt::Key_4, SoKeyboardEvent::PAD_4, '4'},
  {Qt::Key_5, SoKeyboardEvent::PAD_5, '5'},
  {Qt::Key_6, SoKeyboardEvent::PAD_6, '6'},
  {Qt::Key_7, SoKeyboardEvent::PAD_7, '7'},
  {Qt::Key_8, SoKeyboardEvent::PAD_8, '8'},
  {Qt::Key_9, SoKeyboardEvent::PAD_9, '9'},
  {Qt::Key_unknown, SoKeyboardEvent::ANY, 0} // Ends table
};

static SbDict * translatetable = NULL;
static SbDict * kp_translatetable = NULL;

static void
soqtkeyboard_cleanup(void)
{
  delete translatetable;
  delete kp_translatetable;
}

// *************************************************************************

/*!
  Constructor. The \a mask specifies which keyboard-related events
  to handle. Others will just be ignored.
*/
SoQtKeyboard::SoQtKeyboard(int mask)
{
  this->eventmask = mask;
  this->kbdevent = NULL;

  // Protect against surprises in future Qt version (>= v3).
  static bool mask_tested = false;
  if (!mask_tested) {
    mask_tested = true;
    assert((QT_KEYPAD_MASK == QT_KEYPAD_MASK_ASSUMED) &&
           "value of Qt::Keypad has changed!");
  }
}

/*!
  Destructor.
*/
SoQtKeyboard::~SoQtKeyboard()
{
  delete this->kbdevent;
}

// *************************************************************************

/*!
  FIXME: write function documentation
*/

void
SoQtKeyboard::enable(
  QWidget *, // widget,
  SoQtEventHandler *, // handler,
  void *) // closure)
{
// FIXME: SOQT_STUB();
}

/*!
  FIXME: write function documentation
*/

void
SoQtKeyboard::disable(
  QWidget *, // widget,
  SoQtEventHandler *, // handler,
  void *) // closure)
{
// FIXME: SOQT_STUB();
}

// *************************************************************************

static void
make_translation_table(void)
{
  assert(translatetable == NULL);
  translatetable = new SbDict;
  kp_translatetable = new SbDict;

  int i = 0;
  while (QtToSoMapping[i].from != Qt::Key_unknown) {
    translatetable->enter((unsigned long)QtToSoMapping[i].from,
                          (void *)&QtToSoMapping[i]);
    i++;
  }

  i = 0;
  while (QtToSoMapping_kp[i].from != Qt::Key_unknown) {
    kp_translatetable->enter((unsigned long)QtToSoMapping_kp[i].from,
                             (void *)&QtToSoMapping_kp[i]);
    i++;
  }
}

// *************************************************************************

/*!
  FIXME: write function documentation
*/

const SoEvent *
SoQtKeyboard::translateEvent(QEvent * event)
{
  static SbBool verchk = FALSE;
  if (!verchk) {
    verchk = TRUE;
    // Qt v3.0.1 has a bug where SHIFT-PRESS + CTRL-PRESS +
    // CTRL-RELEASE results in that last key-event coming out
    // completely wrong under X11: as a press of key 0x1059
    // (Key_Direction_L). Known to be fixed in 3.0.3, unknown status
    // in 3.0.2 (so we warn anyway).  mortene.
    SbString s = qVersion();
#ifdef Q_WS_X11
    if (s == "3.0.0" || s == "3.0.1" || s == "3.0.2") {
      SoDebugError::postWarning("SoQtKeyboard::translateEvent",
                                "You are using Qt version %s, which is "
                                "known to contain keyboard handling bugs "
                                "under X11. Please upgrade.",
                                s.getString());
    }
#endif // Q_WS_X11
  }
    
  SbBool keypress = event->type() == QEvent::KeyPress;
  SbBool keyrelease = event->type() == QEvent::KeyRelease;

  // Qt 2 introduced "accelerator" type keyboard events.
  keypress = keypress || (event->type() == QEvent::Accel);
  keyrelease = keyrelease || (event->type() == QEvent::AccelAvailable);

  SbBool keyevent = keypress || keyrelease;

  if (keyevent && (this->eventmask & (KEY_PRESS|KEY_RELEASE))) {

    if (!translatetable) make_translation_table();

    QKeyEvent * keyevent = (QKeyEvent *)event;
    int key = keyevent->key();
    // Key code / sequence unknown to Qt.
    if (key == 0) return NULL;

    // Allocate system-neutral event object once and reuse.
    if (!this->kbdevent) this->kbdevent = new SoKeyboardEvent;

    // FIXME: check for Qt::Key_unknown. 19990212 mortene.

    SbBool keypad = (keyevent->state() & QT_KEYPAD_MASK) != 0;

    // Translate keycode Qt -> So
    void * table;
    if (keypad && kp_translatetable->find(key, table)) {
      struct key1map * map = (struct key1map*) table;
      this->kbdevent->setKey(map->to);
#if 0 // disabled. Breaks build when compiling against OIV
      if (map->printable) this->kbdevent->setPrintableCharacter(map->printable);
#endif // disabled
    } 
    else if (!keypad && translatetable->find(key, table)) {
      struct key1map * map = (struct key1map*) table;
      this->kbdevent->setKey(map->to);
#if 0 // disabled. Breaks build when compiling against OIV
      if (map->printable) this->kbdevent->setPrintableCharacter(map->printable);
#endif // disabled
    }
    else {
#if 0 // disabled. Breaks build when compiling against OIV
      this->kbdevent->setKey(SoKeyboardEvent::UNDEFINED);
      this->kbdevent->setPrintableCharacter((char) keyevent->ascii());
#else // disabled
      return NULL;
#endif
    }

    // Press or release?
    if (keyrelease) this->kbdevent->setState(SoButtonEvent::UP);
    else this->kbdevent->setState(SoButtonEvent::DOWN);

    // Need to mask in or out modifiers to get the correct state, as
    // the state() function gives us the situation immediately
    // _before_ the event happened.
    int state = keyevent->state();
    if (keypress) {
      switch (keyevent->key()) {
      case Qt::Key_Shift: state |= ShiftButton; break;
      case Qt::Key_Control: state |= ControlButton; break;
      case Qt::Key_Alt: state |= AltButton; break;
      case Qt::Key_Meta: state |= AltButton; break;
      }
    }
    else {
      switch (keyevent->key()) {
      case Qt::Key_Shift: state &= ~ShiftButton; break;
      case Qt::Key_Control: state &= ~ControlButton; break;
      case Qt::Key_Alt: state &= ~AltButton; break;
      case Qt::Key_Meta: state &= ~AltButton; break;
      }
    }

    // Modifiers
    this->kbdevent->setShiftDown(state & ShiftButton);
    this->kbdevent->setCtrlDown(state & ControlButton);
    this->kbdevent->setAltDown(state & AltButton);

    // FIXME: read QCursor::position() instead,
    // and clean up this mess. 19990222 mortene.
    this->setEventPosition(this->kbdevent,
                            SoQtDevice::getLastEventPosition().x(),
                            SoQtDevice::getLastEventPosition().y());

    // FIXME: wrong -- should be the time the Qt event happened. Can't
    // find support for getting hold of that information in
    // Qt. 19990211 mortene.
    this->kbdevent->setTime(SbTime::getTimeOfDay());
    return this->kbdevent;
  }

  return NULL;
}

// *************************************************************************
