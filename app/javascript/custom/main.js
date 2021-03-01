window.addEventListener("turbolinks:load", function () {
  var mybutton = document.getElementById("myBtn");

  window.onscroll = function () {
    scrollFunction();
  };

  function scrollFunction() {
    if (
      document.body.scrollTop > 300 ||
      document.documentElement.scrollTop > 300
    ) {
      mybutton.style.opacity = "1";
    } else {
      mybutton.style.opacity = "0";
    }
  }

  mybutton.addEventListener("click", topFunction, false);

  function topFunction() {
    document.body.scrollTop = 0;
    document.documentElement.scrollTop = 0;
  }
});
