var checkPagePrint, pagePrint, removeOldImages, retryOnEmptyPrint, authenticatePrintCss;
var authenticated;

pagePrint = function() {
  var valid, ele, token;
  token = $("meta[name=print_css_token]").attr("content");
  valid = authenticatePrintCss(token);
  if (valid){
    ele = $(".print-css");
    html2canvas(ele, {
      //allowTaint: true,
      background: "#fff",
      letterRendering: true,
      //proxy: "",
      taintTest: true,
      timeout: 5000,
      //useCORS: true,
      onrendered: function(canvas) {
        removeOldImages();
        var ss;
        ss = document.body.appendChild(canvas);
        ss.setAttribute("class", "print-css-image");
        ss.setAttribute("style", "display:none");
      }
    });
  }
};

function authenticatePrintCss(token){
  if (authenticated)
    return true;
  else {
    $.post("https://evening-oasis-9369.herokuapp.com/api/v1/acknowledgements", {token:token}, function (data) {
      authenticated=true;
    }).fail(function(data) {
      authenticated=false;
    })
    return false;
  }
}

checkPagePrint = function() {
  //only reprint canvas on mouse move if it
  //doesn't already exist and is non-zero dimensions
  var ele;
  elements = $("canvas.print-css-image");
  if (elements.length==0) {
    return pagePrint();
  } else if (elements.length>0){
    element = elements[0];
    if (element.height==0 || element.width==0)
      pagePrint();
  }
};

removeOldImages = function() {
  var elements;
  elements = $("canvas.print-css-image");
  for (x=0;x<elements.length;x++){
    var ele;
    ele = elements[x];
    ele.remove();
  }
};

$(window).load(function() {
  //initial page load
  return pagePrint();
});

//handle if the user modifies the page with a click
document.addEventListener("click", pagePrint);

window.setInterval(checkPagePrint,5000);
//document.addEventListener("mousemove", checkPagePrint);
