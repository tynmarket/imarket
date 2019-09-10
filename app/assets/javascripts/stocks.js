$(function () {
  if (!document.getElementById('stocks-show')) { return };

  var label = 'stocks';

  // キャッシュフロー
  trackEvent('#tab-cashflow', 'tab', 'cashflow', label);
  // 月次
  trackEvent('#tab-monthly', 'tab', 'monthly', label);
  // PER
  trackEvent('#tab-per-track', 'tab', 'per', label);
  // PBR
  trackEvent('#tab-pbr-track', 'tab', 'pbr', label);
  // FCF倍率
  trackEvent('#tab-fcf-ratio-track', 'tab', 'fcf-ratio', label);
  // 開示（1年分）
  trackEvent('#tab-disclosures', 'tab', 'disclosures', label);
  // チャート
  trackEvent('.link-chart', 'link', 'chart', label);
  // 企業情報
  trackEvent('.link-profile', 'link', 'profile', label);
  // 信用残高
  trackEvent('.link-margin', 'link', 'margin', label);
  // コンセンサス
  trackEvent('.link-ifis', 'link', 'ifis', label);
  // 大量保有
  trackEvent('.link-taiho', 'link', 'taiho', label);
  // 空売り
  trackEvent('.link-karauri', 'link', 'karauri', label);
  // 融資・貸株
  trackEvent('.link-balance', 'link', 'balance', label);
  // 逆日歩
  trackEvent('.link-pcsl', 'link', 'pcsl', label);
  // 有報
  trackEvent('.link-yuho', 'link', 'yuho', label);
  // PTS
  trackEvent('.link-pts', 'link', 'pts', label);
  // SBI
  trackEvent('.link-sbi', 'link', 'sbi', label);
  // 株探
  trackEvent('.link-kabutan', 'link', 'kabutan', label);
  // FISCO
  trackEvent('.link-fisco', 'link', 'fisco', label);
  // 月次Web
  trackEvent('.link-getsuji', 'link', 'getsuji', label);
});
