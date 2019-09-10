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

  var label = 'disclosures';

  // 月次
  trackEvent('#tab-monthly', 'tab', 'monthly', label);
  // 全て
  trackEvent('#tab-all', 'tab', 'all', label);
  // チャート
  trackEvent('.link-chart', 'link', 'chart', label);
  // 企業情報
  trackEvent('.link-profile', 'link', 'profile', label);
  // 信用残高
  // TODO 変更
  trackEvent('.link-margin', 'link', 'margin', label);
  // コンセンサス
  // TODO 変更
  trackEvent('.link-ifis', 'link', 'ifis', label);
});