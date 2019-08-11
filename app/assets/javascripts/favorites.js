$(function () {
  var stocks = document.getElementById('stocks-show');
  var favorites = document.getElementById('favorites-index');

  if (!stocks && !favorites) { return };

  function getStockId(elm) {
    return elm.getAttribute('data-stock_id');
  }

  function getUrl(elm) {
    return '/stocks/' + getStockId(elm) + '/favorite';
  }

  function getCsrfToken() {
    return $('meta[name="csrf-token"]').attr('content');
  }

  function toggleFav(elm) {
    var stock_id = getStockId(elm);

    return function() {
      var selector = '.js-fav-' + stock_id;
      $(selector).toggleClass('hide');
    }
  }

  function statusOk(callback) {
    return function(data) {
      if (data && data.status === 'ok') {
        callback();
      }
    }
  }

  function addFav(e) {
    var elm = e.currentTarget;
    toggleFav(elm)();

    var url = getUrl(elm);
    var token = getCsrfToken();
    var data = {authenticity_token: token};

    $.post(url, data)
      .fail(toggleFav(elm));
  }

  function deleteFav(e) {
    var elm = e.currentTarget;
    toggleFav(elm)();

    var url = getUrl(elm);
    var token = getCsrfToken();
    var data = {
      data: {authenticity_token: token},
      type: 'DELETE',
    };

    $.ajax(url, data)
      .fail(toggleFav(elm));
  }

  function favoriteCheck() {
    var elm = document.querySelector('.js-fav');
    var url = getUrl(elm);

    $.get(url)
      .done(statusOk(toggleFav(elm)));
  }

  if (stocks) {
    // お気に入りチェック
    favoriteCheck();

    // お気に入りツールチップ
    $('[data-toggle="tooltip"]').tooltip();
  }

  // お気に入り登録/解除
  $('.js-fav-on').click(addFav);
  $('.js-fav-off').click(deleteFav);
});
