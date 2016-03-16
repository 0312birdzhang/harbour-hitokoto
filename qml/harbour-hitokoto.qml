/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0
import "./main.js" as JS

ApplicationWindow{
    id: window
    width: Screen.width
    height: Screen.height
    visible: true
    property string hitokoto;
    property string  source
    property string  author
    property string  catname
    property bool loading: false

    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.Portrait
    _defaultPageOrientations: Orientation.Portrait

    BusyIndicator {
        id: busyIndicator
        anchors.centerIn: parent
        running: loading
        size: BusyIndicatorSize.Large
    }

    Connections{
            target: signalcenter;
            onLoadStarted:{
                window.loading=true;
            }
            onLoadFinished:{
                window.loading=false;
            }
            onLoadFailed:{
                window.loading=false;
                //signalCenter.showMessage(errorstring);
                detectedText.text = errorstring;
            }
        }

    Signalcenter{
        id:signalcenter
    }

    SensorGesture {
         id:gestureid
         gestures : ["QtSensors.shake"]
         enabled: true
         onDetected:{
             JS.gethitokoto()
         }
     }

    Image{
        id:img
        source: "./gfx.jpg"
        //fillMode: Image.PreserveAspectFit
        width: parent.width
        height:parent.height
        opacity: 0.08

    }
    SilicaFlickable{
        anchors.fill: parent
        contentHeight: detectedText.height + contentExt.height + Theme.paddingMedium
         Label{
             id:detectedText
             anchors{
                 left:parent.left
                 right:parent.right
                 margins: Theme.paddingMedium
             }
             y:window.height / 2 - detectedText.height /2
             width: parent.width
             wrapMode: Text.WordWrap
             font.pixelSize: Theme.fontSizeLarge
             color: Theme.highlightColor
             opacity:0.7
             font.bold: true
             horizontalAlignment: Text.AlignLeft
             truncationMode: TruncationMode.Elide
             text:"『" + hitokoto + "』"
             MouseArea{
                 anchors.fill: parent
                 onPressAndHold: {
                     Clipboard.text = detectedText.text;
                     //addNotification(qsTr("Copyed to clipboard"));
                 }
             }
         }
         Label{
             id:contentExt
             text:"——"+(source?(source+","):"")+catname
             width:parent.width * 0.7
             wrapMode: Text.WordWrap
             font.pixelSize:Theme.fontSizeSmall
             horizontalAlignment: Text.AlignRight
             anchors{
                 top:detectedText.bottom
                 right:parent.right
                 margins: Theme.paddingMedium
             }
         }

    }
     Component.onCompleted: {
        JS.signalcenter = signalcenter
        JS.app = window
       JS.gethitokoto();
     }
}


