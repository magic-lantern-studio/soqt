/*-----------------------------------------------------------------------------
 *
 * (C) 1998 Spacetec IMC Corporation ("Spacetec").
 *
 * Permission to use, copy, modify, and distribute this software for all
 * purposes and without fees is hereby granted provided that this copyright
 * notice appears in all copies. Permission to modify this software is granted
 * and Spacetec will support such modifications only if said modifications are
 * approved by Spacetec.
 *
 */

/* Some code cleanup by the Coin team. Also added configure tests for
 * header files and added two methods:
 *
 * int SPW_CheckForSpaceballX11(void * display, int winid, char * product);
 * int SPW_TranslateEventX11(void * display, void * xevent, SPW_InputEvent * sbEvent);
 */

/* FIXME: isn't this really "pure" C code? If so, don't use a C++
   suffix on the file -- so we don't get tempted to pollute
   it. 20010821 mortene. */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif /* HAVE_CONFIG_H */

#if SOQT_DEBUG && 0 // debug
#define SPW_DEBUG 1
#endif // debug

#include "spwinput.h"

/* The setting of this define needs to be added manually to
   configure.in for all relevant projects. */
#ifndef HAVE_X11_AVAILABLE

/* just provide empty methods if X is not available */
int 
SPW_CheckForSpaceballX11(void *, int, char *)
{
  return 0;
}

int 
SPW_TranslateEventX11(void *, void *, SPW_InputEvent *)
{
  return 0;
}

#else /* HAVE_X11_AVAILABLE */

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#ifdef HAVE_UNISTD_H
#include <unistd.h>
#endif // HAVE_UNISTD_H
#ifdef HAVE_NETINET_IN_H
#include <netinet/in.h>
#endif /* HAVE_NETINET_IN_H */
#ifdef HAVE_SYS_TIME_H
#include <sys/time.h>
#endif /* HAVE_SYS_TIME_H */
#ifdef HAVE_SYS_TYPES_H
#include <sys/types.h>
#endif /* HAVE_SYS_TYPES_H */
#ifdef HAVE_SELECT_H
#include <select.h>
#endif /* HAVE_SELECT_H */

#define XLIB_ILLEGAL_ACCESS
#include <X11/Xlib.h>
#include <X11/Xutil.h>

#ifdef HAVE_X11_EXTENSIONS_SGIMISC_H
#include <X11/extensions/SGIMisc.h>
#elif HAVE_X11_XPROTO_H
#include <X11/Xproto.h>
#endif /* HAVE_X11_XPROTO */


#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
#include <X11/extensions/XInput.h>
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */


/* Callbacks for handling motion and button events */
typedef void (*SPW_InputMotionEventHandler)(Display *,float *,void *);
typedef void (*SPW_InputButtonEventHandler)(Display *,int,void *);
typedef int  (*SPW_InputOtherEventHandler)(Display *,XEvent *,void *);

/* Dispatch structure for SPW_InputDispatch */
typedef struct {
  Display                    * display;
  XEvent                     * xevent;
  SPW_InputEvent             * spwevent;
  int                         delay;
  SPW_InputMotionEventHandler handle_motion;
  SPW_InputButtonEventHandler handle_bpress;
  SPW_InputButtonEventHandler handle_brelease;
  SPW_InputOtherEventHandler  handle_other;
  void                       * pMotionAppData;
  void                       * pButtonAppData;
  void                       * pOtherAppData;
} SPW_InputDispatchStruct;

/* ------------------------------------------------------------------------ */

static int SPW_InputCheckForSpaceball(Display *, Window, char *);
static int SPW_InputIsSpaceballEvent (Display *, XEvent *, 
                                          SPW_InputEvent *);
static int SPW_InputXPending (Display *, int);
static void SPW_InputInitDispatchStruct (SPW_InputDispatchStruct *);
static int SPW_InputDispatch (SPW_InputDispatchStruct *);
static int SPW_InputDispatchEx (SPW_InputDispatchStruct *);

static void SPW_InputBeep (Display *, char *);
static void SPW_InputRezero (Display *);
static int SPW_GrabDevice(Display *display, Window window,
                                 int exclusive);
static int SPW_ReleaseDevice(Display * display);

#define SPW_InputDefaultDelay       0 /* 0 Hz update */

/*
  Wrapper function which makes it possible to avoid including X11 in the 
  header file.
*/
int 
SPW_CheckForSpaceballX11(void * display, int winid, char * product)
{
  return SPW_InputCheckForSpaceball((Display*) display, (Window) winid, product);
}

/*
  If xevent is a spaceball event, translates xevent to sbEvent and return 1.
  If xevent is not a spaceball event returns 0. void * pointers are 
  passed to avoid including the X header files in the spwinput.h header file.
*/
int
SPW_TranslateEventX11(void * display, void * xevent, SPW_InputEvent * sbEvent)
{
  return SPW_InputIsSpaceballEvent((Display*) display, (XEvent*) xevent, sbEvent);
}

/*
 *  This is the number of events before we stop asking the
 *  driver for handshaking information.
 *
 *  25 events/sec * 60 sec * 1 min = 1500  
 */
#define SPW_MaxEventCount 1500

/* these are all the Spaceball XCM atom names */
#define SPW_InputMotionAtomName           "SpaceballMotionEventType"
#define SPW_InputButtonPressAtomName      "SpaceballButtonPressEventType"
#define SPW_InputButtonReleaseAtomName    "SpaceballButtonReleaseEventType"
#define SPW_InputPassThruAtomName         "SpaceWarePassThruCommandEventType"

/* found the spaceball */
static int SpaceballFound = 0;

/* the spaceball is using XIE */
static int SpaceballInputExtension = 0;

/* the spaceball is using XCM */
static int SpaceWareAtomsDefined = 0;

/* the magic XCM window used for communication */
static Window SpaceWareXCMWindowID = 0;

/* the window ID that the spaceball data is sent to */
static Window ReturnWindowID = 0;

/* XSendEvent uses these types and Atoms to communicate with the driver */
static int SPW_DevMotionEventType;         /* Spaceball motion type */
static int SPW_DevButtonPressEventType;    /* Spaceball button press type */
static int SPW_DevButtonReleaseEventType;  /* Spaceball button release type */
static Atom SPW_InputMotionAtom;           /* Spaceball motion Atom */
static Atom SPW_InputButtonPressAtom;      /* Spaceball button press Atom */
static Atom SPW_InputButtonReleaseAtom;    /* Spaceball button release Atom */
static Atom SPW_InputPassThruAtom;  /* Main daemon communication Atom */

static Atom WM_SAVE_YOURSELF;               /* Atoms daemon will use */

#ifdef HAVE_X11_EXTENSIONS_XINPUT_H

static XID SpaceballDevID = 0;                 /* XIE ID for the Spaceball device */
static XDevice *pSpaceballDev = NULL;          /* The spaceball XIE structure */
static XEventClass SPW_SpaceballEventClass[3]; /* XIE Events classes          */

#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */


static char strData[19];      /* buffer used to store the string that 
                                 is to be sent to XCM daemon  */ 
static int SPW_strLength = 0; /* length of the strData string */


/*-----------------------------------------------------------------------------
 *
 * static Window FindXCMWindow (Display *display)
 *
 * Args:
 *    display     (r/o)  The display on which to search for the XCM window
 *
 * Return Value:
 *    The window ID of the XCM window.
 *
 * Description:
 *     Finds the window named "sballd_XCM" and returns it's window ID
 *
 * Notes:
 *     None.
 *
 *---------------------------------------------------------------------------*/
static Window 
FindXCMWindow (Display *display)
{
  Window root;      /* the root window for the display */
  Window parent;    /* parent window in the search tree */
  Window *children;  /* children windows of the parrent window */
  unsigned int  nChildren; /* number of children the parent window has */
  int i;         /* counter */

  /* if we already have the daemon window don't look again */
  if (SpaceWareXCMWindowID != 0) {
    return SpaceWareXCMWindowID;
  }

  XQueryTree(display, RootWindowOfScreen(DefaultScreenOfDisplay(display)),
             &root, &parent, &children, &nChildren);

  for (i = 0;  i < (int) nChildren; i++){
    char *name;
    int found = 0;

    XFetchName (display, children[i], &name);
    if (name) {
#ifdef SPW_DEBUG
      fprintf(stderr,"FindXCMWindow: %s\n", name);
#endif
      if (strcmp(name, "sballd_XCM") == 0) {
        found = 1;
      }
      XFree(name);
    }
     
    if (found == 1) {
      break;
    }
  }
   
  if (i == (int)nChildren) {
    SpaceWareXCMWindowID = 0;
  }
  else {
    SpaceWareXCMWindowID = children[i];
  }
   
  XFree((char *) children);
   
  if (SpaceWareXCMWindowID == 0)  {
    return False;
  }
  else  {
    return SpaceWareXCMWindowID;
  }
} /* end of FindXCMWindow */


/*-----------------------------------------------------------------------------
 *
 * static void StringFlush (Display *display, Window win)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *    win     (r/o)  The window that the XCM daemon replies to
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function sends the string that is in the strData buffer to the
 *    XCM window.  Once it is send it clears the strData buffer.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
static void StringFlush (Display *display, Window win)
{
  XClientMessageEvent event; /* event used to send string to XCM daemon */
  int i;                     /* counter used to step through the string */
   
  /* if we don't already have the XCM window id find it */
  if (SpaceWareXCMWindowID == 0) {
    FindXCMWindow (display);
  }
  if (SpaceWareXCMWindowID == 0) {
    return;
  }

  if (SPW_strLength == 0) { /* if the string is empty do nothing */
    return;
  }
   
  /* set up the event structure for sending */
  event.type = ClientMessage;
  event.display = display;
  event.window = SpaceWareXCMWindowID;
  event.message_type = SPW_InputPassThruAtom;
  event.format = 8;
 
  /* copy the string into the event */ 
  for (i = 0; i < 15; i++) {
    event.data.b[i] = strData[i];
  }
  if (SPW_strLength > 15) {
    SPW_strLength = 15;
  }
   
  /* force zero on end of data */
  event.data.b[SPW_strLength] = 0;

  event.data.l[4] = (long)htonl(win);
  
#ifdef SPW_DEBUG
  fprintf (stderr,"StringFlush %s\n", event.data.b);
#endif

  /* send the string to the XCM daemon */
  if (XSendEvent (display, SpaceWareXCMWindowID, True, 0,
                  (XEvent *)&event) == 0) {
#ifdef SPW_DEBUG
    fprintf (stderr, "SPW_Input: XSendEvent failed!\n");
#endif
  }
  XSync (display,False);
   
  /* clear the buffer */
  SPW_strLength = 0;
} /* end of StringFlush */

/*-----------------------------------------------------------------------------
 *
 * static void SendString (Display *display, char *string)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *    string  (r/o)  The string that is sent to the XCM daemon
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function sends string to the XCM window and flushs the
 *    internal buffer.
 *
 * Notes:
 *    To flush the string call StringFlush.
 *
 *---------------------------------------------------------------------------*/
static void SendString (Display *display, char *string)
{
  int i; /* counter used to step through the string */
  
  /* copy the string into strData and send strData to the XCM driver */
  for (i = 0; i < (int) strlen (string); i++) {
    strData[SPW_strLength++] = string[i];
  }
  StringFlush (display, ReturnWindowID);
} /* end of String */


/*-----------------------------------------------------------------------------
 *
 * void SPW_InputString (Display *display, char *string)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *    string  (r/o)  The string that is sent to the XCM daemon
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function sends string to the XCM window using SendString.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/

void SPW_InputString (Display *display, char *string)
{
  SPW_strLength = 0;                     /* flush the internal buffer */
  SendString (display, string);          /* setup the string for sending */
}

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputResetGlobalVars (void)
 *
 * Args:
 *    None.
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function resets all the static global variable used in the Spaceball
 *    input function.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputResetGlobalVars (void)
{
  SpaceballFound = 0;
  SpaceballInputExtension = 0;
  SpaceWareAtomsDefined = 0;
  SpaceWareXCMWindowID = 0;
} /* end of SPW_InputResetGlobalVars */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputResetSpaceball (Display *display)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function resets the Spaceball attached to the display defined in
 *    the display variable. The daemon will reset all internal Spaceball
 *    variables to their default and rezeros the Spaceball itself.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputResetSpaceball (Display *display)
{
  SPW_strLength = 0;
  static char RESET[] = "RESET";
  SendString (display, RESET);
} /* end of SPW_InputResetSpaceball */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputCloseXIE (Display *display)
 *
 * Args:
 *    display (r/o)  The X Display to which the Spaceball is attached
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function closes all comunication with the Spaceball XIE driver.
 *
 * Notes:
 *    When the XIE driver is closed the Spaceball may lose power.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputCloseXIE (Display *display)
{
#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  if (SpaceballInputExtension == 1) {
    XCloseDevice (display, pSpaceballDev);
    
    SpaceballInputExtension = 0;
    SpaceballFound = 0;
  }
#endif
} /* end of SPW_InputCloseXIE */

/*-----------------------------------------------------------------------------
 *
 * int SPW_InputIsXIE (void)
 *
 * Args:
 *    None.
 *
 * Return Value:
 *    0 if XIE is disabled or 1 if it is enabled.
 *
 * Description:
 *    This function determines if the Spaceball XIE driver is enabled.
 *
 * Notes:
 *    This is exported from this library so users of this library
 *    can determine the method of communication used.
 *
 *---------------------------------------------------------------------------*/
int SPW_InputIsXIE (void)
{
  return SpaceballInputExtension;
} /* end of SPW_InputIsXIE */

/*-----------------------------------------------------------------------------
 *
 * int SPW_InputIsXCM (void)
 *
 * Args:
 *    None.
 *
 * Return Value:
 *    0 if XCM is disabled or 1 if it is enabled.
 *
 * Description:
 *    This function determines f the Spaceball XCM driver is enabled.
 *
 * Notes:
 *    This is exported from this library so users of this library
 *    can determine the method of communication used.
 *
 *---------------------------------------------------------------------------*/
int SPW_InputIsXCM (void)
{
  return SpaceWareAtomsDefined;
} /* end of SPW_InputIsXCM */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputSelectExtensionEvent (Display *display, Window window)
 *
 * Args:
 *    display (r/o)  The X Display to which the Spaceball is attached
 *    window  (r/o)  What window to check for extension events
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    Check to see if the Spaceball XInput Extension is enabled.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputSelectExtensionEvent (Display *display, Window window)
{

#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  XSelectExtensionEvent (display, window, SPW_SpaceballEventClass, 3);
#endif

} /* end of SPW_InputSelectExtensionEvent */


/*-----------------------------------------------------------------------------
 *
 * void SPW_SendHandshake(Display *display)
 *
 * Args:
 *    display     (r/o)  The display on which to send the message
 *
 * Return Value:
 *    None
 *
 * Description:
 *    Sends a handshaking packet to the Xdaemon with what version of
 *    the software we are running.  Eventually we may even use this
 *    information.  Right now it's mainly to make sure that the soft
 *    button window gets the correct cache values.
 *
 * Notes:
 *    This function returns nothing, but sends a message to the Xdaemon.
 *    The message is sent to guaranty the daemon gets the window id
 *    of the application.
 *
 *---------------------------------------------------------------------------*/
void SPW_SendHandshake (Display *display)
{
  static char pHandshake[20]; /* store some space */
   
  if (SpaceWareXCMWindowID != 0) /* using daemon */
    {
      SPW_strLength = 0;
      pHandshake[0] = '\0';
      strcat (pHandshake, "~~SLIM V");
      strcat (pHandshake, SPW_INPUT_VERSION);
      strcat (pHandshake, "\r");

      SendString (display, pHandshake);
    } 
} /* end of SPW_SendHandshake */


/*-----------------------------------------------------------------------------
 *
 *  int SPW_GrabDevice(Display *display, Window window, int exclusive)
 *
 * Args:
 *    display     (r/o) The current display pointer
 *    window      (r/o) The window to send to
 *    exclusive   (r/o) Specify if the grab is exclusive
 *
 * Return Value:
 *    None
 *
 * Description:
 *    This function is used to signal the driver that the application wishes
 *    to "grab" the Spaceball device.  This prevents other applications from
 *    getting data from the device.  There are two possible grab modes: An
 *    exclusive grab forces the driver to send data to the application window
 *    regardless of what window has focus.  A non-exclusive grab forces the
 *    driver to send Spaceball data to the application window when no other
 *    Spaceball enabled window has focus.
 *
 * Notes:
 *    This function does not work with XIE.
 *    It is recommended that exclusive grab not be used.
 *    This function will change the ReturnWindowID if the window parameter
 *    is not NULL.
 *
 *---------------------------------------------------------------------------*/
int SPW_GrabDevice(Display *display, Window window,
                      int exclusive)
{
  if (window != 0) {
      ReturnWindowID = window;
  }

  if ((ReturnWindowID == 0) ||  /* return window not set */
      (SpaceWareXCMWindowID == 0)) {/* daemon not running */
    return 0;
  }

  SPW_strLength = 0;

  if (exclusive == 1)
    {
      static char hard[] = "~hard";
      SendString (display, hard);
    }
  else
    {
      static char soft[] = "~soft";
      SendString (display, soft);
    }

  return 1;
} /* end of SPW_GrabDevice */


/*-----------------------------------------------------------------------------
 *
 *  void SPW_ReleaseDevice(Display *display)
 *
 * Args:
 *    display     (r/o) The current display pointer
 *
 * Return Value:
 *    None
 *
 * Description:
 *    This function is used to release a grabbed device.  This frees the
 *    driver to send data to the application with focus regardless if it has
 *    been Spaceball enabled.
 *
 * Notes:
 *    This function does not work with XIE.
 *
 *---------------------------------------------------------------------------*/
int SPW_ReleaseDevice(Display *display)
{
  if ((ReturnWindowID == 0) ||  /* return window not set */
      (SpaceWareXCMWindowID == 0)) /* daemon not running */
    {
      return 0;
    }

  SPW_strLength = 0;
  static char relgrab[] = "~relgrab";
  SendString (display, relgrab); 
  return 1;
} /* end of SPW_ReleaseDevice */


/*-----------------------------------------------------------------------------
 *
 * static int FindXCMAtoms (Display *display)
 *
 * Args:
 *    display     (r/o)  The display on which to search for the XCM atoms
 *
 * Return Value:
 *    1 if the XCM atoms were found, 0 if not.
 *
 * Description:
 *     Returns True if all the XCM atoms are found.
 *
 * Notes:
 *      Has the side effect of looking up the atoms and putting the
 *      values in the SPW_Input...Atom variables
 *
 *---------------------------------------------------------------------------*/
static int FindXCMAtoms (Display *display)
{
  /* if we already have the atoms don't look again */
  if (SpaceWareAtomsDefined == 1)
    {
      return 1;
    }

  /* 
    *  Try to find the atoms; if X does not find the atoms it will try to 
    *  create them.
    */
  SPW_InputMotionAtom = XInternAtom(display, SPW_InputMotionAtomName, True);
  SPW_InputButtonPressAtom = XInternAtom(display, SPW_InputButtonPressAtomName,
                                         True);
  SPW_InputButtonReleaseAtom = XInternAtom(display, 
                                           SPW_InputButtonReleaseAtomName,True);

  SPW_InputPassThruAtom = XInternAtom(display,
                                      SPW_InputPassThruAtomName, True);

#ifdef SPW_DEBUG
  fprintf(stderr,"SPW_InputMotionAtom %d\n", SPW_InputMotionAtom);
  fprintf(stderr,"SPW_InputButtonPressAtom %d\n", SPW_InputButtonPressAtom);
  fprintf(stderr,"SPW_InputButtonReleaseAtom %d\n",SPW_InputButtonReleaseAtom);
  fprintf(stderr,"SPW_InputPassThruAtom %d\n", SPW_InputPassThruAtom);
#endif

  /* if any one of the atoms does not exist return a failure */
  if ((SPW_InputMotionAtom == None) ||
      (SPW_InputButtonPressAtom == None) ||
      (SPW_InputButtonReleaseAtom == None) ||
      (SPW_InputPassThruAtom == None))
    {
      return 0;
    }

  /* set the global that tells us the atoms are defined and found */
  SpaceWareAtomsDefined = 1;
  return 1;
} /* end of FindXCMAtoms */

/*-----------------------------------------------------------------------------
 *
 * static int FindXCM (Display *display)
 *
 * Args:
 *    display      (r/o)  The display on which to search for the XCM window
 *
 * Return Value:
 *     Returns 1 if the XCM driver is found, 0 if not.
 *
 * Description:
 *     Find the XCM driver (window and atoms).  This function is used
 *     to check if the driver is running because if the atoms exist
 *     then the driver is running. 
 *
 * Notes:
 *     None.
 *
 *---------------------------------------------------------------------------*/
static int FindXCM (Display *display)
{
  unsigned long win;   /* the XCM window */
  int atom;  /* boolean that tell us if we found the atoms */
  
  win = FindXCMWindow (display);
  atom = FindXCMAtoms (display);

#ifdef SPW_DEBUG
  fprintf(stderr, "win %d atom %d\n", win, atom);
#endif

  if ((win != 0) && (atom == 1)) {
      return 1;
  }
  
  return 0;
} /* end of FindXCM */

/*-----------------------------------------------------------------------------
 *
 * int SPW_FindXIE (Display *display)
 *
 * Args:
 *    display      (r/o)  The display on which to search for the XCM window
 *
 * Return Value:
 *     1 if the XIE driver was found, 0 if not.
 *
 * Description:
 *     Find the XIE Spaceball extension.
 *
 * Notes:
 *     None.
 *
 *---------------------------------------------------------------------------*/

int SPW_FindXIE (Display *display)
{
#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  int          ieMajor;      
  int          ieFirstEvent; 
  int          ieFirstError; 
  int          nDev;         
  XDeviceInfo *pDev;         
  int          i,j;          
  char        *ptr;          

  /* if we have already found the XIE driver don't look again */
  if (SpaceballInputExtension == 1)
    {
      return 1;
    }

  /* See if XIE is configured */
  if (XQueryExtension (display, "XInputExtension", &ieMajor,
                       &ieFirstEvent, &ieFirstError) == 0)
    {
      return 0;
    }

#ifdef SPW_DEBUG
  fprintf (stderr, "SPW_FindXIE()  Extension found\n");
#endif

  /* get a list of available XIE devices */
  pDev = XListInputDevices (display, &nDev);

  /* Make sure there are valid devices */
  if (pDev == 0) {
      return 0;
  }

  /* Try to find the Spaceball device in the list */
  for (i = 0; i < nDev; i++) {
#ifdef SPW_DEBUG
    fprintf (stderr, "SPW_FindXIE()  device %s\n", pDev[i].name);
#endif
    /* Compare against type name per device */
    if (strcmp(pDev[i].name, XI_SPACEBALL) == 0) break;
  }

  /*
   * if we have gone past the end of the list then no Spaceball XIE
   * driver was found
   */
  if (i == nDev) {
    XFreeDeviceList (pDev);
    return 0;
  }
  
  /* record all necessary info on the Spaceball XIE driver */
  SpaceballDevID = pDev[i].id;
  pSpaceballDev = XOpenDevice (display, SpaceballDevID);
  
  /* clean up the device list */ 
  XFreeDeviceList (pDev);

  /* enable the Spaceball callbacks */
  DeviceMotionNotify (pSpaceballDev, SPW_DevMotionEventType, 
                      SPW_SpaceballEventClass[0]);
  DeviceButtonPress (pSpaceballDev, SPW_DevButtonPressEventType, 
                     SPW_SpaceballEventClass[1]);
  DeviceButtonRelease (pSpaceballDev, SPW_DevButtonReleaseEventType, 
                       SPW_SpaceballEventClass[2]);
  SpaceballInputExtension = 1;

  return 1;
#else 
  return 0;
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */
} /* end of SPW_FindXIE */

/*-----------------------------------------------------------------------------
 *
 * static void InitializeSpaceball (Display *display, char *version)
 *
 * Args:
 *    display      (r/o)  The display on which to search for the XCM window
 *    version      (r/o)  the XCM driver version.
 *
 * Return Value:
 *     None.
 *
 * Description:
 *     Find the Spaceball via XIE or XCM.
 *
 * Notes:
 *     The returnWindow parameter is not set if the Spaceball is configured
 *     using XIE.
 *
 *---------------------------------------------------------------------------*/
static void InitializeSpaceball (Display *display, char *version)
{
  /* if we already found the Spaceball don't search again */
  if (SpaceballFound == 1) {
    return;
  }

  /* Create some more Atoms the Daemon uses  */
  (void)XInternAtom (display, "WM_PROTOCOLS", False);
  (void)XInternAtom (display, "WM_DELETE_WINDOW", False);

   /* search for the XIE driver first */
  if (SPW_FindXIE (display) == 1) {
    SpaceballFound = 1;
#ifdef SPW_DEBUG
    fprintf(stderr, "\n");
    fprintf(stderr, "Spaceball (R) device found,");
    fprintf(stderr, " using SpaceWare (R) XIE interface.\n");
    fprintf(stderr, "SpaceWare Version %s\n", version);
    fprintf(stderr, "Copyright (c) 1998 Spacetec IMC Corporation\n");
    fprintf(stderr, "All Rights Reserved\n");
#endif
  }  
  /* if we don't find the XIE driver search for the XCM driver */
  else if (FindXCM (display) == 1) {
    SpaceballFound = 1;
#ifdef SPW_DEBUG
    fprintf(stderr, "\n");
    fprintf(stderr, "Spaceball (R) device found,");
    fprintf(stderr, " using SpaceWare (R) XCM interface.\n");
    fprintf(stderr, "SpaceWare Version %s\n", version);
    fprintf(stderr, "Copyright (c) 1998 Spacetec IMC Corporation\n");
    fprintf(stderr, "All Rights Reserved\n");
#endif
  }  
} /* end of InitializeSpaceball */



/*-----------------------------------------------------------------------------
 *
 * int SPW_InputCheckForSpaceball (Display *display, Window window,
 *                                     char *product)
 *
 * Args:
 *    display   (r/o)  The display on which to search for the XCM window
 *    window    (r/o)  the window on the application side to send messages to.
 *    product   (r/o)  name of the application that is opening the Spaceball.
 *
 * Return Value:
 *     1 if the Spaceball was opened, 0 if not.
 *
 * Description:
 *     Find the Spaceball via XIE or XCM.
 *
 * Notes:
 *     The window parameter is not set if the Spaceball is configured
 *     using XIE.
 *
 *---------------------------------------------------------------------------*/
int SPW_InputCheckForSpaceball (Display *display, 
                                   Window window,
                                   char *product)
{
  char version[256]; /* The version of SpaceWare */
  int productlen;    /* length of the product string */

#ifdef SPW_DEBUG
  fprintf(stderr, "SPW_InputCheckForSpaceball window 0x%x product %s\n",
          window, product);
#endif

  /* check to make sure the corect parameters were passed */
  if ((display == NULL) || (window == 0)) {
      return 0;
  }

  /* build the SpaceWare version and product info string */
  strcpy (version, SPW_INPUT_VERSION);
  if (product != NULL) {
    productlen = strlen (product);
    if ((productlen > 0) && (productlen < 200)) {
      strcat(version, ".");
      strcat(version, product);
    }
  }

  /* save off the application window for future reference */ 
  if (ReturnWindowID == 0) {
    ReturnWindowID = window;
  }
  
  /* try to open the Spaceball */
  InitializeSpaceball (display, version);
  if (SpaceballFound == 0) {
    return 0;
  }

#ifdef HAVE_X11_EXTENSIONS_XINPUT_H

  /* If we're using XIE, try to enable Spaceball events */

  if (SPW_FindXIE (display) == 1) {
    XSelectExtensionEvent (display, window, SPW_SpaceballEventClass, 3);
  }
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */

  /* Send version info to the daemon */
  SPW_SendHandshake (display);

  /* we found the Spaceball so return a success message */
  return 1;

} /* end of SPW_InputCheckForSpaceball */


/*-----------------------------------------------------------------------------
 *
 * int SPW_InputIsSpaceballEvent (Display *display, XEvent *event, 
 *                                SPW_InputEvent *spwev)
 *
 * Args:
 *    display (r/o)  The display the Spaceball is attached to
 *    event   (r/o)  The event that we want to check
 *    spwev   (w/o)  The spaceball return structure contaning the spaceball data
 *
 * Return Value:
 *     True if the event is a spaceball event, False if not.
 *
 * Description:
 *     Determine if the event is a spaceball event and pack it into
 *     the spwev_ret structure.
 *
 * Notes:
 *     This function handles XCM as well as XIE events.
 *
 *---------------------------------------------------------------------------*/
int SPW_InputIsSpaceballEvent (Display *display, XEvent *event, 
                               SPW_InputEvent *spwev)
{
  static int shake_count = 0;     /* how many events have passed without */
  /* the daemon sending us a handshake   */
  static int last_shake = 0;      /* the last time we sent a handshake   */
  static int shake_delay = 7;     /* number of events we wait before     */
  /* sending another handshake message   */
  int isSpaceball=0;
  static int have_handshake = 0; /* did we get a handshake
                                        from daemon? */
  static int have_tune = 0; /* do we have the tune data yet */
  static float sbtune[6];      /* the tune multipliers */
  char *scaleVar;                   /* environment variable containg
                                       tune data */
  int  i;                           /* counter */

  /* if the event, display or spwev variables are not allocated then return */
  if ((display == NULL) || (event == NULL) || (spwev == NULL)) {
    return 0;
  }

#ifdef SPW_DEBUG
  fprintf(stderr,"SPW_InputIsSpaceballEvent type %d\n", event->type);
#endif

  /* the event is a spaceball event so deal with it */
  if (event->type == ClientMessage) {
    XClientMessageEvent *clientMessage = (XClientMessageEvent *) event;
#ifdef SPW_DEBUG
    fprintf(stderr,"   message_type %d\n", clientMessage->message_type);
#endif

    /* the event is a motion event */
    if (clientMessage->message_type == SPW_InputMotionAtom) {
      
      /* specify we found a spaceball event */
      isSpaceball = 1;

      /* specify the spaceball event is a motion event */
      spwev->type = SPW_InputMotionEvent;
      
      /* copy the spaceball data out of the event into the spwev structure */
      for (i = 0; i < 7; i++) {
        spwev->sData[i] = clientMessage->data.s[i + 2];
        spwev->fData[i] = (float) ((int) clientMessage->data.s[i + 2]);
      }
    }
      
    /* if the event is a button press event process it */
    else if (clientMessage->message_type == SPW_InputButtonPressAtom) {
      /* specify we found a spaceball event */
      isSpaceball = 1;
      
      /* specify the spaceball event is a button event */
      spwev->type = SPW_InputButtonPressEvent;
      
      /* copy the spaceball data out of the event into the spwev structure */
      spwev->buttonNumber = clientMessage->data.s[2];
      
    }
    
    /* if the event is a button release event process it */
    else if (clientMessage->message_type == SPW_InputButtonReleaseAtom) {
      /* specify we found a spaceball event */
      isSpaceball = 1;
      
      /* specify the spaceball event is a button event */
      spwev->type = SPW_InputButtonReleaseEvent;
      
      /* copy the spaceball data out of the event into the spwev structure */
      spwev->buttonNumber = clientMessage->data.s[2];
      
    }
    
    /* the event is a pass through event */
    else if (clientMessage->message_type == SPW_InputPassThruAtom) {
      char *str = clientMessage->data.b; /* data in the passthrough event */
      
      /* check if the pass through event is handshaking from the daemon */
      if ((str[0] == '~') && (str[1] == '~')) {
        have_handshake = 1;
      }
    }
    
    /* if we did get a spaceball event save the window ID we got it from */
    if (isSpaceball == 1) {
      /* if we don't know what the XCM window is yet save it off */
      if (SpaceWareXCMWindowID == 0) {
        SpaceWareXCMWindowID = ntohl(clientMessage->data.l[0]);
      }    
    }
  }  /* if (event->type == ClientMessage */

#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  /* check to see if the event is a spaceball XIE motion event */
  else if ((event->type == SPW_DevMotionEventType) &&
           (((XDeviceMotionEvent *)event)->deviceid == SpaceballDevID)) {
    /* cast the event to a XIE event */
    XDeviceMotionEvent *motion = (XDeviceMotionEvent *)event;
    int i;                                     /* Counter loop index */
    static float sbData[7];                    /* the spaceball data */

    /*
     * There is not enough room in an SGI X Input Extension event for all
     * 7 motion values (6 DOF data + period) the Spaceball produces.
     * Therefore, when we implement the Spaceball XIE we say it has
     * 7 axes and we send them in two separate XIE events.  The
     * period, axis 6, is sent alone in the first event; the 6 dof data
     * are sent in the next event.  First_axis and axes_count are set
     * correctly so the client code can figure out when it has a
     * complete event.
     *
     * This function returns 1 to indicate it was a Spaceball event.
     * In other words, it was not some other type of event the application
     * should handle.  BUT the spwev.type is set to 0 if it is not a
     * complete Spaceball motion event.  This should cause the switch
     * statement that is suppose to follow a call to this function to
     * ignore the event.
     */
    
    /* specify we found a spaceball event */
    isSpaceball = 1;
    
    /* specify the event is a motion event */
    spwev->type = SPW_InputMotionEvent;
    
    /* extract the spaceball motion data from the event */
    for (i = 0; i < (int) (motion->axes_count); i++) {
      sbData[motion->first_axis+i] = motion->axis_data[i];
    }
    
    /* the first axis will always be one, so this will work */
    if (motion->first_axis != 6) {
      for (i = 0; i < 7; i++) {
        spwev->fData[i] = sbData[i];
        spwev->sData[i] = (short)((int)sbData[i]);
      }
    }
    else {
      /* Only the period has been received, ignore event */
      spwev->type = 0;
    }
  }
  
  /* check to see if the event is a spaceball XIE button press event */
  else if ((event->type == SPW_DevButtonPressEventType) &&
           (((XDeviceButtonEvent *)event)->deviceid == SpaceballDevID)) {
    /* cast the event to a XIE event */
    XDeviceButtonEvent *button = (XDeviceButtonEvent *) event;  
    
    /* specify we found a spaceball message */
    isSpaceball = 1;
    
    /* specify the message was a button press event */
    spwev->type = SPW_InputButtonPressEvent;
    
    /* copy the button data out of the event */
    spwev->buttonNumber = button->button;
    
  }
  
  /* check to see if the event is a spaceball XIE button release event */
  else if ((event->type==SPW_DevButtonReleaseEventType) &&
           (((XDeviceButtonEvent *)event)->deviceid == SpaceballDevID)) {
    /* cast the event to a XIE event */
    XDeviceButtonEvent *button = (XDeviceButtonEvent *) event;  
      
    /* specify we found a spaceball message */
    isSpaceball = 1;
    
    /* specify the message was a button press event */
    spwev->type = SPW_InputButtonReleaseEvent;
    
    /* specify the message was a button release event */
    spwev->buttonNumber = button->button;
    
  }
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */
  
  /*
   * if after all that we haven't determined the event to be a spaceball
   * event return a failure
   */
  if (isSpaceball == 0) {
    return 0;
  }
  
  /*
   *   If we haven't gotten a handshake packet from the daemon
   *   and it's still early in the process try again, otherwise
   *   say the daemon must be earlier than 7.0.  Basically we'll
   *   have sent out SPW_MaxEventCount/shake_delay handshake messages to the
   *   daemon without a response.
   */
  if ((have_handshake == 0) && (shake_count < SPW_MaxEventCount)) {
    if ((last_shake + shake_delay) == shake_count) {
      SPW_SendHandshake (display);
      last_shake = shake_count;
    }
    shake_count++;
  }
  
  /*  
   *  Tuning:  we want to have the option to tune an application without
   *  having to recompile it each time.  We will do this by setting the
   *  SBALL_TUNING variable and scaling the data by it.  This should only
   *  be used to get the constants to acutally put into the application.
   */

  if (spwev->type == SPW_InputMotionEvent) {
    if (have_tune == 0) {
      scaleVar = getenv("SBALL_TUNING");
      if (scaleVar != NULL) {
        sscanf(scaleVar, "%f %f %f %f %f %f", &sbtune[0],
               &sbtune[1],
               &sbtune[2],
                     &sbtune[3],
               &sbtune[4],
               &sbtune[5]);
      }
      else {          
        sbtune[0] = 1.0f;
        sbtune[1] = 1.0f;
        sbtune[2] = 1.0f;
        sbtune[3] = 1.0f;
        sbtune[4] = 1.0f;
        sbtune[5] = 1.0f;
      }
      have_tune = 1;
    }

    spwev->fData[0] *= sbtune[0];
    spwev->fData[1] *= sbtune[1];
    spwev->fData[2] *= sbtune[2];
    spwev->fData[3] *= sbtune[3];
    spwev->fData[4] *= sbtune[4];
    spwev->fData[5] *= sbtune[5];
    
    spwev->sData[0] = (int)(spwev->sData[0] * sbtune[0]);
    spwev->sData[1] = (int)(spwev->sData[1] * sbtune[1]);
    spwev->sData[2] = (int)(spwev->sData[2] * sbtune[2]);
    spwev->sData[3] = (int)(spwev->sData[3] * sbtune[3]);
    spwev->sData[4] = (int)(spwev->sData[4] * sbtune[4]);
    spwev->sData[5] = (int)(spwev->sData[5] * sbtune[5]);
  }
  
  return 1;
} /* end of SPW_InputIsSpaceballEvent */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputBeep (Display *display, char *string)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *    string  (r/o)  the Spaceball beep string
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function send a string to the XCM driver that will cause
 *    the spaceball to beep.  Each lower case character (a-z) results
 *    in a tone, and each upper case character (A-Z) results in a pause
 *    between tones.
 *    Example: cCcC - cause the ball to beep twice.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputBeep (Display *display, char *string)
{
  char sndStr[15];  /* the control string to be sent to the driver */

#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  /* if we are connected via XIE use that to beep the ball */
  if (SpaceballInputExtension == 1) {
#ifdef HAVE_X11_EXTENSIONS_SGIMISC_H
    /* SGI beep */
    int slen = strlen (string);
    static char buf[32];
    char *cp = buf;
    
    if (slen > 29) slen = 29;
    *cp++ = '\r';
    *cp++ = 'B';
    strcpy (cp, string);
    cp  += slen;
    *cp++ = '\r';
    *cp  = NULL;
    XSGIDeviceControl (display, (int)SpaceballDevID, "sbprivate", buf);
    XFlush (display);
    
#elif HAVE_X11_XPROTO_H 
    /* HP beep */
    int i = 0;
    int slen = strlen (string);
    XBellFeedbackControl cntrl;

#if defined(__cplusplus) || defined(c_plusplus)
    cntrl.c_class = BellFeedbackClass;
#else /* ! __cplusplus */
    cntrl.class = BellFeedbackClass;
#endif /* __cplusplus */
    cntrl.pitch = 'B';
    cntrl.percent = 0;
    while (i < slen) {
      cntrl.duration = (short) string[i++];
      XChangeFeedbackControl(display, pSpaceballDev,
                             DvPercent | DvPitch | DvDuration,
                             (XFeedbackControl *) &cntrl);
        }
#endif /* HAVE_XCHANGEFEEDBACKCONTROL */
    }
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */

  /* if we are not using XIE use XCM to communicate with the ball */
  if (SpaceballInputExtension == 0) {
    /* setup the string to be sent */
    SPW_strLength = 0;
    sndStr[0] = '\0';
    strcat (sndStr, "B");
    strcat (sndStr, string);
    strcat (sndStr, "\r");
    
    /* send the string */
    SendString (display, sndStr);
  }
} /* end of SPW_InputBeep */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputRezero (Display *display)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function causes the Spaceball to rezero at its current location.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputRezero (Display *display)
{
#ifdef HAVE_X11_EXTENSIONS_XINPUT_H
  /* if we are connected via XIE use that to rezero the ball */
  if (SpaceballInputExtension == 1)
    {
#ifdef HAVE_X11_EXTENSIONS_SGIMISC_H
      /* SGI rezero */
      static char *cmd = "\rZ\r";

      XSGIDeviceControl (display, (int)SpaceballDevID, "sbprivate", cmd);
      XFlush (display);

#elif HAVE_X11_XPROTO_H
      XBellFeedbackControl cntrl;

#if defined(__cplusplus) || defined(c_plusplus)
      cntrl.c_class = BellFeedbackClass;
#else /* ! __cplusplus */
      cntrl.class = BellFeedbackClass;
#endif /* __cplusplus */
      cntrl.pitch = 'Z';
      cntrl.percent = 0;
      cntrl.duration = 0;
      XChangeFeedbackControl (display, pSpaceballDev,
                              DvPercent | DvPitch | DvDuration, 
                              (XFeedbackControl *)&cntrl);
#endif /* HAVE_X11_XPROTO_H */
    }
#endif /* HAVE_X11_EXTENSIONS_XINPUT_H */

  /* if we are not using XIE use XCM to communicate with the ball */
  if (SpaceballInputExtension == 0) {
    /* setup the rezero string and send it */
    SPW_strLength = 0;
    static char Z[] = "Z\r";
    SendString (display, Z);
  }
} /* end of SPW_InputRezero */

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputSetPulseRate (Display *display, unsigned short rate)
 *
 * Args:
 *    display (r/o)  The X Display of which the XCM window is a resident
 *    rate    (r/o)  The rate at which the spaceball data is sent
 *
 * Return Value:
 *    None.
 *
 * Description:
 *    This function sets the Spaceball transmission rate.  Currently
 *    it is just stubed out since we don't want the transmission rate
 *    of the Spaceball to change.
 *
 * Notes:
 *    None.
 *
 *---------------------------------------------------------------------------*/
void SPW_InputSetPulseRate (Display *display, unsigned short rate)
{

}

/*-----------------------------------------------------------------------------
 *
 * int SPW_InputXPending (Display *display, int delay)
 *
 * Args:
 *    display (r/o)  The X Display on which the queue is resident
 *    delay   (r/o)  amount of time to wait for the next event in microseconds
 *
 * Return Value:
 *    Returns the number of event on the X queue.
 *
 * Description: 
 *    Wait for another Spaceball event to come in within the time delay.
 *
 * Notes:
 *    If delay is less than or equal to zero this just checks the queue
 *    without waiting.
 *
 *---------------------------------------------------------------------------*/
int SPW_InputXPending (Display *display, int delay)
{
  int            numevents;  /* the number of event on the X queue */
  struct timeval short_wait; /* time struct needed for select call */

  fd_set Xfds;

#ifdef SPW_DEBUG
  fprintf(stderr,"SPW_InputXPending\n");
#endif

  /* get the number of event waiting on the event queue */
  numevents = XPending (display);

#ifdef SPW_DEBUG
  fprintf(stderr,"   numevents %d delay %d\n", numevents, delay);
#endif

  /*
   * if there are already event waiting or we have exceded the delay
   *  return the number of events on the queue
   */
  if ((numevents > 0) || (delay <= 0)) {
    return numevents;
  }

  /* use select to wait for the designated delay period */
  short_wait.tv_sec = 0;
  short_wait.tv_usec = (long) delay;
  FD_ZERO (&Xfds);
  FD_SET (ConnectionNumber (display), &Xfds);

  (void)select (ConnectionNumber (display) + 1, &Xfds, NULL,
                NULL, &short_wait);

  /* check the event queue again */
  numevents = XPending (display);

#ifdef SPW_DEBUG 
  fprintf(stderr,"   numevents %d\n", numevents);
#endif

  /* return the number of event on the queue */
  return numevents;
} /* end of SPW_InputXPending*/

/*-----------------------------------------------------------------------------
 *
 * void SPW_InputInitDispatchStruct (SPW_InputDispatchStruct *ds)
 *
 * Args: 
 *   ds     (w/o)  - input dispatch structure
 *
 * Return Value:
 *   None
 *
 * Description:
 *   Zeroizes a new dispatch structure and sets the default delay.
 *
 * Notes:
 *
 *----------------------------------------------------------------------------*/
void SPW_InputInitDispatchStruct (SPW_InputDispatchStruct * ds)
{
  memset(ds, (unsigned char)0, sizeof(SPW_InputDispatchStruct));
  ds->delay = SPW_InputDefaultDelay;
}

/*-----------------------------------------------------------------------------
 *
 * int SPW_InputDispatch (SPW_InputDispatchStruct *ds)
 *
 * Args: 
 *   ds     (r/o)  - input dispatch structure
 *
 * Return Value:
 *   1 if a redraw is required, 0 if a redraw is not required.
 *
 * Description:
 *   Determines what type of event has been returned by the Spaceball and calls
 *   the appropriate dispatch routine.
 *   SPW_InputMotionEventHandler - called if a motion event occured
 *   SPW_InputButtonEventHandler - called if a button event occured
 *   SPW_InputOtherEventHandler - called if a non-spaceball event occured
 *
 * Notes:
 *   if SPW_InputOtherEventHandler return a non-zero SPW_InputDispatch
 *   will dispose of the event and continue processing events.
 *
 *----------------------------------------------------------------------------*/

int SPW_InputDispatch (SPW_InputDispatchStruct *ds)
{
  float    data[7];          /* place to store Spaceball event data */
  int      i;                /* loop counter */
  int      motion_events;    /* flag tells if we have motion event*/
  int  event_pending;    /* flag tells if ther's an event pending */
  int      all_zero_event;   /* flag set if there's an all zero event */
  int  redraw;           /* redraw flag */
  int  continue_loop;    /* flag to keep while loop running */

  /* initialize variable */
  redraw = 0;
  motion_events=0;
  event_pending=1;
  all_zero_event=0;
  redraw = 0;
  continue_loop=1;

#ifdef SPW_DEBUG
  fprintf(stderr,"SPW_InputDispatch\n");   /* show where we are */
#endif

  /* if dispatch struct is empty, return to caller */
  if (ds == NULL)  
    {
      return 0;
    }

  /* initialize local event data structure */
  for (i = 0; i < 7; i++) 
    {
      data[i] = 0.0f;
    }

  /* compress event data while it keeps on coming */
  while (continue_loop == 1)
    {

#ifdef SPW_DEBUG
      fprintf(stderr,"   spwevent type %d\n", ds->spwevent->type);
#endif

      /* see what type of event we have */
      switch(ds->spwevent->type) 
        {
        case SPW_InputMotionEvent:
          motion_events++;

          /* Check for a no motion event */
          if ((ds->spwevent->fData[0] == 0.0) && 
              (ds->spwevent->fData[1] == 0.0) &&
              (ds->spwevent->fData[2] == 0.0) && 
              (ds->spwevent->fData[3] == 0.0) &&
              (ds->spwevent->fData[4] == 0.0) && 
              (ds->spwevent->fData[5] == 0.0))
            {
              all_zero_event++; /* keep track of how many we have */
            }

          /* add data into local structure */
          for (i = 0; i < 7; i++)
            {
              data[i] += ds->spwevent->fData[i];
            }

#ifdef SPW_DEBUG
          fprintf(stderr,"   %f %f %f %f %f %f %f\n", data[0],data[1],data[2],
                  data[3],data[4],data[5],data[6]);
#endif

          break;
        case SPW_InputButtonPressEvent:    /* button press event */
          /* if button press event handler function pointer is present */
          if (ds->handle_bpress != 0) 
            {
              (*(ds->handle_bpress)) (ds->display, ds->spwevent->buttonNumber,
                                      ds->pButtonAppData);
            }

          /* check for rezero button */
          if (ds->spwevent->buttonNumber == 9)
            {
              for (i = 0; i < 6; i++)
                {
                  data[i] = 0.0f;   /* zero data structure */
                }
              motion_events = 0;   /* reset number of motion events */
            }
          break;
        case SPW_InputButtonReleaseEvent:    /* button release event */

          if (ds->handle_brelease != 0)
            {
              (*(ds->handle_brelease)) (ds->display,ds->spwevent->buttonNumber,
                                        ds->pButtonAppData);
            }
          /* check for rezero button */
          if (ds->spwevent->buttonNumber == 9)
            {
              for (i = 0; i < 6; i++)
                {
                  data[i] = 0.0f;      /* clear local data */
                }
              motion_events = 0;      /* reset number of motion events */
              redraw = 1;
            }
          break;
        default:
          break;
        }  /* end of case statement */

      /* check if input is pending */
      if (SPW_InputXPending (ds->display, ds->delay))  
        {
          XNextEvent (ds->display, ds->xevent);         /* get an event */

          /* if it's not a Spaceball event see if we should continue */
          if (SPW_InputIsSpaceballEvent (ds->display, ds->xevent,
                                         ds->spwevent) == 0)
            {
              /* if we have an event handler...*/
              if (ds->handle_other != 0)
                {
                  /* handle event and get loop status */
                  continue_loop = (ds->handle_other)
                    (ds->display, ds->xevent, ds->pOtherAppData);
                }
              else
                {
                  continue_loop = 0; /* no event handler -> bail */
                }
            }
        }
      else  /* no more events to compress */
        {
          event_pending = 0;
          continue_loop = 0;   
        }
    } /* end of while loop */

#ifdef SPW_DEBUG
  fprintf(stderr,"   event_pending %d motion_events %d all_zero_event %d\n",
          event_pending, motion_events, all_zero_event);
#endif

  /* push unwanted event back onto the stack */
  if (event_pending == 1)
    {
      XPutBackEvent(ds->display, ds->xevent);
    }

  /* average event data by the period of the Spaceball data */
  if (data[6] != 0.0)
    {
      for (i = 0; i < 6; i++)
        {
          data[i] /= data[6];
        }
    }

#ifdef SPW_DEBUG
  fprintf(stderr,"ave %f %f %f %f %f %f\n\n", data[0], data[1], data[2], 
          data[3], data[4], data[5]);
#endif

  /* if we have a motion event handler... */
  if (ds->handle_motion != 0)
    {
      /* if there are motion events, handle them and force a redraw */
      if (motion_events != 0) 
        {
          (*(ds->handle_motion)) (ds->display, data, ds->pMotionAppData);
          redraw = 1;
        }
      
      if ((all_zero_event != 0) && (motion_events > 1))
        {
          for (i = 0; i < 6; i++)
            {
              data[i] = 0.0f;   /* reset data */
            }

          /* handle motion and force a redraw */
          (ds->handle_motion) (ds->display, data, ds->pMotionAppData);
          redraw = 1;
        }
    }

  return redraw;
} /* end of SPW_InputDispatch */

/*-----------------------------------------------------------------------------
 *
 * int SPW_InputDispatchEx (SPW_InputDispatchStruct *ds)
 *
 * Args: 
 *   ds     (r/o)  - input dispatch structure
 *
 * Return Value:
 *   1 if a redraw is required, 0 if a redraw is not required.
 *
 * Description:
 *   Determines what type of event has been returned by the Spaceball and calls
 *   the appropriate dispatch routine.
 *   SPW_InputMotionEventHandler - called if a motion event occured
 *   SPW_InputButtonEventHandler - called if a button event occured
 *   SPW_InputOtherEventHandler - called if a non-spaceball event occured
 *
 * Notes:
 *   An optimized and more cooperative version of SPW_InputDispatch().
 *   if SPW_InputOtherEventHandler returns non-zero, SPW_InputDispatchEx
 *   will dispose of the event and continue compressing motion events.
 *   If zero is returned, this function will dump all accumalated motion
 *   events (unlike its predecessor) and quickly return control back to 
 *   the app.  Also, the standard Xlib call XPending() is used instead of
 *   SPW_InputXPending().
 *
 *----------------------------------------------------------------------------*/

int SPW_InputDispatchEx (SPW_InputDispatchStruct *ds)
{
  float data[7]; /* place to store Spaceball event data */
  int i; /* loop counter */
  int motion_events; /* flag tells if we have motion event*/
  int all_zero_event; /* flag set if there's an all zero event */
  int redraw; /* redraw flag */
  int continue_loop; /* flag to keep while loop running */

  /* initialize variable */
  redraw = 0;
  motion_events=0;
  all_zero_event=0;
  redraw = 0;
  continue_loop=1;

#ifdef SPW_DEBUG
  fprintf(stderr,"SPW_InputDispatch\n");  /* show where we are */
#endif

  /* if dispatch struct is empty, return to caller */
  if (ds == NULL)
    {
      return 0;
    }

  /* initialize local event data structure */
  for (i = 0; i < 7; i++)
    {
      data[i] = 0.0f;
    }

  /* compress event data while it keeps on coming */
  while (continue_loop == 1)
    {

#ifdef SPW_DEBUG
      fprintf(stderr,"   spwevent type %d\n", ds->spwevent->type);
#endif

      /* make sure we have ball data */
      SPW_InputIsSpaceballEvent (ds->display, ds->xevent, ds->spwevent);

      /* see what type of event we have */
      switch(ds->spwevent->type)
        {
        case SPW_InputMotionEvent:
          motion_events++;

          /* Check for a no motion event */
          if ((ds->spwevent->fData[0] == 0.0) &&
              (ds->spwevent->fData[1] == 0.0) &&
              (ds->spwevent->fData[2] == 0.0) &&
              (ds->spwevent->fData[3] == 0.0) &&
              (ds->spwevent->fData[4] == 0.0) &&
              (ds->spwevent->fData[5] == 0.0))
            {
              all_zero_event++; /* keep track of how many we have */
            }

          /* add data into local structure */
          for (i = 0; i < 7; i++)
            {
              data[i] += ds->spwevent->fData[i];
            }

#ifdef SPW_DEBUG
          fprintf(stderr,"   %f %f %f %f %f %f %f\n",
                  data[0],data[1],data[2],
                  data[3],data[4],data[5],data[6]);
#endif

          break;
        case SPW_InputButtonPressEvent:    /* button press event */
          /* if button press event handler function pointer is present */
          if (ds->handle_bpress != 0)
            {
              (*(ds->handle_bpress)) (ds->display, ds->spwevent->buttonNumber,
                                      ds->pButtonAppData);
            }

          /* check for rezero button */
          if (ds->spwevent->buttonNumber == 9)
            {
              for (i = 0; i < 6; i++)
                {
                  data[i] = 0.0f;   /* zero data structure */
                }
              motion_events = 0;   /* reset number of motion events */
            }
          break;
        case SPW_InputButtonReleaseEvent:    /* button release event */

          if (ds->handle_brelease != 0)
            {
              (*(ds->handle_brelease)) (ds->display,ds->spwevent->buttonNumber,
                                        ds->pButtonAppData);
            }
          /* check for rezero button */
          if (ds->spwevent->buttonNumber == 9)
            {
              for (i = 0; i < 6; i++)
                {
                  data[i] = 0.0f;      /* clear local data */
                }
              motion_events = 0;      /* reset number of motion events */
              redraw = 1;
            }
          break;
        default:
          break;
        }  /* end of case statement */

      /* check if input is pending */
      if (XPending (ds->display) > 0)
        {
          XPeekEvent (ds->display, ds->xevent);         /* look at an event */
          if (SPW_InputIsSpaceballEvent (ds->display, ds->xevent,
                                         ds->spwevent) == 1)
            {
              XEvent throw_away;
              XNextEvent (ds->display, &throw_away);   /* remove the event */
            }
          else    /* if it's not a Spaceball event see if we should continue */
            {
              /* if we have an event handler...*/
              if (ds->handle_other != NULL)
                {
                  /* handle event and get loop status */
                  continue_loop = (ds->handle_other)
                    (ds->display, ds->xevent, ds->pOtherAppData);
                  if (continue_loop == 1)
                    {
                      XNextEvent (ds->display, ds->xevent);  /* get next event */
                    }
                  else
                    {
                      motion_events = 0;  /* app needs control back, fast! */
                    }
                }
              else
                {
                  continue_loop = 0; /* no event handler -> bail */
                }
            }
        }
      else  /* no more events to compress */
        {
          continue_loop = 0;
        }
    } /* end of while loop */

#if defined(SPW_DEBUG) && 0 
  fprintf(stderr,"   event_pending %d motion_events %d all_zero_event %d\n",
          event_pending, motion_events, all_zero_event);
#endif

  /* average event data by the period of the Spaceball data */
  if (data[6] != 0.0)
    {
      for (i = 0; i < 6; i++)
        {
          data[i] /= data[6];
        }
    }

#ifdef SPW_DEBUG
  fprintf(stderr,"ave %f %f %f %f %f %f\n\n", data[0], data[1],
          data[2],
          data[3], data[4], data[5]);
#endif

  /* if we have a motion event handler... */
  if (ds->handle_motion != 0)
    {
      /* if there are motion events, handle them and force a redraw */
      if (motion_events != 0)
        {
          (*(ds->handle_motion)) (ds->display, data, ds->pMotionAppData);
          redraw = 1;
        }

      if ((all_zero_event != 0) && (motion_events > 1))
        {
          for (i = 0; i < 6; i++)
            {
              data[i] = 0.0f;   /* reset data */
            }

          /* handle motion and force a redraw */
          (ds->handle_motion) (ds->display, data, ds->pMotionAppData);
          redraw = 1;
        }
    }

  return redraw;

} /* end of SPW_InputDispatchEx */

#endif /* HAVE_X11_AVAILABLE */
