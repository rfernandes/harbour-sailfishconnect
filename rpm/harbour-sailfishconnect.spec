# 
# Do NOT Edit the Auto-generated Part!
# Generated by: spectacle version 0.27
# 

Name:       harbour-sailfishconnect

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    SailfishOS client for KDE-Connect
Version:    0.5
Release:    0.1
Group:      Qt/Qt
License:    LICENSE
URL:        https://github.com/R1tschY/harbour-sailfishconnect
Source0:    %{name}-%{version}.tar.bz2
Source100:  harbour-sailfishconnect.yaml
Requires:   sailfishsilica-qt5 >= 0.10.9
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(openssl) >= 1.0.1
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Network)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  pkgconfig(Qt5Test)
BuildRequires:  pkgconfig(contextkit-statefs)
BuildRequires:  pkgconfig(nemonotifications-qt5)
BuildRequires:  cmake
BuildRequires:  python3-devel
BuildRequires:  desktop-file-utils

%description
SailfishOS client for KDE-Connect


%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre

VENV=$RPM_BUILD_ROOT/venv-%{_target_cpu}
export TARGET_CPU="%{_target_cpu}"

# install virtualenv
if [ ! -f ~/.local/bin/virtualenv ] ; then
pip3 install --no-warn-script-location --user virtualenv
fi

# create virtualenv and install conan
if [ ! -f "$VENV/bin/conan" ] ; then
~/.local/bin/virtualenv --python=python3 "$VENV"
source "$VENV/bin/activate"
pip install conan
else
source "$VENV/bin/activate"
fi

# speed up conan remote add
if ! grep -sq sailfishos ~/.conan/remotes.json ; then
conan remote add -f sailfishos https://api.bintray.com/conan/r1tschy/sailfishos
fi

export SAILFISHCONNECT_PACKAGE_VERSION="%{version}-%{release}"

# << build pre

%qtc_qmake5 

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
# >> files
# << files
