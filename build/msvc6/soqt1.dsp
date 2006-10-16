# Microsoft Developer Studio Project File - Name="soqt1" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=soqt1 - Win32 DLL (Debug)
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE
!MESSAGE NMAKE /f "soqt1.mak".
!MESSAGE
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE
!MESSAGE NMAKE /f "soqt1.mak" CFG="soqt1 - Win32 DLL (Debug)"
!MESSAGE
!MESSAGE Possible choices for configuration are:
!MESSAGE
!MESSAGE "soqt1 - Win32 LIB (Release)" (based on "Win32 (x86) Static Library")
!MESSAGE "soqt1 - Win32 LIB (Debug)" (based on "Win32 (x86) Static Library")
!MESSAGE "soqt1 - Win32 DLL (Release)" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "soqt1 - Win32 DLL (Debug)" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "SOQT_DEBUG=0" /D "HAVE_CONFIG_H" /D "SOQT_MAKE_DLL" /D "COIN_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O1 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "SOQT_DEBUG=0" /D "HAVE_CONFIG_H" /D "SOQT_MAKE_DLL" /D "COIN_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 $(QTDIR)\lib\QtOpenGL4.lib $(QTDIR)\lib\QtGui4.lib $(QTDIR)\lib\QtCore4.lib $(QTDIR)\lib\Qt3Support4.lib $(COINDIR)\lib\coin2.lib opengl32.lib user32.lib /nologo /dll /machine:I386
# ADD LINK32 $(QTDIR)\lib\QtOpenGL4.lib $(QTDIR)\lib\QtGui4.lib $(QTDIR)\lib\QtCore4.lib $(QTDIR)\lib\Qt3Support4.lib $(COINDIR)\lib\coin2.lib opengl32.lib user32.lib /nologo /dll /machine:I386 /out:"soqt1.dll" /opt:nowin98
# SUBTRACT LINK32 /pdb:none
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=install-dll-release.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "SOQT_DEBUG=1" /D "HAVE_CONFIG_H" /D "SOQT_MAKE_DLL" /D "COIN_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "SOQT_DEBUG=1" /D "HAVE_CONFIG_H" /D "SOQT_MAKE_DLL" /D "COIN_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 $(QTDIR)\lib\QtOpenGL4.lib $(QTDIR)\lib\QtGui4.lib $(QTDIR)\lib\QtCore4.lib $(QTDIR)\lib\Qt3Support4.lib $(COINDIR)\lib\coin2d.lib opengl32.lib user32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 $(QTDIR)\lib\QtOpenGL4.lib $(QTDIR)\lib\QtGui4.lib $(QTDIR)\lib\QtCore4.lib $(QTDIR)\lib\Qt3Support4.lib $(COINDIR)\lib\coin2d.lib opengl32.lib user32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept /out:"soqt1d.dll"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=install-dll-debug.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "StaticRelease"
# PROP BASE Intermediate_Dir "StaticRelease"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "StaticRelease"
# PROP Intermediate_Dir "StaticRelease"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_LIB" /D "SOQT_DEBUG=0"  /D "HAVE_CONFIG_H" /D "COIN_NOT_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_LIB" /D "SOQT_DEBUG=0"  /D "HAVE_CONFIG_H" /D "COIN_NOT_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD BASE RSC /l 0x414 /d "NDEBUG"
# ADD RSC /l 0x414 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /machine:I386 /out:"soqt1s.lib"
# ADD LIB32 /nologo /machine:I386 /out:"soqt1s.lib"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=install-lib-release.bat
# End Special Build Tool

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "StaticDebug"
# PROP BASE Intermediate_Dir "StaticDebug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "StaticDebug"
# PROP Intermediate_Dir "StaticDebug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_LIB" /D "SOQT_DEBUG=1"  /D "HAVE_CONFIG_H" /D "COIN_NOT_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_LIB" /D "SOQT_DEBUG=1"  /D "HAVE_CONFIG_H" /D "COIN_NOT_DLL" /D "SOQT_INTERNAL" /I ".\src" /I ".\data" /I "..\..\src" /I "$(COINDIR)\include" /I "$(QTDIR)\include" /I "$(QTDIR)\include\Qt" /YX /FD /c
# ADD BASE RSC /l 0x414 /d "_DEBUG"
# ADD RSC /l 0x414 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo /machine:I386 /out:"soqt1sd.lib"
# ADD LIB32 /nologo /machine:I386 /out:"soqt1sd.lib"
# Begin Special Build Tool
SOURCE="$(InputPath)"
PostBuild_Cmds=install-lib-debug.bat
# End Special Build Tool
!ENDIF

# Begin Target

# Name "soqt1 - Win32 DLL (Release)"
# Name "soqt1 - Win32 DLL (Debug)"
# Name "soqt1 - Win32 LIB (Release)"
# Name "soqt1 - Win32 LIB (Debug)"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;ic;icc"
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\SoQtDevice.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\SoQtInputFocus.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\SoQtKeyboard.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\SoQtMouse.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\SoQtSpaceball.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\devices\6DOFEvents.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\spwinput_x11.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\spwinput_win32.c
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoQtDeviceCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoQtInputFocusCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoQtKeyboardCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoQtMouseCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoQtSpaceballCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\devices"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\devices"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\editors\SoQtColorEditor.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\editors"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\editors\SoQtMaterialEditor.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\editors"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\editors"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\Engines.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\engines"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\RadioGroup.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\engines"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\Format.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\engines"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\engines"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Nodes.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SceneTexture2.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\ViewportFix.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\ViewpointWrapper.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Pane.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Position.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Translation.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Frame.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Image.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Label.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\ToggleButton.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\RadioButton.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\ClickCounter.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Slider1.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\Slider2.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\ColorEditor.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\MaterialEditor.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\nodes"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\nodes"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\FullViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtFullViewerP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\ExaminerViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtExaminerViewerP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\PlaneViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

"src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc ..\..\src\Inventor\Qt\viewers\SoQtPlaneViewerP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtConstrainedViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtFlyViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtFullViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtExaminerViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoQtPlaneViewer.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\viewers"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\viewers"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\SoQtGLArea.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\widgets"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

"src\Inventor\Qt\widgets\moc_SoQtGLArea.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtGLArea.icc ..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

"src\Inventor\Qt\widgets\moc_SoQtGLArea.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtGLArea.icc ..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

"src\Inventor\Qt\widgets\moc_SoQtGLArea.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtGLArea.icc ..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

"src\Inventor\Qt\widgets\moc_SoQtGLArea.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtGLArea.icc ..\..\src\Inventor\Qt\widgets\SoQtGLArea.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\widgets"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

"src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc ..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

"src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc ..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

"src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc ..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

"src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc ..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\widgets"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

"src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc ..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

"src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc ..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

"src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc ..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

"src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc ..\..\src\Inventor\Qt\widgets\QtNativePopupMenu.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\SoAnyThumbWheel.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\widgets"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\SoQtPopupMenu.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\widgets"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\widgets"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQt.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQtP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtP.h

"src\Inventor\Qt\moc_SoQtP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtP.icc ..\..\src\Inventor\Qt\SoQtP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtP.h

"src\Inventor\Qt\moc_SoQtP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtP.icc ..\..\src\Inventor\Qt\SoQtP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtP.h

"src\Inventor\Qt\moc_SoQtP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtP.icc ..\..\src\Inventor\Qt\SoQtP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtP.h

"src\Inventor\Qt\moc_SoQtP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtP.icc ..\..\src\Inventor\Qt\SoQtP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQtComponent.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQtComponentP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtComponentP.h

"src\Inventor\Qt\moc_SoQtComponentP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtComponentP.icc ..\..\src\Inventor\Qt\SoQtComponentP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtComponentP.h

"src\Inventor\Qt\moc_SoQtComponentP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtComponentP.icc ..\..\src\Inventor\Qt\SoQtComponentP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtComponentP.h

"src\Inventor\Qt\moc_SoQtComponentP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtComponentP.icc ..\..\src\Inventor\Qt\SoQtComponentP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtComponentP.h

"src\Inventor\Qt\moc_SoQtComponentP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtComponentP.icc ..\..\src\Inventor\Qt\SoQtComponentP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQtGLWidget.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\SoQtGLWidgetP.h

!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtGLWidgetP.h

"src\Inventor\Qt\moc_SoQtGLWidgetP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtGLWidgetP.icc ..\..\src\Inventor\Qt\SoQtGLWidgetP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtGLWidgetP.h

"src\Inventor\Qt\moc_SoQtGLWidgetP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtGLWidgetP.icc ..\..\src\Inventor\Qt\SoQtGLWidgetP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtGLWidgetP.h

"src\Inventor\Qt\moc_SoQtGLWidgetP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtGLWidgetP.icc ..\..\src\Inventor\Qt\SoQtGLWidgetP.h

# End Custom Build

!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"

# PROP IgnoreDefaultTool 1
#Begin Custom Build - moc'ing $(InputPath)
InputPath=..\..\src\Inventor\Qt\SoQtGLWidgetP.h

"src\Inventor\Qt\moc_SoQtGLWidgetP.icc" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	$(QTDIR)\bin\moc -o src\Inventor\Qt\moc_SoQtGLWidgetP.icc ..\..\src\Inventor\Qt\SoQtGLWidgetP.h

# End Custom Build

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoAny.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtCursor.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtObject.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtComponentCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtGLWidgetCommon.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoQtRenderArea.cpp
!IF  "$(CFG)" == "soqt1 - Win32 DLL (Release)"
# PROP Intermediate_Dir "Release\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 DLL (Debug)"
# PROP Intermediate_Dir "Debug\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Release)"
# PROP Intermediate_Dir "StaticRelease\Qt"
!ELSEIF  "$(CFG)" == "soqt1 - Win32 LIB (Debug)"
# PROP Intermediate_Dir "StaticDebug\Qt"
!ENDIF 
# End Source File
# End Group
# Begin Group "Public Headers"

# PROP Default_Filter "h"
# Begin Source File

SOURCE=src\Inventor\Qt\devices\SoQtDevice.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\devices\SoQtKeyboard.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\devices\SoQtMouse.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\devices\SoQtSpaceball.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\editors\SoQtColorEditor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\editors\SoQtMaterialEditor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\nodes\SoGuiColorEditor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\nodes\SoGuiMaterialEditor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtViewer.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtFullViewer.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtExaminerViewer.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtPlaneViewer.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtConstrainedViewer.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\viewers\SoQtFlyViewer.h
# End Source File
# Begin Source File

SOURCE=..\..\src\Inventor\Qt\widgets\SoQtThumbWheel.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\widgets\SoQtPopupMenu.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQt.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtBasic.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtObject.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtCursor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtComponent.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtGLWidget.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtColorEditor.h
# End Source File
# Begin Source File

SOURCE=src\Inventor\Qt\SoQtRenderArea.h
# End Source File
# End Group
# Begin Group "Private Headers"

# PROP Default_Filter "h;ic;icc"
# Begin Source File

SOURCE=.\src\config-debug.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\config-release.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiDeviceP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiInputFocusP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiKeyboardP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiMouseP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiSpaceballP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiEngines.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiFormat.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiRadioGroup.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiClickCounter.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiFrame.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiImage.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiLabel.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiNodes.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiPane.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiPosition.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiRadioButton.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSceneTexture2.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSlider1.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSlider2.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiToggleButton.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiTranslation.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiViewpointWrapper.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiViewportFix.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiComponentP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiGLWidgetP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiExaminerViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiFullViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiPlaneViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\soqtdefs.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\config-debug.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\config-release.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiDeviceP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiInputFocusP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiKeyboardP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiMouseP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\devices\SoGuiSpaceballP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiEngines.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiFormat.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\engines\SoGuiRadioGroup.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiClickCounter.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiFrame.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiImage.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiLabel.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiNodes.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiPane.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiPosition.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiRadioButton.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSceneTexture2.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSlider1.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiSlider2.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiToggleButton.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiTranslation.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiViewpointWrapper.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\nodes\SoGuiViewportFix.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiComponentP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiGLWidgetP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\SoGuiP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiExaminerViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiFullViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\SoGuiPlaneViewerP.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\soqtdefs.h
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtComponentP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtGLWidgetP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_SoQtGLArea.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtComponentP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtGLWidgetP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\moc_SoQtP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtExaminerViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtFullViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\viewers\moc_SoQtPlaneViewerP.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_QtNativePopupMenu.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_SoQtGLArea.icc
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=.\src\Inventor\Qt\widgets\moc_SoQtThumbWheel.icc
# PROP Exclude_From_Build 1
# End Source File
# End Group
# End Target
# End Project
