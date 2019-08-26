$(function () {
  if (!document.getElementById('stocks-show')) { return };

  var label = 'stocks';

  // キャッシュフロー
  trackEvent('#tab-cashflow', 'cashflow', label);
  // 月次
  trackEvent('#tab-monthly', 'monthly', label);
  // PER
  trackEvent('#tab-per-track', 'per', label);
  // PBR
  trackEvent('#tab-pbr-track', 'pbr', label);
  // 時価総額/FCF倍率
  trackEvent('#tab-market-cap-fcf-ratio-track', 'market-cap-fcf-ratio', label);
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
