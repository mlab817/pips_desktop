[Setup]
AppName=PIPS
AppVersion=1.0
DefaultDirName={pf}\PIPS
OutputDir=.
OutputBaseFilename=Setup

[Files]
Source: "C:\Users\DA\Desktop\pips_desktop\build\windows\runner\Release\*"; DestDir: "{app}"; Flags: recursesubdirs

[Icons]
Name: "{commonprograms}\PIPS"; Filename: "{app}\setup.exe"; WorkingDir: "{app}"

[Run]
Filename: "{app}\setup.exe"; Description: "Launch PIPS"; Flags: postinstall nowait