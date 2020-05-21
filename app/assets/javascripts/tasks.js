// Turbolinksが有効な場合ページ遷移をAjax化し高速化を図っているためイベントが発生しない。
// turbolinks:loadを記述し有効にする
document.addEventListener("turbolinks:load", function () {
  document.querySelectorAll("td").forEach(function (td) {
    td.addEventListener("mouseover", function (e) {
      e.currentTarget.style.backgroundColor = "#eff";
    });

    td.addEventListener("mouseout", function (e) {
      e.currentTarget.style.backgroundColor = "";
    });
  });
});
