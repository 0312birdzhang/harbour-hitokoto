# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-hitokoto


CONFIG += sailfishapp sailfishapp_no_deploy_qml

SOURCES += src/harbour-hitokoto.cpp

QT += quick sensors svg xml

OTHER_FILES += qml/harbour-hitokoto.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-hitokoto.changes.in \
    rpm/harbour-hitokoto.spec \
    rpm/harbour-hitokoto.yaml \
    translations/*.ts \
    harbour-hitokoto.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-hitokoto-de.ts

DISTFILES += \
    qml/main.js \
    qml/Signalcenter.qml \
    qml/gfx.jpg

RESOURCES += \
    harbour-hitokoto.qrc

