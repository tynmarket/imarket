function trackEvent(selector, category, action, label) {
  var targets = document.querySelectorAll(selector);

  if(!targets) {
    console.error("trackEvent: no event targets");
    return;
  }

  for (var i = 0; i < targets.length; i++) {
    targets[i].addEventListener('click', function() {
      ga('send', 'event', category, action, label, null, {nonInteraction: true});
    });
  }
}
