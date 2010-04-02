var req
function executeXhr(callback, url)  {
  // branch for native XMLHttpRequest object
  if (window.XMLHttpRequest) {
    req = new XMLHttpRequest();
    req.onreadystatechange = callback;
    req.open("GET", url, true);
    req.send(null);
  } // branch for IE/Windows ActiveX version
  else if (window.ActiveXObject) {
    req = new ActiveXObject("Microsoft.XMLHTTP");
    if (req) {
      req.onreadystatechange = callback;
      req.open("GET", url, true);
      req.send();
    }
  }
}