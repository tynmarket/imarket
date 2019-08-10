$(function () {
  if (!document.getElementById('stocks-show')) { return };

  function getStockId() {
    return $('#stock-id').data('stock_id');
  }

  function getUrl() {
    return '/stocks/' + getStockId() + '/favorites';
  }

  function getCsrfToken() {
    return $('meta[name="csrf-token"]').attr('content');
  }

  function toggleFav() {
    $('.js-fav').toggleClass('hide');
  }

  function addFav() {
    var url = getUrl();
    var token = getCsrfToken();
    var data = {authenticity_token: token};

    $.post(url, data)
      .done(toggleFav);
  }

  function deleteFav() {
    var url = getUrl();
    var token = getCsrfToken();
    var data = {
      data: {authenticity_token: token},
      type: 'DELETE',
    };

    $.ajax(url, data)
      .done(toggleFav);
  }

  $('[data-toggle="tooltip"]').tooltip();

  $('#fav-on').click(addFav);
  $('#fav-off').click(deleteFav);

  var label = 'stocks';

  // キャッシュフロー
  trackEvent('#tab-cashflow', 'cashflow', label);
  // 月次
  trackEvent('#tab-monthly', 'monthly', label);
  // PER
  trackEvent('#tab-per-track', 'per', label);
  // PBR
  trackEvent('#tab-pbr-track', 'pbr', label);
  // 全て
  trackEvent('#tab-disclosures', 'disclosures', label);
  // チャート
  trackEvent('.link-chart', 'chart', label);
  // 企業情報
  trackEvent('.link-profile', 'profile', label);
  // 信用残高
  trackEvent('.link-margin', 'margin', label);
  // コンセンサス
  trackEvent('.link-ifis', 'ifis', label);
  // 大量保有
  trackEvent('.link-taiho', 'taiho', label);
  // 空売り
  trackEvent('.link-karauri', 'karauri', label);
  // 融資・貸株
  trackEvent('.link-balance', 'balance', label);
  // 逆日歩
  trackEvent('.link-pcsl', 'pcsl', label);
  // 有報
  trackEvent('.link-yuho', 'yuho', label);
  // PTS
  trackEvent('.link-pts', 'pts', label);
});
