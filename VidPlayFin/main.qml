import QtQuick
import QtQuick.Window
import QtQuick.Dialogs
import QtMultimedia

Window {
    id: newWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("Media Player Test Code")
    color:"black"
    property int timems: mediaPlayer.duration
    property int medposition: mediaPlayer.position
    property int seekpos: medposition/timems

    FileDialog{
        id: fileDialog
        title: "Please choose a file"
        onAccepted: {
                            mediaPlayer.stop()
                            mediaPlayer.source = fileDialog.currentFile
                            mediaPlayer.play()
                    }
    }

    MediaPlayer{
        id : mediaPlayer
        videoOutput: video
        audioOutput: AudioOutput {
            id: audio

        }


    }

    VideoOutput{
        id: video
        anchors.top: parent.top
        anchors.bottom: controls.top
        anchors.left: parent.left
        anchors.right: parent.right
        MouseArea{
            id: videoMouseArea
            anchors.fill: parent
            onClicked: mediaPlayer.playing ? mediaPlayer.pause() : mediaPlayer.play()
            onDoubleClicked: {
                if (newWindow.visibility===2){
                    newWindow.showFullScreen()
                    mediaPlayer.play()
                }
                else{
                    newWindow.visibility=2
                    mediaPlayer.play()
                }
            }
        }
        Keys.onPressed: (event) =>{
                            if(event.key === Qt.Key_Space){
                                if (mediaPlayer.playing){
                                    mediaPlayer.pause()
                                }
                                else{
                                    mediaPlayer.play()
                                }
                            }
                            if (event.key=== Qt.Key_Right){
                                mediaPlayer.setPosition(medposition+2000)
                            }   //Press left or right to seek forwards or backwards
                            if (event.key=== Qt.Key_Left){
                                mediaPlayer.setPosition(medposition-2000)
                            }
                        }
        focus: true
    }


    Rectangle{
        id: controls
        width: parent.width
        height: parent.height/7
        color: "black"
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        Text {
            id: seconds
            text:  Math.round((medposition/1000)/120)+":"+Math.round((medposition/1000)%60)+" / "+Math.round((timems/1000)/120)+":"+Math.round((timems/1000)%60)
            color:"blue"
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: seekLine.top


        }
        Image{
            id: openFile
            source:"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAHsAAAB7CAMAAABjGQ9NAAAAY1BMVEX///8AAABHR0dAQEDt7e2IiIg5OTnPz8+1tbX4+Pjm5uYYGBiPj49LS0tnZ2fX19elpaWfn59gYGAQEBDExMR3d3erq6sqKiowMDBTU1Pe3t4hISFwcHC9vb1ZWVmCgoKXl5d5WMTeAAADUElEQVRoge2aC5OqIBSAI81CLfNRPtoe//9XLlgmKwdEHu3OvXwzO7k5+InJOQd0tfJ4PB6P518D5+1ak3YTGqnjNTLg0pm4CxM1Qnusr+5KhMq95jUnbVGm796S5rtfaWzYPPNu7/7rbtxTfd4dp/ugp/m4uyrZuPhRd/UzJr+a4zxV4zFkLw03jkib8utEKcbmgXICCbC2m3a75U9dPXldQm13zqQfZowd6zJRobzk/ImrsiFNhp+MHd9hrMa7WLHoXox3/3/uR9YT/4b7RXmrTNzd6aDIlncTcsil6K6V41rDxDWGq767hDQgNeO+7yhnmhcahXmCwF21670K63b4adn7/ES2FX5y0b2GVRkOxLrp9lnfvRjWHZLto3d7t3d7twV3xySQ0CSu4d0hiJZBJ3P18A+7/aTN+eU30J1FymlMnWar4s7mDqNHNE2rgBvf+tMMrEIPOa0nADf9iIzWJwHorZjOu+/kw7a6P/a0iOPdmFyf2rZ69UB8KcO76Z22se6OxqpS4j4CZ2gMjTaH6Ze8m97lBovRMGcEhEzOHV4QutlWrw5ktsJNlabuK10EUcgDy8Al1CHOTb8wWIOHoR16zLtJTmhsq1dwh6bulPzdbavxGpwkTd2BixHWwR2austxdmcPQciYuqEYYIwgZABuhWpnGTEJGQXwPeC2nsOugg7xbpOnezBf5KjQ+g/vtj/CaoQSaAfv5ko6U7aipMy5E+uXPBV1iHPbH2GkbLiAHeLc9keYsEOcW3VBUpkdVDaAbvtVIikbErhDXB6z7kbjAxmJOwfmDsZAhTngbl1UiZI6iHGHiYMqkc40AkGHGPfVRZUoKBum7pOLKlE202DcyEWVWEjuodGduchhcSKJ0qM7d1ElisqGifvmoko8yaL0240RXFQZQZ9wR8K9b7eTEZZJo/Tb7WSl4yGtgwY3blxUifR9OPHewd25WOmIS2kdNLidrHSIy4Yf7oLJZ9YAVxs4dyiYtphBZxqS3S+3k5UOSdnAuqXxR5d0JjE+3TTDX2yr6cNkUdnAuJ2sJVZzifGZvRQf3C4ibuYmd/18oH/SrvtiqoBAYYJl+C6uFNngpoTu5M1s9Yd3hd2r/aI4Wk9NHo/H4/H8Ab4BZg40mIYM8uMAAAAASUVORK5CYII="
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            width: 40
            height:40
            MouseArea{
                anchors.fill: parent
                onPressed: fileDialog.open()
                    }
                }

        Rectangle{
            id: seekLine
            width: controls-controls/2
            height: 5
            color:"white"
            anchors.left: stop.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.right: openFile.left
            anchors.verticalCenter: parent.verticalCenter
            onWidthChanged: {
                seeker.x = (medposition/timems)*seekLine.width
            }

            MouseArea{

                anchors.fill: parent
                onPressed: mediaPlayer.setPosition((mouseX/parent.width)*mediaPlayer.duration)

                    }

            Rectangle{
                id: seeker
                height: 20
                width: 5
                color: "red"
                anchors.verticalCenter: parent.verticalCenter

                x: (medposition/timems)*seekLine.width


                MouseArea   {
                                    id: seekerDragArea
                                    anchors.fill: parent
                                    drag.target: parent
                                    drag.axis: Drag.XAxis
                                    drag.maximumX: seekLine.width
                                    drag.minimumX: 0
                                    onReleased: {
                                        var newPosition = seeker.x / seekLine.width
                                        console.log(newPosition)
                                        mediaPlayer.setPosition(newPosition * mediaPlayer.duration)
                                    }
                                    onPressed: {
                                        var newPositionn = seeker.x / seekLine.width
                                        mediaPlayer.setPosition(newPositionn * mediaPlayer.duration)

                                    }

                            }

                                Connections
                                {
                                    target: mediaPlayer
                                    onPositionChanged: {

                                        if (!seekerDragArea.drag.active) {
                                            seeker.x = (medposition / timems) * seekLine.width

                                        }
                                        else{
                                            var newPosition = seeker.x / seekLine.width
                                            mediaPlayer.setPosition(newPosition*mediaPlayer.duration)


                                            }

                                        }
                                }
                         }

            }



        Image {
            id: playpause
                source: mediaPlayer.playing ? "play.png" : "pause.png"

            width:30
            height:30
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.verticalCenter: controls.verticalCenter

            MouseArea{
                anchors.fill: parent
                onPressed: mediaPlayer.playing ? mediaPlayer.pause(): mediaPlayer.play()
            }
        }

        Image {
            id: stop
            source: "https://www.kindpng.com/picc/m/7-73188_stop-frame-video-music-stop-button-icon-png.png"
            width: 30
            height: 30
            anchors.left: playpause.right
            anchors.leftMargin: 5
            anchors.verticalCenter: controls.verticalCenter
            MouseArea{
                anchors.fill: parent
                onClicked: {mediaPlayer.stop()
                }

            }
        }

    }
}
