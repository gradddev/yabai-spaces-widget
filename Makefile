include .env

TEMPLATE_PATH=Template.app

debug: TARGET=debug
debug: EXECUTABLE_PATH=.build/${TARGET}/YabaiSpacesWidget
debug: APPLICATION_PATH=.build/${TARGET}/Yabai\ Spaces\ Widget.app
debug: _build

release: TARGET=release
release: EXECUTABLE_PATH=.build/${TARGET}/YabaiSpacesWidget
release: APPLICATION_PATH=.build/${TARGET}/Yabai\ Spaces\ Widget.app
release: _build

_build:
	swift build -c ${TARGET}
	rm -rf ${APPLICATION_PATH}
	cp -R ${TEMPLATE_PATH} ${APPLICATION_PATH}
	plutil -lint ${APPLICATION_PATH}/Contents/Info.plist
	cp ${EXECUTABLE_PATH} ${APPLICATION_PATH}/Contents/MacOS/ysw
	codesign -s "${CERTIFICATE}" ${APPLICATION_PATH}/Contents/MacOS/ysw
	codesign -vvvv ${APPLICATION_PATH}/Contents/MacOS/ysw
