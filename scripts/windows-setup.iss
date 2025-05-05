#define MyAppName "Font Gallery"
#define MyAppPublisher "Adeeteya"
#define MyAppPublisherURL "https://github.com/adeeteya/"
#define MyAppURL "https://github.com/adeeteya/FontGallery"
#define MyAppExeName "font_gallery.exe"
#define MyAppContact "adeeteya@gmail.com"
#define MyAppCopyright "Copyright (C) 2023 Adeeteya"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{34B5DDF1-B8AD-469A-8B13-BD18C05565BE}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppPublisherURL}
AppSupportURL={#MyAppURL}
AppReadmeFile={#MyAppURL}/README.md
AppUpdatesURL={#MyAppURL}/releases/latest
AppComments={#MyAppName}
AppContact={#MyAppContact}
AppCopyright={#MyAppCopyright}
DefaultDirName={autopf}\{#MyAppName}
DisableProgramGroupPage=yes
OutputDir=D:\a\FontGallery\FontGallery\
OutputBaseFilename=FontGallery-Windows
SetupIconFile=D:\a\FontGallery\FontGallery\windows\runner\resources\app_icon.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
VersionInfoProductName={#MyAppName}
VersionInfoDescription={#MyAppName} Setup
VersionInfoCompany={#MyAppPublisher}
VersionInfoVersion={#MyAppVersion}.0
VersionInfoProductTextVersion={#MyAppVersion}
VersionInfoCopyright={#MyAppCopyright}
UninstallDisplayIcon={app}\{#MyAppExeName}
UninstallDisplayName={#MyAppName}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "D:\a\FontGallery\FontGallery\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{autoprograms}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon
Name: "{app}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent
