.pragma library

var api = "http://api.hitokoto.us/rand?charset=utf-8";
var signalcenter;
function sendWebRequest(url, callback, method, postdata) {
    var xmlhttp = new XMLHttpRequest();
    xmlhttp.onreadystatechange = function() {
                switch(xmlhttp.readyState) {
                case xmlhttp.OPENED:signalcenter.loadStarted();break;
                case xmlhttp.HEADERS_RECEIVED:if (xmlhttp.status != 200)signalcenter.loadFailed(qsTr("error connection:")+xmlhttp.status+"  "+xmlhttp.statusText);break;
                case xmlhttp.DONE:if (xmlhttp.status == 200) {
                        try {
                            callback(xmlhttp.responseText);
                            signalcenter.loadFinished();
                        } catch(e) {
                            console.log(e)
                            signalcenter.loadFailed(qsTr("loading erro..."));
                        }
                    } else {
                        signalcenter.loadFailed("");
                    }
                    break;
                }
            }
    if(method==="GET") {
        xmlhttp.open("GET",url);
        xmlhttp.send();
    }
    if(method==="POST") {
        xmlhttp.open("POST",url);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.setRequestHeader("Content-Length", postdata.length);
        xmlhttp.send(postdata);
    }
}

function gethitokoto(){
    sendWebRequest(api, loadResult, "GET","");
}

var app;
function loadResult(oritxt){
    var obj = JSON.parse(oritxt);
    //console.log(oritxt)
    app.hitokoto = obj.hitokoto;
    app.author = obj.author;
    app.source = obj.source;
    app.catname = obj.catname;
}

