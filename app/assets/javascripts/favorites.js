$(function () {
  var stocks = document.getElementById('stocks-show');
  var favorites = document.getElementById('favorites-index');

  if (!stocks && !favorites) { return };

  function getStockId() {
    return $('#stock-id').data('stock_id');
  }

  function getUrl() {
    return '/stocks/' + getStockId() + '/favorite';
  }

  function getCsrfToken() {
    return $('meta[name="csrf-token"]').attr('content');
  }

  function toggleFav() {
    $('.js-fav').toggleClass('hide');
  }

  function statusOk(callback) {
    return function(data) {
      if (data && data.status === 'ok') {
        callback();
      }
    }
  }

  function addFav() {
    toggleFav();

    var url = getUrl();
    var token = getCsrfToken();
    var data = {authenticity_token: token};

    $.post(url, data)
      .fail(toggleFav);
  }

  function deleteFav() {
    toggleFav();

    var url = getUrl();
    var token = getCsrfToken();
    var data = {
      data: {authenticity_token: token},
      type: 'DELETE',
    };

    $.ajax(url, data)
      .fail(toggleFav);
  }

  function favoriteCheck() {
    var url = getUrl();

    $.get(url)
      .done(statusOk(toggleFav));
  }

  if (stocks) {
    // お気に入りチェック
    favoriteCheck();

    // お気に入りツールチップ
    $('[data-toggle="tooltip"]').tooltip();
  }

  // お気に入り登録/解除
  $('#fav-on').click(addFav);
  $('#fav-off').click(deleteFav);
});
