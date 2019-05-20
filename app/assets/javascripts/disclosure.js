$(function () {
  if (!document.getElementById('disclosures-index')) { return };

  $('.main-content-nav-tabs a').on('show.bs.tab', function(e) {
    var tab = e.currentTarget.href.split('#')[1];  // タブのid

    // ページネーションにタブのidを付加
    $('.pagination a').attr('href', function(index, attr) {
      return replaceHref(attr, tab);
    });
  });

  function replaceHref(attr, tab) {
    if (attr.indexOf('tab=') != -1) {  // タブが設定されている
      return attr.replace(/(tab=).*/, function(match, p1) {
        return p1 + tab;
      });
    } else {  // タブが設定されていない
      return attr + '&tab=' + tab;
    }
  }

  // 月次
  trackEvent('#tab-monthly', 'monthly', 'disclosures');
  // 全て
  trackEvent('#tab-all', 'all', 'disclosures');
});