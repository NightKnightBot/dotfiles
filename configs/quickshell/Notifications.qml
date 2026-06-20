import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

import "config.js" as Config

Scope {
  id: root
  NotificationServer {
    id: server
    actionsSupported: true
    bodySupported: true
    imageSupported: true

    onNotification: n => {
      n.tracked = true
    }
  }

  IpcHandler {
    target: "notifications"
    function toggle(): void { root.centerOpen = !root.centerOpen }
    function show(): void { root.centerOpen = true }
    function hide(): void { root.centerOpen = false }
  }

  // Notification
  PanelWindow {
    anchors {top: true; right: true}
    margins {top:12;right:12}
    implicitWidth: 380
    implicitHeight: Math.max(1, column.implicitHeight)
    color: "transparent"

    exclusionMode: ExclusionMode.Ignore

    ColumnLayout {
      id: column
      width: parent.width
      spacing: 10

      Repeater {
        model: server.trackedNotifications
        delegate: Rectangle {
          id: card
          required property var modelData

          Timer {
            running: card.modelData.urgency !== NotificationUrgency.Critical
            interval: Config.notifications.timeout
            onTriggered: card.modelData.dismiss()
          }

          Layout.fillWidth: true
          Layout.preferredHeight: layout.implicitHeight + 20
          radius: 0
          color: Config.colors.bg
          border.width: 2
          border.color: modelData.urgency === NotificationUrgency.Critical
            ? Config.colors.red : Config.colors.green
          RowLayout {
            id: layout
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Image {
              Layout.preferredHeight: 36
              Layout.preferredWidth: 36
              Layout.alignment: Qt.AlignTop
              fillMode: Image.PreserveAspectFit
              visible: source.toString() !==""
              source: card.modelData.image || card.modelData.appIcon || ""
            }

            ColumnLayout {
              Layout.fillWidth: true
              spacing: 2

              Text {
                Layout.fillWidth: true
                text: card.modelData.summary
                color: Config.colors.cyan
                font.family: Config.bar.fontFamily
                font.pixelSize: Config.bar.fontSize
                font.bold: true
                elide: Text.ElideRight
              }

              Text {
                Layout.fillWidth: true
                visible: text !== ""
                text: card.modelData.body
                color: Config.colors.fg
                font.family: Config.bar.fontFamily
                font.pixelSize: Config.bar.fontSize - 1
                wrapMode: Text.WordWrap
              }
            }
          }
          MouseArea {
            anchors.fill: parent
            onClicked: card.modelData.dismiss()
          }
        }
      }
    }
  }
}
