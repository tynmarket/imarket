$(function () {
  if (!document.getElementById('stocks-show')) { return };

  var data_per, data_pbr, plotData = {};

  // PERを表示
  $.when(requestPer(), clickPerTab())
    .then(renderPerCurrent)
    .done(renderPerEntire);

  // PBRを表示
  $.when(requestPbr(), clickPerTab(true))
    .then(renderPbrCurrent)
    .done(renderPbrEntire);

  // Y軸の最大値を変更
  $("[id^='select-p']").change(function(e) {
    $select = $(e.currentTarget);
    id = $select.attr('id');
    data = plotData[id];
    max = $select.val();
    if (max) {
      data.options.yaxis = {max: max};
    } else {
      data.options.yaxis = {};
    }
    // 削除して再描画
    data.plot.destroy();
    data.plot = $.plot(data.target, data.data, data.options)
  });

  function requestPer() {
    var d = $.Deferred();
    var code = $('#code').text();
    var url = "/stock_prices/" + code + "/per.json";

    if (code) {
      $.get(url)
        .done(function(response) {
        data_per = response;

        d.resolve();
      });
    }

    return d;
  }

  function requestPbr() {
    var d = $.Deferred();
    var code = $('#code').text();
    var url = "/stock_prices/" + code + "/pbr.json";

    if (code) {
      $.get(url)
        .done(function(response) {
        data_pbr = response;

        d.resolve();
      });
    }

    return d;
  }

  function clickPerTab(pbr) {
    var d = $.Deferred();
    var id = pbr ? '#tab-pbr' : '#tab-per'

    $(id).one('shown.bs.tab', function() {
      d.resolve();
    })

    return d;
  }

  // 年初来
  function renderPerCurrent() {
    var d = $.Deferred();
    var current = data_per.current_year;

    renderPerChart(current, '#per-current', 2);
    d.resolve();

    return d;
  }

  function renderPbrCurrent() {
    var d = $.Deferred();
    var current = data_pbr.current_year;

    renderPerChart(current, '#pbr-current', 2, true);
    d.resolve();

    return d;
  }

  // 全期間
  function renderPerEntire() {
    var entire = data_per.entire_period;

    renderPerChart(entire, '#per-entire', 1.5);
  }

  function renderPbrEntire() {
    var entire = data_pbr.entire_period;

    renderPerChart(entire, '#pbr-entire', 1.5, true);
  }

  // TODO canvasで描画する？
  function renderPerChart(dataset, target, lineWidth, pbr) {
    var options = {
      grid: {
        hoverable: true,
        labelMargin: 10,
      },
      xaxis: {
        ticks: dataset.ticks,
        tickFormatter: function(val, axis) {
          return dataset.x_label[val];
        },
      },
      series: {
        lines: {
          lineWidth: lineWidth,
        },
        highlightColor: "rgba(151,187,205,1)",
      },
    };

    var max = Math.max.apply(null, dataset.data.map(function(array) {
      return array[1];
    }));

    if (!pbr) {
      if (max > 50) {
        max = 50
        options.yaxis = { max: max }
      }
    }

    if (target === '#per-current') {
      data = plotData['select-per-current'] = {};
    } else if (target === '#per-entire') {
      data = plotData['select-per-entire'] = {};
    } else if (target === '#pbr-current') {
      data = plotData['select-pbr-current'] = {};
    } else if (target === '#pbr-entire') {
      data = plotData['select-pbr-entire'] = {};
    }

    // グラフのデータを退避
    data.options = options;
    data.data = [dataset.data];
    data.target = target;
    // グラフ描画
    data.plot = $.plot(target, [dataset.data], options);

    var idTooltip = pbr ? "#tooltip-pbr" : "#tooltip-per"
    $(target).bind("plothover", function (event, pos, item) {
      if (item) {
        var x = "（" + dataset.x_label[item.datapoint[0]] + "）",
        y = "&nbsp" + item.datapoint[1] + " 倍";

        $(idTooltip).html(y + x)
          .css({top: item.pageY-25, left: item.pageX+10})
          .fadeIn(200);
      } else {
        $(idTooltip).hide();
      }
    });
  }

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
