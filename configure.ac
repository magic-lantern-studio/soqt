# **************************************************************************
# SoQt/configure.ac

m4_define([SOQT_MAJOR], [0])
m4_define([SOQT_MINOR], [10])
m4_define([SOQT_MICRO], [0])
m4_define([SOQT_BETA], [])

m4_define([VERSION_STRING], [SOQT_MAJOR.SOQT_MINOR.SOQT_MICRO[]SOQT_BETA])

m4_define([SOQT_ABI_CURRENT], [m4_eval((SOQT_MAJOR*20)+SOQT_MINOR)])
m4_define([SOQT_ABI_REVISION], [SOQT_MICRO])
m4_define([SOQT_ABI_AGE], [SOQT_MINOR])

# only used for Debian Linux (and not even there yet)
m4_define([SO_NUMBER], [m4_eval(SOQT_MAJOR*20)])

m4_define([MAC_FRAMEWORK_NAME_DEFAULT], [SoQt])
m4_define([MAC_FRAMEWORK_PREFIX_DEFAULT], [/Library/Frameworks])
m4_define([MAC_FRAMEWORK_VERSION_DEFAULT], [A])

# **************************************************************************

# TODO:
# configure tests for: dpkg-buildpackage, makensis

# **************************************************************************

AC_PREREQ(2.50)

AC_INIT([SoQt], [VERSION_STRING], [coin-support@coin3d.org])

AC_CONFIG_AUX_DIR([cfg])
AC_CONFIG_SRCDIR([src/Inventor/Qt/SoQt.cpp])

# **************************************************************************

AC_CANONICAL_SYSTEM

AC_ARG_ENABLE([msvc],
  [AC_HELP_STRING([--disable-msvc], [don't require MS Visual C++ on Cygwin])],
  [case $enableval in
  no | false) sim_ac_try_msvc=false ;;
  *)          sim_ac_try_msvc=true ;;
  esac],
  [sim_ac_try_msvc=true])

if $sim_ac_try_msvc; then
  SIM_AC_SETUP_MSVC_IFELSE([], [
    case $host in
    *-cygwin) SIM_AC_ERROR([no-msvc++]) ;;
    esac
  ])
fi

# **************************************************************************
# Library versioning. For information about our versioning strategy, see the
# document ``HACKING'' in the Coin CVS module.

AC_SUBST([SOQT_MAJOR_VERSION], [SOQT_MAJOR])
AC_SUBST([SOQT_MINOR_VERSION], [SOQT_MINOR])
AC_SUBST([SOQT_MICRO_VERSION], [SOQT_MICRO])
AC_SUBST([SOQT_BETA_VERSION], [SOQT_BETA])
AC_SUBST([SOQT_VERSION], [$SOQT_MAJOR_VERSION.$SOQT_MINOR_VERSION.$SOQT_MICRO_VERSION$SOQT_BETA_VERSION])

VERSION=$SOQT_VERSION

# Libtool versioning
AC_SUBST([LT_CURRENT], [SOQT_ABI_CURRENT])
AC_SUBST([LT_REVISION], [SOQT_ABI_REVISION])
AC_SUBST([LT_AGE], [SOQT_ABI_AGE])

AC_SUBST([SOQT_SO_VERSION], [SO_NUMBER])

AC_DEFINE_UNQUOTED([SOQT_MAJOR_VERSION], [$SOQT_MAJOR_VERSION],
  [Define to the major version of SoQt])
AC_DEFINE_UNQUOTED([SOQT_MINOR_VERSION], [$SOQT_MINOR_VERSION],
  [Define to the minor version of SoQt])
AC_DEFINE_UNQUOTED([SOQT_MICRO_VERSION], [$SOQT_MICRO_VERSION],
  [Define to the micro version of SoQt])
AC_DEFINE_UNQUOTED([SOQT_VERSION], ["$SOQT_VERSION"],
  [Version string for SoQt])

# **************************************************************************
# Miscellaneous options and initializations.

AM_INIT_AUTOMAKE([SoQt], [$VERSION])

# File to cram results from the configure tests into.
# we pit this in src/ to avoid having to add extra INCLUDES directives in
# MAkefile.am
AM_CONFIG_HEADER(src/config.h)

# Default to not building a static library.
# Can be overridden by the user with --enable-static.
AM_DISABLE_STATIC

# Turn off default maintainer make-rules -- use ./bootstrap instead.
AM_MAINTAINER_MODE

# Use C++ for configure tests and Libtool.
AC_PROG_CC
AC_PROG_CPP
AC_PROG_CXX
AC_PROG_CXXCPP
AC_LANG(C++)

AC_OBJEXT
AC_EXEEXT

# moved below AC_PROG_CC so -g is preserved in $C[XX]FLAGS - 20020110 larsa
if $BUILD_WITH_MSVC; then
  SIM_AC_SETUP_MSVCRT([
    CPPFLAGS="$CPPFLAGS $sim_ac_msvcrt_CPPFLAGS"
    CFLAGS="$CFLAGS $sim_ac_msvcrt_CFLAGS"
    CXXFLAGS="$CXXFLAGS $sim_ac_msvcrt_CXXFLAGS"
    LDFLAGS="$LDFLAGS $sim_ac_msvcrt_LDFLAGS"
    LIBS="$LIBS $sim_ac_msvcrt_LIBS"
    # sim_ac_msvcrt_LIBLIBS is set up at the end
    # sim_ac_msvcrt_LIBLDFLAGS is set up at the end
    LDFLAGS="$LDFLAGS $sim_ac_msvcrt_LIBLDFLAGS"
    LIBS="$LIBS $sim_ac_msvcrt_LIBLIBS"
    AC_SUBST([SOGUI_MSVC_LIBC], [$sim_ac_msvcrt])
  ])
fi

# Initialize libtool
if $BUILD_WITH_MSVC; then
  RANLIB=:
  export RANLIB
fi

SIM_AC_MAC_CPP_ADJUSTMENTS

AC_PROG_LIBTOOL

# **************************************************************************
if test x"$prefix" = x"NONE"; then
  prefix=/usr/local
fi

# These are used for constructing the soqt-config file.
AC_SUBST([SOGUI_EXTRA_CPPFLAGS], [$CPPFLAGS])
AC_SUBST([SOGUI_EXTRA_CFLAGS], [$CFLAGS])
AC_SUBST([SOGUI_EXTRA_CXXFLAGS], [$CXXFLAGS])
AC_SUBST([SOGUI_EXTRA_LDFLAGS], [$LDFLAGS])
AC_SUBST([SOGUI_EXTRA_LIBS], [$LIBS])

# SIM_EXPAND_DIR_VARS

# **************************************************************************

AC_ARG_WITH(
  [alternate],
  [AC_HELP_STRING([--with-alternate=string],
                  [specify name of alternate configuration])],
  [CONFIG=$withval],
  [CONFIG=default])

AC_SUBST(CONFIG)

AC_ARG_WITH(
  [suffix],
  [AC_HELP_STRING([--with-suffix=string],
                  [specify library name suffix (e.g. "_g")])],
  [SUFFIX=$withval],
  [SUFFIX=])

AC_SUBST(SUFFIX)

# **************************************************************************
# If you just want to generate docs, ignore all the build-related tests

sim_ac_build_library=true
AC_ARG_ENABLE(
  [build],
  AC_HELP_STRING([--disable-build], [disable configuring for library build]), [
  case $enableval in
    no) sim_ac_build_library=false ;;
    *)  ;;
  esac])

AM_CONDITIONAL(BUILD_LIBRARY, $sim_ac_build_library)

# *******************************************************************
# * Do we want to build the documentation?
# *******************************************************************

AC_ARG_VAR([htmldir],
           [destination for HTML docs (default ${datadir}/SoQt/html)])

AC_ARG_ENABLE(html,
  AC_HELP_STRING([--enable-html], [build and install SoQt HTML documentation]),
  [case $enableval in
    yes | true) want_html=yes ;;
    *)          want_html=no ;;
  esac],
  [want_html=no])

case $htmldir in
"")
  htmldir="$datadir/SoQt/html"
  ;;
/*)
  # do nothing - absolute path
  ;;
*)
  htmldir="\${prefix}/$htmldir"
  ;;
esac

AC_SUBST(htmldir)

AC_ARG_ENABLE(man,
  AC_HELP_STRING([--enable-man], [build and install SoQt man pages]),
  [case $enableval in
    yes | true) want_man=yes ;;
    *)          want_man=no ;;
  esac],
  [want_man=no])

# Used in the Doxygen parameter file.
AC_SUBST([SOQT_DOC_HTML], [`echo $want_html | tr '[a-z]' '[A-Z]'`])
AC_SUBST([soqt_html_dir], [`pwd`/html])
AC_SUBST([SOQT_DOC_MAN], [`echo $want_man | tr '[a-z]' '[A-Z]'`])
AC_SUBST([soqt_man_dir], [`pwd`/man])

soqt_build_dir=`pwd`
soqt_src_dir=`cd $srcdir; pwd`

AC_SUBST(soqt_build_dir)
AC_SUBST(soqt_src_dir)

AM_CONDITIONAL(BUILD_MANPAGES, test x"$want_man" = x"yes")
AM_CONDITIONAL(BUILD_HTMLPAGES, test x"$want_html" = x"yes")

if test x"$want_man" = x"yes"; then
  # Stop any attempts at using Doxygen under MSWin, as it's not working yet.
  case $host in
  *-cygwin) AC_MSG_ERROR([Sorry, Doxygen-generation of documentation does not work under Cygwin yet.]) ;;
  esac

  SIM_AC_CONFIGURATION_SETTING([manpage installation], [$mandir])
fi

if test x"$want_html" = x"yes"; then
  SIM_AC_CONFIGURATION_SETTING([HTML installation], [$htmldir])
fi

if test x"$want_html" != xno -o x"$want_man" != xno; then
  # Stop any attempts at using Doxygen under MSWin, as it's not working yet.
  case $host in
  *-cygwin) AC_MSG_ERROR([Sorry, Doxygen-generation of documentation does not work under Cygwin yet.]) ;;
  esac

  SIM_AC_DOXYGEN_TOOL([], [SIM_AC_ERROR([no-doxygen])])

  AC_PATH_PROG(sim_ac_perl_exe, perl, false, $PATH)
  if test x"$sim_ac_perl_exe" = xfalse; then
    AC_MSG_WARN(Could not find the Perl executable)
  fi
fi

# path_tag is used to identify paths in docs/coin.doxygen that needs to be
# transformed using cygpath under cygwin.

# FIXME: I disabled the doxy4win.pl substitution of the <PATH> tag, as the
# setup wasn't working for ``make distcheck'' for some reason, and it
# also made an extra dependency in our build environment: Perl.
# 20011211 mortene.

case $host in
*-cygwin) path_tag="<PATH>" ;;
*)        path_tag= ;;
esac

AC_SUBST(path_tag)

AM_CONDITIONAL([BUILD_METAFILES], [true])
AC_SUBST([meta_prefix], [moc_])

if $sim_ac_build_library; then

# **************************************************************************
# Header files we might want.

AC_CHECK_HEADERS([windows.h unistd.h sys/types.h sys/time.h X11/extensions/SGIMisc.h X11/Xproto.h X11/extensions/XInput.h netinet/in.h])

# *******************************************************************
# Instead of getenv() on most Win32 platforms (not Windows CE).

AC_MSG_CHECKING([for GetEnvironmentVariable() function])
AC_TRY_LINK([#include <windows.h>],
            [(void)GetEnvironmentVariable("FOOBAR", NULL, 0);],
  [AC_MSG_RESULT([yes])
  AC_DEFINE([HAVE_GETENVIRONMENTVARIABLE],1, [Define to use GetEnvironmentVariable() instead of getenv()])],
  [AC_MSG_RESULT([no])])

# **************************************************************************
# Search and set up necessary stuff to use Open Inventor or Coin.

## Run AC_PATH_XTRA outside the if-then-else-fi, as AC_PATH_XTRA
## AC_REQUIREs AC_PATH_X, which means AC_PATH_X will only get
## expanded on the first AC_PATH_XTRA, which means trouble when
## AC_PATH_XTRA uses $no_x="yes"? from AC_PATH_X to decide whether
## or not to define X_DISPLAY_MISSING on X11-less systems.

AC_PATH_XTRA

# $with_inventor is from within SIM_AC_HAVE_INVENTOR_IFELSE, and can
# be used here since the value is empty when it reaches this point
# unless it has been explicitly set.

AC_ARG_ENABLE(
  [inventor-debug],
  AC_HELP_STRING([--enable-inventor-debug],
                 [use debug version of TGS inventor]))

if test x"${with_inventor+set}" = x"set" &&
   test x"${with_inventor}" != x"no"; then

  # For Open Inventor linkage, we need to check for a shitload of libraries.

  SIM_AC_CHECK_DL([
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_dl_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_dl_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_dl_libs $SOGUI_EXTRA_LIBS"
  ])

  SIM_AC_CHECK_X11([
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_x11_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_x11_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_x11_libs $SOGUI_EXTRA_LIBS"
  ])

  if test x"$sim_ac_x11_avail" = xyes; then
    SIM_AC_CHECK_X11SHMEM(SOGUI_EXTRA_LIBS="$sim_ac_x11shmem_libs $SOGUI_EXTRA_LIBS")
    SIM_AC_CHECK_X11MU(SOGUI_EXTRA_LIBS="$sim_ac_x11mu_libs $SOGUI_EXTRA_LIBS")
    SIM_AC_CHECK_X11XID(SOGUI_EXTRA_LIBS="$sim_ac_x11xid_libs $SOGUI_EXTRA_LIBS")
  fi

  SIM_AC_CHECK_OPENGL([
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_gl_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_gl_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_gl_libs $SOGUI_EXTRA_LIBS"
    CPPFLAGS="$CPPFLAGS $sim_ac_gl_cppflags"
    LDFLAGS="$LDFLAGS $sim_ac_gl_ldflags"
    LIBS="$sim_ac_gl_libs $LIBS"
  ], AC_MSG_ERROR([needs an OpenGL-compatible development system installation]))

  SIM_AC_CHECK_GLU([
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_glu_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_glu_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_glu_libs $SOGUI_EXTRA_LIBS"
  ], AC_MSG_ERROR(needs the OpenGL utility library))

  SIM_AC_HAVE_INVENTOR_IFELSE(
    [CPPFLAGS="$sim_ac_inventor_cppflags $CPPFLAGS"
     LDFLAGS="$sim_ac_inventor_ldflags $LDFLAGS"
     LIBS="$sim_ac_inventor_libs $LIBS"
     SOGUI_EXTRA_CPPFLAGS="$sim_ac_inventor_cppflags $SOGUI_EXTRA_CPPFLAGS"
     SOGUI_EXTRA_LDFLAGS="$sim_ac_inventor_ldflags $SOGUI_EXTRA_LDFLAGS"
     SOGUI_EXTRA_LIBS="$sim_ac_inventor_libs $SOGUI_EXTRA_LIBS"],
    AC_MSG_ERROR(couldn't compile and link against Open Inventor))

  SIM_AC_CONFIGURATION_SETTING([Open Inventor brand], [SGI/TGS Inventor])
else

  SIM_AC_CHECK_HEADER_GL([
    CPPFLAGS="$CPPFLAGS $sim_ac_gl_cppflags"
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_gl_cppflags"
  ], [AC_MSG_ERROR([could not detect a gl.h header file])])

  SIM_AC_HAVE_COIN_IFELSE([
    CPPFLAGS="$CPPFLAGS $sim_ac_coin_cppflags"
    LDFLAGS="$LDFLAGS $sim_ac_coin_ldflags"
    LIBS="$sim_ac_coin_libs $LIBS"
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_coin_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_coin_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_coin_libs $SOGUI_EXTRA_LIBS"
  ], [AC_MSG_ERROR([couldn't compile and link against Coin])])

  SIM_AC_CHECK_X11_READY(
    [sim_ac_x11_ready=true],
    [sim_ac_x11_ready=false])

  if ! $sim_ac_x11_ready; then
    SIM_AC_CHECK_X11([
      CPPFLAGS="$CPPFLAGS $sim_ac_x11_cppflags"
      LDFLAGS="$LDFLAGS $sim_ac_x11_ldflags"
      LIBS="$sim_ac_x11_libs $LIBS"
      SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_x11_cppflags"
      SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_x11_ldflags"
      SOGUI_EXTRA_LIBS="$sim_ac_x11_libs $SOGUI_EXTRA_LIBS"
    ])
    # FIXME: we just implicitly assume that -lXext and -lXmu is available
    # if -lX11 is available from coin-config. Should really have macros
    # SIM_AC_CHECK_[X11SHMEM|X11MU]_READY. 20001116 mortene.
    if test x"$sim_ac_x11_avail" = xyes; then
      SIM_AC_CHECK_X11SHMEM([
        # LIBS="$sim_ac_x11shmem_libs $LIBS"
        SOGUI_EXTRA_LIBS="$sim_ac_x11shmem_libs $SOGUI_EXTRA_LIBS"
      ])
      SIM_AC_CHECK_X11MU([
        # LIBS="$sim_ac_x11mu_libs $LIBS"
        SOGUI_EXTRA_LIBS="$sim_ac_x11mu_libs $SOGUI_EXTRA_LIBS"
      ])
    fi
  fi
  SIM_AC_CHECK_X11XID([
	SOGUI_EXTRA_LIBS="$sim_ac_x11xid_libs $SOGUI_EXTRA_LIBS"
  ])
  SIM_AC_CONFIGURATION_SETTING([Open Inventor brand], [Coin])
fi

## We need this extra, final X11 check to set up the HAVE_X11_AVAILABLE
## define -- the X_DISPLAY_MISSING define provided by the built-in
## Autoconf X11 check is not strict enough.
SIM_AC_CHECK_X11_READY([AC_DEFINE([HAVE_X11_AVAILABLE],,
                          [define if it is possible to build against X11])])

# Check for the availability of this node (it is used in the hidden
# line rendering), which is not part of older Inventor implementations.
SIM_AC_HAVE_INVENTOR_NODE(SoPolygonOffset)

SIM_AC_HAVE_INVENTOR_FEATURE(
  [for SoKeyboardEvent::DELETE enum],
  [#include <Inventor/events/SoKeyboardEvent.h>], [
   /* This is either DELETE or KEY_DELETE */
   SoKeyboardEvent::Key key = SoKeyboardEvent::DELETE;],
  [HAVE_SOKEYBOARDEVENT_DELETE])

SIM_AC_HAVE_INVENTOR_FEATURE(
  [for SoMouseButtonEvent::BUTTON5 enum],
  [#include <Inventor/events/SoMouseButtonEvent.h>], [
   /* mouse wheel support needs BUTTON4 and BUTTON5 */
   SoMouseButtonEvent::Button button = SoMouseButtonEvent::BUTTON5;],
  [HAVE_SOMOUSEBUTTONEVENT_BUTTON5])

SIM_AC_HAVE_INVENTOR_FEATURE(
  [for SoCamera::setStereoMode() method],
  [#include <Inventor/nodes/SoPerspectiveCamera.h>],
  [/* SoCamera is abstract, so test with SoPerspectiveCamera */
   SoPerspectiveCamera * c = new SoPerspectiveCamera;
   c->setStereoMode(SoCamera::MONOSCOPIC);],
  [HAVE_SOCAMERA_SETSTEREOMODE])

# **************************************************************************
# Check that the Qt installation looks ok and include the
# necessary paths and link libraries.

# FIXME: why is this here? - it's duplicate from below AC_PROG_CC  20020110 larsa
# AC_PROG_CPP

if test x"$sim_ac_x11mu_avail" != xyes; then
  ## It's really QGL that depends on Xmu, not Qt. But we need to do this
  ## check before checking for the Qt library, not after, in case QGL is
  ## embedded into Qt.
  SIM_AC_CHECK_X11MU([SOGUI_EXTRA_LIBS="$sim_ac_x11mu_libs $SOGUI_EXTRA_LIBS"])
fi

SIM_AC_CHECK_QT([
  SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_qt_cppflags"
  SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_qt_ldflags"
  SOGUI_EXTRA_LIBS="$sim_ac_qt_libs $SOGUI_EXTRA_LIBS"
], [
  AC_MSG_ERROR([can't compile and link against Qt development kit])
])

SIM_AC_CHECK_QGL([
  SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_qgl_cppflags"
  SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_qgl_ldflags"
  SOGUI_EXTRA_LIBS="$sim_ac_qgl_libs $SOGUI_EXTRA_LIBS"
], [
  AC_MSG_ERROR([can't compile and link against the QGL extension library])
])

# Check misc capabilities of the Qt and QGL libraries which depends
# on the exact version available to us.
SIM_AC_QT_KEYPAD_DEFINE
SIM_AC_QWIDGET_SHOWFULLSCREEN
SIM_AC_QGLFORMAT_EQ_OP
SIM_AC_QGLFORMAT_SETOVERLAY
SIM_AC_QGLWIDGET_SETAUTOBUFFERSWAP

# **************************************************************************
# Spaceball support through Linux Joystick driver

if false; then
  SIM_AC_CHECK_JOYSTICK_LINUX([
    AC_DEFINE(HAVE_JOYSTICK_LINUX, ,
      [Define to enable Linux Joystick driver support])
    AC_DEFINE_UNQUOTED(SOXT_LINUX_JOYSTICK_DEVICE,
      "$sim_ac_joystick_linux_device",
      [Define this to device handle to fallback on])
  ])
  AM_CONDITIONAL(HAVE_JOYSTICK_LINUX, $sim_ac_joystick_linux_avail)
else
  AM_CONDITIONAL(HAVE_JOYSTICK_LINUX, false)
  SIM_AC_CONFIGURATION_SETTING([Joystick Device], [Disabled])
fi

# **************************************************************************
# Compiler control.

SIM_AC_COMPILE_DEBUG([
  CPPFLAGS="$CPPFLAGS -DSOQT_DEBUG=1"
], [
  CPPFLAGS="$CPPFLAGS -DSOQT_DEBUG=0"
])

SIM_AC_CHECK_VAR_FUNCTIONNAME

SIM_AC_DEBUGSYMBOLS
SIM_AC_RTTI_SUPPORT
SIM_EXCEPTION_HANDLING
SIM_PROFILING_SUPPORT
SIM_COMPILER_WARNINGS

# This is at least used to allow static compilation on Cygwin + MSWindows
# without hitting the SOQT_DLL / SOQT_NOT_DLL safety check.
CPPFLAGS="$CPPFLAGS -DSOQT_INTERNAL"


SIM_AC_SOGUI_STATIC_DEFAULTS

if $sim_ac_static_defaults; then
  SIM_AC_CONFIGURATION_SETTING([Static Materials], [Yes])
else
  SIM_AC_CONFIGURATION_SETTING([Static Materials], [No])
fi

if test -n "$SUFFIX"; then
  SIM_AC_CONFIGURATION_SETTING([SoQt library name suffix], [$SUFFIX])
fi

# **************************************************************************
# To test the Mac OS X framework setup on non-Mac systems, run configure
# with the --with-framework option.  20011029 larsa

AC_ARG_WITH([framework],
  [  --with-framework  Do Mac OS X-like framework installation
  --without-framework  Do regular installation on Mac OS X],
  [sim_ac_framework_name="MAC_FRAMEWORK_NAME_DEFAULT"
  case $withval in
  yes ) sim_ac_framework=true ;;
  no ) sim_ac_framework=false ;;
  * ) sim_ac_framework=true; sim_ac_framework_name="$withval" ;;
  esac],
  [sim_ac_framework_name="MAC_FRAMEWORK_NAME_DEFAULT"
  case $host_os in
  darwin* ) sim_ac_framework=true ;;
  * ) sim_ac_framework=false ;;
  esac])

# don't allow name to be overrided - just toggled on/off
sim_ac_framework_name="MAC_FRAMEWORK_NAME_DEFAULT"

AC_ARG_WITH([framework-prefix],
  [  --with-framework-prefix=<path>  (default: "MAC_FRAMEWORK_PREFIX_DEFAULT")],
  [sim_ac_framework_prefix="$withval"],
  [sim_ac_framework_prefix="MAC_FRAMEWORK_PREFIX_DEFAULT"])

# don't allow version to be overrided
# AC_ARG_WITH([framework-version],
#   [  --with-framework-version=<version>  (default: "MAC_FRAMEWORK_VERSION_DEFAULT")],
#   [sim_ac_framework_version="$withval"],
#   [sim_ac_framework_version="MAC_FRAMEWORK_VERSION_DEFAULT"])
sim_ac_framework_version="MAC_FRAMEWORK_VERSION_DEFAULT"

frameworkdir=
ivframeworkdir=
# we don't allow SoQt as framework if Coin isn't instralled as a framework
if $sim_ac_framework && $sim_ac_coin_desired && $sim_ac_coin_avail; then
  if test x"$CONFIG" != x"set"; then
    sim_ac_coin_frameworkdir=`$sim_ac_coin_configcmd --alternate=$CONFIG --frameworkdir 2>/dev/null`
  fi
  # FIXME: if the Coin detection/setup macro triggers on --alternate=$CONFIG,
  # we shouldn't fallback here :(  20020110 larsa
  if test x"$sim_ac_coin_frameworkdir" = x""; then
    sim_ac_coin_frameworkdir=`$sim_ac_coin_configcmd --frameworkdir 2>/dev/null`
  fi
  if test x"$sim_ac_coin_frameworkdir" = x""; then
    SIM_AC_CONFIGURATION_WARNING([Coin was not installed as a framework, so SoQt can't be either (option was disabled).])
    sim_ac_framework=false
    soqtincludedir=${includedir}/Inventor/Qt
    ivincludedir=
  else
    ivframeworkdir=$sim_ac_coin_frameworkdir
    ivincludedir=
    if test x"$ivframeworkdir" != x""; then
      ivincludedir=$ivframeworkdir/Headers
    fi
    frameworkdir=${sim_ac_framework_prefix}/${sim_ac_framework_name}.framework
    soqtincludedir=${sim_ac_framework_prefix}/${sim_ac_framework_name}.framework/Headers
  fi
else
  sim_ac_framework=false
  soqtincludedir=${includedir}/Inventor/Qt
  ivincludedir=
fi

AC_SUBST([ivframeworkdir])
AC_SUBST([frameworkdir])
AC_SUBST([soqtincludedir])

AC_SUBST([MAC_FRAMEWORK], [$sim_ac_framework])
AC_SUBST([MAC_FRAMEWORK_NAME], [$sim_ac_framework_name])
AC_SUBST([MAC_FRAMEWORK_PREFIX], [$sim_ac_framework_prefix])
AC_SUBST([MAC_FRAMEWORK_VERSION], [$sim_ac_framework_version])

AC_SUBST([nop], [])

AM_CONDITIONAL([MAC_FRAMEWORK], [$sim_ac_framework])

# for sub-configure in data/
export sim_ac_framework
export MAC_FRAMEWORK_NAME MAC_FRAMEWORK_PREFIX MAC_FRAMEWORK_VERSION

# **************************************************************************

AC_SUBST([COIN_COMPILER], ["$CXX"])
if $BUILD_WITH_MSVC; then
  # don't use wrapmsvc from source hierarchy when later using soqt-config.
  COIN_COMPILER="wrapmsvc"
fi

else # $sim_ac_build_library == false
  AC_SUBST([MOC], [moc])
fi

# Qt's moc wants Windows-style paths, so if the inputfile is an
# absolute Cygwin-style path it needs conversion.
AC_PATH_PROG(UNIX2WINPATH, cygpath, false)
if test x"$UNIX2WINPATH" = x"false"; then
  UNIX2WINPATH="echo"
else
  UNIX2WINPATH="CYGWIN= $UNIX2WINPATH -w"
fi
AC_SUBST([UNIX2WINPATH])

# **************************************************************************
# Variable substitutions for using libSoQt in the generic code.

AC_SUBST([Gui], [Qt])
AC_SUBST([gui], [qt])
AC_SUBST([GUI], [QT])
AC_SUBST([WIDGET], ["QWidget *"])
AC_SUBST([EVENT], ["QEvent *"])
AC_SUBST([COMPONENTHEADER], [Q_OBJECT])

case $host_os in
darwin*)
  SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS -Wl,-multiply_defined,suppress"
  ;;
esac

# **************************************************************************
# Remove redundant options from certain option lists.

SIM_AC_UNIQIFY_LIST(SOGUI_EXTRA_CPPFLAGS, -I$includedir $SOGUI_EXTRA_CPPFLAGS)
SIM_AC_UNIQIFY_LIST(SOGUI_EXTRA_LDFLAGS, -L$libdir $SOGUI_EXTRA_LDFLAGS)
SIM_AC_UNIQIFY_LIST(SOGUI_EXTRA_LIBS, $SOGUI_EXTRA_LIBS)

SIM_AC_UNIQIFY_LIST(CPPFLAGS, $CPPFLAGS)
SIM_AC_UNIQIFY_LIST(LDFLAGS, $LDFLAGS)
SIM_AC_UNIQIFY_LIST(LIBS, $LIBS)

# default value
SOQT_STATIC=false

if test x${enable_shared+set} = xset; then
  case $enable_shared in
  yes | true)  SOQT_STATIC=false ;;
  *)           SOQT_STATIC=true ;;
  esac
fi

if test x${enable_static+set} = xset; then
  case $enable_static in
  yes | true)  SOQT_STATIC=true ;;
  *)           SOQT_STATIC=false ;;
  esac
fi

AC_SUBST([LIBFLAGS], [])

# **************************************************************************
# Remaining setup based on platform.

AM_CONDITIONAL([BUILD_WITH_MSVC], [$BUILD_WITH_MSVC])

if $BUILD_WITH_MSVC; then
  rm -f vc60.pdb
  ## Ensure that if we link with Coin, we use the same C library as Coin
  if test x"$sim_ac_coin_msvcrt" != x"" &&
     test x"$sim_ac_msvcrt" != x"$sim_ac_coin_msvcrt"; then
      SIM_AC_CONFIGURATION_WARNING([You have built Coin with the $sim_ac_coin_msvcrt C library, while you try to build So$Gui with the $sim_ac_msvcrt C library.  This can cause mysterious crashes for you.  We recommend that you run So$Gui's configure script with the --with-msvcrt=$sim_ac_coin_msvcrt option.])
  fi
  LIBFLAGS="$LIBFLAGS $sim_ac_msvcrt_LIBLDFLAGS"
  LIBS="$LIBS $sim_ac_msvcrt_LIBLIBS"
  if $SOQT_STATIC; then
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS -DSOQT_NOT_DLL"
  else
    CPPFLAGS="-DSOQT_MAKE_DLL $CPPFLAGS"
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS -DSOQT_DLL"
  fi

  debugfile="`pwd`/src/Inventor/Qt/soqt${SOQT_MAJOR_VERSION}${SUFFIX}.pdb"
  debugfile=`cygpath -w "$debugfile" | sed 's,\\\\,\\\\\\\\,g'`
  if $SOQT_STATIC; then
    SIM_AC_CONFIGURATION_SETTING([SoQt build type], [static .lib])
    LIBFLAGS="-LIB $LIBFLAGS"
    LIBFLAGS="$LIBFLAGS /OUT:soqt$SOQT_MAJOR_VERSION$SUFFIX.lib"
  else
    LIBFLAGS="-DLL /INCREMENTAL:NO $LIBFLAGS"
    case $enable_symbols in
    no | false)
      LIBFLAGS="$LIBFLAGS /RELEASE"
      SIM_AC_CONFIGURATION_SETTING([SoQt build type],
                                   [dynamic .dll, no symbols])
      ;;
    *)
      SIM_AC_CONFIGURATION_SETTING([SoQt build type], [dynamic .dll + .pdb])
      CPPFLAGS="/Fd$debugfile $CPPFLAGS"
      LIBFLAGS="$LIBFLAGS /DEBUG /PDB:soqt$SOQT_MAJOR_VERSION$SUFFIX.pdb"
      ;;
    esac
    LIBFLAGS="$LIBFLAGS /OUT:soqt$SOQT_MAJOR_VERSION$SUFFIX.dll"
  fi

  # We use a version suffix on the .dll-file, so several incompatible
  # (major) versions can be installed on a system.
  #
  # BTW, when linking DLLs, the 3rd-party .lib files will be
  # linked into the .dll file. I believe it is still advisable to
  # list all libs used upon `soqt-config --libs`, as we can then
  # also use them from "parent" code (remember that their interfaces
  # is not exposed from the DLL) without any fuss.
  SOGUI_EXTRA_LIBS="-lsoqt$SOQT_MAJOR_VERSION$SUFFIX $SOGUI_EXTRA_LIBS"

  # For build/soqt.nsi
  win_srcdir=`cd $srcdir; pwd`
  win_srcdir=`cygpath -w "$srcdir" | sed 's,\\\\,\\\\\\\\,g'`
  AC_SUBST(win_srcdir)
else
  SOGUI_EXTRA_LIBS="-lSoQt$SUFFIX $SOGUI_EXTRA_LIBS"

  # For the build/soqt.spec RPM specification file.
  SIM_AC_ISO8601_DATE(soqt_configure_date)
  AC_SUBST(soqt_configure_date)

  if $sim_ac_framework; then
    # setup for SoQt usage
    SOGUI_EXTRA_CPPFLAGS=
    SOGUI_EXTRA_CFLAGS=
    SOGUI_EXTRA_CXXFLAGS=
    SOGUI_EXTRA_LDFLAGS="-Wl,-multiply_defined,suppress -framework SoQt"
    SOGUI_EXTRA_LIBS=
    # adjust for Qt usage
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_qt_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_qt_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_qt_libs $SOGUI_EXTRA_LIBS"
    # adjust for QGL usage
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_qgl_cppflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_qgl_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_qgl_libs $SOGUI_EXTRA_LIBS"
    # adjust for Coin usage
    SOGUI_EXTRA_CPPFLAGS="$SOGUI_EXTRA_CPPFLAGS $sim_ac_coin_cppflags"
    SOGUI_EXTRA_CFLAGS="$SOGUI_EXTRA_CFLAGS $sim_ac_coin_cflags"
    SOGUI_EXTRA_CXXFLAGS="$SOGUI_EXTRA_CXXFLAGS $sim_ac_coin_cxxflags"
    SOGUI_EXTRA_LDFLAGS="$SOGUI_EXTRA_LDFLAGS $sim_ac_coin_ldflags"
    SOGUI_EXTRA_LIBS="$sim_ac_coin_libs $SOGUI_EXTRA_LIBS"
  fi
fi

AC_SUBST([HTML_DOC_DIR], [`eval echo "$datadir/SoQt/html"`])

# **************************************************************************
# Submodules that needs to be configured...

AC_CONFIG_SUBDIRS(data)

# **************************************************************************
# List all files configure shall automatically generate.
#
# Note that soqt-$CONFIG.cfg needs to be generated from the configure
# script -- not just from the Makefile -- as the data/configure script
# depends on it.

AC_OUTPUT([
	soqt-$CONFIG.cfg:src/Inventor/Qt/common/sogui.cfg.in
	Makefile
	src/Makefile
	src/Inventor/Makefile
	src/Inventor/Qt/Makefile
	src/Inventor/Qt/devices/Makefile
	src/Inventor/Qt/viewers/Makefile
	src/Inventor/Qt/widgets/Makefile
	man/Makefile
	man/man1/Makefile
	man/man3/Makefile
	html/Makefile
        build/soqt.spec
])

SIM_AC_CONFIGURATION_SETTING([Installation Prefix], [$prefix])
if $sim_ac_framework; then
  SIM_AC_CONFIGURATION_SETTING([Framework Installation Prefix], [$sim_ac_framework_prefix])
fi

SIM_AC_CONFIGURATION_SUMMARY

echo ""
echo "Now, run 'make install' to build and install $PACKAGE."
echo ""

# **************************************************************************