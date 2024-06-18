// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application";

Rails.start()
Turbolinks.start()
ActiveStorage.start()


// 画像非同期化
document.addEventListener('turbolinks:load', () => {
  const image = document.getElementById('profile-image');
  const loadingText = document.getElementById('image-loading-text');

  // 画像読み込み完了時の処理
  image.onload = function() {
    loadingText.style.display = 'none';
    image.style.display = 'block';
  };

  // 画像読み込み失敗時の処理
  image.onerror = function() {
    loadingText.style.display = 'none';
    image.style.display = 'none'; // 画像非表示
    // 代替テキストやデフォルト画像を表示する処理をここに追加
  };

  // 画像読み込み開始時の処理
  image.onloading = function() {
    loadingText.style.display = 'block';
    image.style.display = 'none'; // 画像非表示
  };

});

// 管理者側ユーザー一覧表示用
document.addEventListener('turbolinks:load', function() {
  const userRows = document.querySelectorAll('.user-row');

  userRows.forEach(row => {
    row.addEventListener('click', function() {
      const userId = this.dataset.userId;

      fetch(`/admin/users/${userId}`)
        .then(response => response.text())
        .then(data => {
          document.getElementById('user-detail').innerHTML = data;
        })
        .catch(error => {
          console.error('Error fetching user details:', error);
        });
    });
  });
});

// タブメニューの記述
$(document).on('turbolinks:load', function() {
  $('#tab-contents .tab').not('#tab1').hide();

  $('#tab-menu').on('click', 'a', function(event) {
    $('#tab-contents .tab').hide();
    $('#tab-menu .active').removeClass('active');
    $(this).addClass('active');
    $($(this).attr('href')).show();
    event.preventDefault();
  });
});