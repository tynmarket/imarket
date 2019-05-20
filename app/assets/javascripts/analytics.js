function trackEvent(selector, action, label) {
  var target = document.querySelector(selector);

  if(!target) {
    console.error("trackEvent: no event target");
    return;
  }

  target.addEventListener('click', function() {
    console.log("trackEvent");
    ga('send', 'event', 'click', action, label, null, {nonInteraction: true});
  });
}
