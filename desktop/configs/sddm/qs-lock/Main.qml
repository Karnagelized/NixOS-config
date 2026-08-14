import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import SddmComponents 2.0

Rectangle {
    id: root
    color: base

    readonly property real sc: getScale(width, height)
    readonly property color base: "#1e1e2e"
    readonly property color crust: "#11111b"
    readonly property color text: "#cdd6f4"
    readonly property color subtext0: "#a6adc8"
    readonly property color overlay2: "#9399b2"
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475a"
    readonly property color surface2: "#585b70"
    readonly property color mauve: "#cba6f7"
    readonly property color red: "#f38ba8"
    readonly property color peach: "#fab387"
    readonly property color blue: "#89b4fa"
    readonly property color green: "#a6e3a1"

    property bool failed: false
    property bool authenticating: false
    property bool inputActive: passwordField.text.length > 0 || passwordField.activeFocus || userField.activeFocus
    property bool powerMenuOpen: false
    property int sessionIndex: sessionModel.lastIndex
    property real introState: 0
    property real orbitAngle: 0
    property string kbLayout: keyboard.currentLayout || "US"
    property string currentTime: "00:00"

    function getScale(w, h) {
        if (w <= 0 || h <= 0)
            return 1.0;

        var r = Math.min(w / 1920.0, h / 1080.0);
        if (r <= 1.0)
            return Math.max(0.50, Math.pow(r, 0.85));

        return Math.pow(r, 0.5);
    }

    function colorWithAlpha(colorValue, alpha) {
        return Qt.rgba(colorValue.r, colorValue.g, colorValue.b, alpha);
    }

    function sessionName() {
        return sessionBox.text && sessionBox.text.length > 0 ? sessionBox.text : "Session";
    }

    function nextSession() {
        if (sessionModel.count <= 1)
            return;

        sessionBox.index = (sessionBox.index + 1) % sessionModel.count;
        sessionIndex = sessionBox.index;
    }

    function login() {
        if (passwordField.text.length === 0 || authenticating)
            return;

        failed = false;
        authenticating = true;
        sddm.login(userField.text, passwordField.text, sessionIndex);
    }

    Component.onCompleted: {
        if (sessionIndex < 0 && sessionModel.count > 0)
            sessionIndex = 0;
        passwordField.forceActiveFocus();
        introAnimation.start();
    }

    NumberAnimation {
        id: introAnimation
        target: root
        property: "introState"
        from: 0
        to: 1
        duration: 700
        easing.type: Easing.OutExpo
    }

    NumberAnimation on orbitAngle {
        from: 0
        to: Math.PI * 2
        duration: 90000
        loops: Animation.Infinite
        running: true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            var d = new Date();
            clockHours.text = Qt.formatDateTime(d, "hh");
            clockMinutes.text = Qt.formatDateTime(d, "mm");
            dateText.text = Qt.formatDateTime(d, "dddd, MMMM dd");
            root.currentTime = Qt.formatDateTime(d, "hh:mm");
        }
    }

    ComboBox {
        id: sessionBox
        visible: false
        model: sessionModel
        index: root.sessionIndex
        onIndexChanged: root.sessionIndex = index
    }

    Connections {
        target: sddm

        function onLoginSucceeded() {
            authenticating = false;
        }

        function onLoginFailed() {
            authenticating = false;
            failed = true;
            passwordField.text = "";
            passwordField.forceActiveFocus();
            shakeAnimation.restart();
        }
    }

    Image {
        id: wallpaper
        anchors.fill: parent
        source: config.background || "background.jpg"
        fillMode: Image.PreserveAspectCrop
        asynchronous: true
        cache: false
    }

    Rectangle {
        anchors.fill: parent
        color: "black"
        opacity: 0.48
    }

    Item {
        anchors.fill: parent
        opacity: root.introState

        Rectangle {
            width: parent.width * 0.82
            height: width
            radius: width / 2
            x: (parent.width / 2 - width / 2) + Math.cos(root.orbitAngle * 2) * (200 * root.sc)
            y: (parent.height / 2 - height / 2) + Math.sin(root.orbitAngle * 2) * (150 * root.sc)
            scale: 1.0 + Math.sin(root.orbitAngle * 6) * 0.05
            opacity: root.inputActive ? 0.04 : 0.08
            color: root.mauve
        }

        Rectangle {
            width: parent.width * 0.90
            height: width
            radius: width / 2
            x: (parent.width / 2 - width / 2) + Math.sin(root.orbitAngle * 1.5) * (-200 * root.sc)
            y: (parent.height / 2 - height / 2) + Math.cos(root.orbitAngle * 1.5) * (-150 * root.sc)
            scale: 1.0 + Math.cos(root.orbitAngle * 5) * 0.05
            opacity: root.inputActive ? 0.03 : 0.06
            color: root.blue
        }

        Repeater {
            model: 4

            Rectangle {
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -40 * root.sc
                width: (400 * root.sc) + (index * 220 * root.sc)
                height: width
                radius: width / 2
                color: "transparent"
                border.color: root.failed ? root.red : root.text
                border.width: Math.max(1, root.sc)
                opacity: root.failed ? (0.10 - index * 0.02) : (root.inputActive ? (0.02 - index * 0.005) : (0.04 - index * 0.01))

                Behavior on border.color { ColorAnimation { duration: 600; easing.type: Easing.OutExpo } }
                Behavior on opacity { NumberAnimation { duration: 600; easing.type: Easing.OutExpo } }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (root.powerMenuOpen)
                root.powerMenuOpen = false;
            passwordField.forceActiveFocus();
        }
    }

    Item {
        anchors.fill: parent
        opacity: root.introState
        transform: Translate { y: (30 * root.sc) * (1.0 - root.introState) }

        ColumnLayout {
            id: clockModule
            anchors.centerIn: parent
            anchors.verticalCenterOffset: root.inputActive ? (-120 * root.sc) : (-40 * root.sc)
            spacing: -10 * root.sc
            opacity: root.inputActive ? 0 : 1
            scale: root.inputActive ? 0.9 : 1
            visible: opacity > 0.01

            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 600; easing.type: Easing.OutExpo } }
            Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: 0

                Text {
                    id: clockHours
                    font.family: "JetBrains Mono"
                    font.pixelSize: 140 * root.sc
                    font.weight: Font.Bold
                    color: root.text
                }

                Text {
                    text: ":"
                    font.family: "JetBrains Mono"
                    font.pixelSize: 140 * root.sc
                    font.weight: Font.Bold
                    opacity: 0.5
                    color: root.text
                }

                Text {
                    id: clockMinutes
                    font.family: "JetBrains Mono"
                    font.pixelSize: 140 * root.sc
                    font.weight: Font.Bold
                    color: root.text
                }
            }

            Text {
                id: dateText
                Layout.alignment: Qt.AlignHCenter
                font.family: "JetBrains Mono"
                font.pixelSize: 22 * root.sc
                font.weight: Font.Bold
                color: root.text
            }
        }

        RowLayout {
            id: authModule
            anchors.centerIn: parent
            anchors.verticalCenterOffset: root.inputActive ? (-40 * root.sc) : (40 * root.sc)
            spacing: 32 * root.sc
            opacity: root.inputActive ? 1 : 0
            scale: root.inputActive ? 1 : 0.9
            visible: opacity > 0.01

            Behavior on anchors.verticalCenterOffset { NumberAnimation { duration: 600; easing.type: Easing.OutExpo } }
            Behavior on opacity { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }
            Behavior on scale { NumberAnimation { duration: 500; easing.type: Easing.OutBack } }

            Item {
                Layout.alignment: Qt.AlignVCenter
                Layout.preferredWidth: 170 * root.sc
                Layout.preferredHeight: 170 * root.sc

                Rectangle {
                    anchors.fill: parent
                    radius: height / 2
                    color: root.colorWithAlpha(root.surface0, 0.50)
                    border.color: root.failed ? root.red : (root.authenticating ? root.peach : root.colorWithAlpha(root.text, 0.55))
                    border.width: Math.max(2, 3 * root.sc)

                    Behavior on border.color { ColorAnimation { duration: 300 } }
                }

                Text {
                    anchors.centerIn: parent
                    text: "󰄽"
                    font.family: "Iosevka Nerd Font"
                    font.pixelSize: 64 * root.sc
                    color: root.subtext0
                }
            }

            ColumnLayout {
                Layout.alignment: Qt.AlignVCenter
                spacing: 16 * root.sc

                TextInput {
                    id: userField
                    Layout.preferredWidth: 330 * root.sc
                    text: userModel.lastUser
                    selectByMouse: true
                    color: root.text
                    selectionColor: root.mauve
                    selectedTextColor: root.crust
                    font.family: "JetBrains Mono"
                    font.pixelSize: 28 * root.sc
                    font.weight: Font.Bold
                    clip: true
                    enabled: !root.authenticating
                    KeyNavigation.tab: passwordField
                    Keys.onReturnPressed: passwordField.forceActiveFocus()
                    Keys.onEnterPressed: passwordField.forceActiveFocus()
                }

                RowLayout {
                    Layout.alignment: Qt.AlignLeft
                    spacing: 12 * root.sc

                    Rectangle {
                        Layout.preferredWidth: 36 * root.sc
                        Layout.preferredHeight: 36 * root.sc
                        radius: height / 2
                        color: root.failed
                            ? root.colorWithAlpha(root.red, 0.20)
                            : (root.authenticating ? root.colorWithAlpha(root.peach, 0.20) : root.colorWithAlpha(root.mauve, 0.15))
                        border.color: root.failed ? root.red : (root.authenticating ? root.peach : root.mauve)
                        border.width: Math.max(1, root.sc)

                        Behavior on color { ColorAnimation { duration: 300 } }
                        Behavior on border.color { ColorAnimation { duration: 300 } }

                        Text {
                            anchors.centerIn: parent
                            text: root.failed ? "󰌾" : "󰌿"
                            font.family: "Iosevka Nerd Font"
                            font.pixelSize: 18 * root.sc
                            color: root.failed ? root.red : (root.authenticating ? root.peach : root.mauve)
                        }
                    }

                    Text {
                        id: statusText
                        text: root.failed ? "ACCESS DENIED" : (root.authenticating ? "AUTHENTICATING" : (passwordField.text.length > 0 ? "ENTER PASSWORD" : "LOCKED"))
                        font.family: "JetBrains Mono"
                        font.pixelSize: 14 * root.sc
                        font.weight: Font.Medium
                        font.letterSpacing: 2
                        color: root.failed ? root.red : (root.authenticating ? root.peach : root.text)

                        Behavior on color { ColorAnimation { duration: 300 } }
                    }
                }

                Rectangle {
                    id: passwordPill
                    Layout.alignment: Qt.AlignLeft
                    Layout.preferredWidth: 300 * root.sc
                    Layout.preferredHeight: 60 * root.sc
                    radius: height / 2
                    clip: true
                    color: root.failed ? root.colorWithAlpha(root.red, 0.10) : root.colorWithAlpha(root.surface0, 0.50)
                    border.width: Math.max(1, 2 * root.sc)
                    border.color: {
                        if (root.failed)
                            return root.red;
                        if (root.authenticating)
                            return root.peach;
                        if (passwordField.text.length > 0)
                            return root.text;
                        return root.colorWithAlpha(root.text, 0.08);
                    }
                    scale: root.failed ? 1.05 : (root.authenticating ? 0.98 : 1)
                    transform: Translate { id: shakeTranslate; x: 0 }

                    Behavior on color { ColorAnimation { duration: 250; easing.type: Easing.OutExpo } }
                    Behavior on border.color { ColorAnimation { duration: 250; easing.type: Easing.OutExpo } }
                    Behavior on scale { NumberAnimation { duration: 300; easing.type: Easing.OutBack } }

                    SequentialAnimation {
                        id: shakeAnimation
                        NumberAnimation { target: shakeTranslate; property: "x"; from: 0; to: -8 * root.sc; duration: 120; easing.type: Easing.InOutSine }
                        NumberAnimation { target: shakeTranslate; property: "x"; from: -8 * root.sc; to: 8 * root.sc; duration: 120; easing.type: Easing.InOutSine }
                        NumberAnimation { target: shakeTranslate; property: "x"; from: 8 * root.sc; to: 0; duration: 120; easing.type: Easing.InOutSine }
                    }

                    TextInput {
                        id: passwordField
                        anchors.fill: parent
                        anchors.leftMargin: 24 * root.sc
                        anchors.rightMargin: 24 * root.sc
                        verticalAlignment: TextInput.AlignVCenter
                        echoMode: TextInput.Password
                        passwordCharacter: "•"
                        focus: true
                        enabled: !root.authenticating
                        color: root.failed ? root.red : root.text
                        selectionColor: root.mauve
                        selectedTextColor: root.crust
                        font.family: "JetBrains Mono"
                        font.pixelSize: 24 * root.sc
                        font.weight: Font.Bold
                        clip: true
                        KeyNavigation.backtab: userField
                        Keys.onReturnPressed: root.login()
                        Keys.onEnterPressed: root.login()
                        onTextChanged: {
                            if (text.length > 0)
                                root.failed = false;
                        }
                    }
                }
            }
        }
    }

    RowLayout {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 40 * root.sc
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 16 * root.sc
        opacity: root.introState
        transform: Translate { y: (20 * root.sc) * (1.0 - root.introState) }

        InfoPill {
            scaleFactor: root.sc
            pillIcon: "󰌌"
            pillText: root.kbLayout
            accent: root.mauve
            textColor: root.text
            baseColor: root.surface0
            borderBase: root.text
        }

        InfoPill {
            scaleFactor: root.sc
            pillIcon: "󰍃"
            pillText: root.currentTime
            accent: root.blue
            textColor: root.text
            baseColor: root.surface0
            borderBase: root.text
        }

        InfoPill {
            scaleFactor: root.sc
            pillIcon: "󰿂"
            pillText: root.sessionName()
            accent: root.green
            textColor: root.text
            baseColor: root.surface0
            borderBase: root.text
            visible: sessionModel.count > 0
            onClicked: root.nextSession()
        }
    }

    Rectangle {
        id: powerMenu
        anchors.bottom: powerButton.top
        anchors.right: parent.right
        anchors.bottomMargin: 15 * root.sc
        anchors.rightMargin: 40 * root.sc
        width: 280 * root.sc
        height: root.powerMenuOpen ? menuLayout.implicitHeight + 20 * root.sc : 0
        radius: 18 * root.sc
        clip: true
        opacity: root.powerMenuOpen ? 1 : 0
        color: root.colorWithAlpha(root.surface0, 0.95)
        border.color: root.colorWithAlpha(root.mauve, 0.25)
        border.width: Math.max(1, root.sc)

        Behavior on height { NumberAnimation { duration: 350; easing.type: Easing.OutExpo } }
        Behavior on opacity { NumberAnimation { duration: 250 } }

        ColumnLayout {
            id: menuLayout
            anchors.top: parent.top
            anchors.topMargin: 10 * root.sc
            anchors.left: parent.left
            anchors.right: parent.right
            spacing: 6 * root.sc

            Text {
                text: "SYSTEM"
                font.family: "JetBrains Mono"
                font.weight: Font.Black
                font.pixelSize: 12 * root.sc
                font.letterSpacing: 1.5
                color: root.mauve
                Layout.leftMargin: 18 * root.sc
                Layout.topMargin: 4 * root.sc
                Layout.bottomMargin: 4 * root.sc
            }

            PowerAction {
                scaleFactor: root.sc
                actionIcon: "󰜉"
                actionText: "Reboot"
                accent: root.blue
                onTriggered: sddm.reboot()
            }

            PowerAction {
                scaleFactor: root.sc
                visible: sddm.canSuspend
                actionIcon: "󰒲"
                actionText: "Suspend"
                accent: root.mauve
                onTriggered: sddm.suspend()
            }

            PowerAction {
                scaleFactor: root.sc
                actionIcon: "󰐥"
                actionText: "Power Off"
                accent: root.red
                onTriggered: sddm.powerOff()
            }
        }
    }

    Rectangle {
        id: powerButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 40 * root.sc
        width: 52 * root.sc
        height: width
        radius: width / 2
        color: root.powerMenuOpen ? root.surface2 : (powerMouse.containsMouse ? root.colorWithAlpha(root.surface1, 0.80) : root.colorWithAlpha(root.surface0, 0.45))
        border.color: root.powerMenuOpen ? root.text : root.colorWithAlpha(root.text, 0.15)
        border.width: Math.max(1, root.sc)
        scale: powerMouse.pressed ? 0.9 : (powerMouse.containsMouse ? 1.08 : 1)

        Behavior on scale { NumberAnimation { duration: 220; easing.type: Easing.OutBack } }

        Text {
            anchors.centerIn: parent
            text: "󰐥"
            font.family: "Iosevka Nerd Font"
            font.pixelSize: 22 * root.sc
            color: root.powerMenuOpen ? root.red : (powerMouse.containsMouse ? root.text : root.subtext0)
        }

        MouseArea {
            id: powerMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: root.powerMenuOpen = !root.powerMenuOpen
        }
    }

    component InfoPill: Rectangle {
        signal clicked()

        property real scaleFactor: 1
        property string pillIcon: ""
        property string pillText: ""
        property color accent: "#cba6f7"
        property color textColor: "#cdd6f4"
        property color baseColor: "#313244"
        property color borderBase: "#cdd6f4"
        property bool hovered: infoMouse.containsMouse

        Layout.preferredHeight: 48 * scaleFactor
        Layout.preferredWidth: infoContent.implicitWidth + 36 * scaleFactor
        radius: height / 2
        color: hovered ? Qt.rgba(baseColor.r, baseColor.g, baseColor.b, 0.65) : Qt.rgba(baseColor.r, baseColor.g, baseColor.b, 0.42)
        border.color: hovered ? accent : Qt.rgba(borderBase.r, borderBase.g, borderBase.b, 0.08)
        border.width: Math.max(1, scaleFactor)
        scale: hovered ? 1.05 : 1

        Behavior on scale { NumberAnimation { duration: 250; easing.type: Easing.OutExpo } }
        Behavior on color { ColorAnimation { duration: 200 } }
        Behavior on border.color { ColorAnimation { duration: 200 } }

        RowLayout {
            id: infoContent
            anchors.centerIn: parent
            spacing: 8 * scaleFactor

            Text {
                text: pillIcon
                font.family: "Iosevka Nerd Font"
                font.pixelSize: 18 * scaleFactor
                color: infoMouse.containsMouse ? accent : textColor
            }

            Text {
                text: pillText
                font.family: "JetBrains Mono"
                font.pixelSize: 14 * scaleFactor
                font.weight: Font.Bold
                color: textColor
            }
        }

        MouseArea {
            id: infoMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: parent.clicked()
        }
    }

    component PowerAction: Rectangle {
        signal triggered()

        property real scaleFactor: 1
        property string actionIcon: ""
        property string actionText: ""
        property color accent: "#cba6f7"

        Layout.fillWidth: true
        Layout.preferredHeight: 48 * scaleFactor
        Layout.leftMargin: 10 * scaleFactor
        Layout.rightMargin: 10 * scaleFactor
        Layout.bottomMargin: actionText === "Power Off" ? 8 * scaleFactor : 0
        radius: 12 * scaleFactor
        color: actionMouse.containsMouse ? Qt.rgba(accent.r, accent.g, accent.b, 0.10) : "transparent"
        scale: actionMouse.pressed ? 0.95 : (actionMouse.containsMouse ? 1.02 : 1)

        Behavior on scale { NumberAnimation { duration: 180; easing.type: Easing.OutBack } }

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 16 * scaleFactor
            anchors.rightMargin: 16 * scaleFactor
            spacing: 0

            Text {
                text: actionIcon
                font.family: "Iosevka Nerd Font"
                font.pixelSize: 18 * scaleFactor
                color: actionMouse.containsMouse ? accent : Qt.rgba(accent.r, accent.g, accent.b, 0.65)
            }

            Item { Layout.fillWidth: true }

            Text {
                text: actionText
                font.family: "JetBrains Mono"
                font.pixelSize: 15 * scaleFactor
                font.weight: Font.Medium
                color: actionMouse.containsMouse ? accent : Qt.rgba(accent.r, accent.g, accent.b, 0.65)
            }
        }

        MouseArea {
            id: actionMouse
            anchors.fill: parent
            hoverEnabled: true
            onClicked: parent.triggered()
        }
    }
}
