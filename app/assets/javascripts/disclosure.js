$(function () {
  if (!document.getElementById('disclosures-index')) { return }

  $('.main-content-nav-tabs a').on('show.bs.tab', function(e) {
    const tab = e.currentTarget.href.split('#')[1];  // タブのid

    // ページネーションにタブのidを付加
    replacePagination(tab);
  });

  const paramStr = location.href.split("?")[1];

  if (paramStr) {
    const params = new URLSearchParams(paramStr);
    const tab = params.get("tab");

    // ページネーションにタブのidを付加
    replacePagination(tab);
  }

  function replacePagination(tab) {
    if (!tab) { return }

    $('.pagination a').attr('href', function(index, href) {
      if (href === "#") { return }
      return replaceHref(href, tab);
    });
  }

  function replaceHref(href, tab) {
    if (href.indexOf('tab=') != -1) {
      // タブが設定されている
      return href.replace(/(tab=).*/, function(match, p1) {
        return p1 + tab;
      });
    } else {
      // タブが設定されていない
      return href + '&tab=' + tab;
    }
  }

  const label = 'disclosures';

  // 月次
  trackEvent('#tab-monthly', 'tab', 'monthly', label);
  // 全て
  trackEvent('#tab-all', 'tab', 'all', label);
  // 詳細
  trackEvent('.link-detail', 'link', 'detail', label);
  // チャート
  trackEvent('.link-chart', 'link', 'chart', label);
  // 企業情報
  trackEvent('.link-profile', 'link', 'profile', label);
  // 四季報
  trackEvent('.link-shikiho', 'link', 'shikiho', label);
});