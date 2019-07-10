function trackEvent(selector, action, label) {
  var targets = document.querySelectorAll(selector);

  if(!targets) {
    console.error("trackEvent: no event targets");
    return;
  }

  for (var i = 0; i < targets.length; i++) {
    target[i].addEventListener('click', function() {
      ga('send', 'event', 'click', action, label, null, {nonInteraction: true});
    });
  }
}
