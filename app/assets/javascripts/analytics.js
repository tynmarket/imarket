function trackEvent(selector, action, label) {
  var target = document.querySelectorAll(selector);

  if(!target) {
    console.error("trackEvent: no event target");
    return;
  }

  target.forEach(function(elm) {
    elm.addEventListener('click', function() {
      ga('send', 'event', 'click', action, label, null, {nonInteraction: true});
    });
  });
}
