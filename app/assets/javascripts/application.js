// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery.remotipart
//= require main/highlight.pack.js
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require tag-it
//= require turbolinks
//= require_tree ./main
//


$(document).on('turbolinks:load', function () {
	$('.dashboard_article_info_substitute_button').on('click', function() {
		 $('#dashboard_article_info-open').click();
  });
});

$(document).on('turbolinks:load', function(){
	$(".article_comment_field").change(function(){
		$(".article_comment_form").submit();
	});
});

$(document).on('turbolinks:load', function () {
	$('.article_comment_submit_button').on('click', function() {
		 $('.article_comment_submit').click();
  });
});

$(document).on('turbolinks:load', function(){
	$(".dashboard_search_select").change(function(){
		$(".dashboard_search_form").submit();
	});
});

$(document).on('turbolinks:load', function() {
	//クリックしたときのファンクションをまとめて指定
	$('.tab li').click(function() {

		//.index()を使いクリックされたタブが何番目かを調べ、
		//indexという変数に代入します。
		var index = $('.tab li').index(this);

		//コンテンツを一度すべて非表示にし、
		$('.content li').css('display','none');

		//クリックされたタブと同じ順番のコンテンツを表示します。
		$('.content li').eq(index).css('display','block');

		//一度タブについているクラスselectを消し、
		$('.tab li').removeClass('select');

		//クリックされたタブのみにクラスselectをつけます。
		$(this).addClass('select')
	});
});


/*記事作成画面でarticle_pictureを選択すると自動的にsubmnitされる*/
$(document).on('turbolinks:load', function () {
  $("#article_picture_form").change(function () {
    $('.article_picture_submit').click();
  });
});

/*画像保存アイコンをクリックしたらfile_fieldがクリックされる*/
$(document).on('turbolinks:load', function () {
	$('.article_picture_form_sub').on('click', function() {
		 $('.article_picture_field').click();
  });
});

/*article_pictures_controllerから送られたjsonを受け取って表示する*/
$(document).on('turbolinks:load', function() {
	$('#article_picture_form').on('ajax:success', function(event) {
	    data = event.detail[0];
			var v= $('#article_body').val();
	    var selin = $('#article_body').prop('selectionStart');
	    var selout = $('#article_body').prop('selectionEnd');
	    var befStr="\n" + '![image]' + '(' + data['picture']['url'] + ')';
	    var aftStr="";
	    var v1=v.substr(0,selin);
	    var v2=v.substr(selin,selout-selin);
	    var v3=v.substr(selout);
	    $('#article_body')
	      .val(v1+befStr+v2+aftStr+v3)
	      .prop({
	        "selectionStart":selin+befStr.length,
	        "selectionEnd":selin+befStr.length+v2.length
	        })
	      .trigger("focus");
	  });
});

$(document).on('turbolinks:load', function() {

	//.accordion8の中のli要素の中のp要素がクリックされた時
	$('.display_size').click(function() {
		//クリックされた.accordion8の中のli要素の中のp要素に隣接する要素の横幅を開いたり閉じたりする。
		$('#editor tr td.article_form_main').next().animate({width:'toggle'});
    $(".expand_form").toggleClass("expand_form_after");
    $(".reduce_form").toggleClass("reduce_form_after");
	});
});

/*マークダウンエディターの補助機能*/
$(document).on('turbolinks:load', function(){
  $('.markdown_code').on('click',function(e){
    var v= $('#article_body').val();
    var selin = $('#article_body').prop('selectionStart');
    var selout = $('#article_body').prop('selectionEnd');
    var befStr="```\n";
    var aftStr="\n```";
    var v1=v.substr(0,selin);
    var v2=v.substr(selin,selout-selin);
    var v3=v.substr(selout);
    $('#article_body')
      .val(v1+befStr+v2+aftStr+v3)
      .prop({
        "selectionStart":selin+befStr.length,
        "selectionEnd":selin+befStr.length+v2.length
        })
      .trigger("focus");
  });
});

$(document).on('turbolinks:load', function(){
  $('.markdown_table').on('click',function(e){
    var v= $('#article_body').val();
    var selin = $('#article_body').prop('selectionStart');
    var selout = $('#article_body').prop('selectionEnd');
    var befStr="| hoge | hoge |\n| -- | -- |\n| hoge | hoge |";
    var aftStr="";
    var v1=v.substr(0,selin);
    var v2=v.substr(selin,selout-selin);
    var v3=v.substr(selout);
    $('#article_body')
      .val(v1+befStr+v2+aftStr+v3)
      .prop({
        "selectionStart":selin+befStr.length,
        "selectionEnd":selin+befStr.length+v2.length
        })
      .trigger("focus");
  });
});

$(document).on('turbolinks:load', function(){
  $('.markdown_quote').on('click',function(e){
    var v= $('#article_body').val();
    var selin = $('#article_body').prop('selectionStart');
    var selout = $('#article_body').prop('selectionEnd');
    var befStr="> ";
    var aftStr="";
    var v1=v.substr(0,selin);
    var v2=v.substr(selin,selout-selin);
    var v3=v.substr(selout);
    $('#article_body')
      .val(v1+befStr+v2+aftStr+v3)
      .prop({
        "selectionStart":selin+befStr.length,
        "selectionEnd":selin+befStr.length+v2.length
        })
      .trigger("focus");
  });
});

$(document).on('turbolinks:load', function(){
  $('.markdown_list').on('click',function(e){
    var v= $('#article_body').val();
    var selin = $('#article_body').prop('selectionStart');
    var selout = $('#article_body').prop('selectionEnd');
    var befStr="- ";
    var aftStr="";
    var v1=v.substr(0,selin);
    var v2=v.substr(selin,selout-selin);
    var v3=v.substr(selout);
    $('#article_body')
      .val(v1+befStr+v2+aftStr+v3)
      .prop({
        "selectionStart":selin+befStr.length,
        "selectionEnd":selin+befStr.length+v2.length
        })
      .trigger("focus");
  });
});

/*マークダウンエティターのプレビュー機能*/
$(document).on('turbolinks:load', function() {
    hljs.initHighlighting.called = false;
    hljs.initHighlighting();
});

$(document).on('turbolinks:load', function() {

        var renderer = new marked.Renderer();

        renderer.em = function(text) {
            var indexNumber = text.indexOf('/');
            if (indexNumber !== -1 && text.substr(indexNumber - 1, 1) !== "\\") {
                return '<span style="color:' + text.substr(0, indexNumber) + ';">' + text.substr(indexNumber + 1) + '</span>';
            }
            return '<em>' + text.replace('\\/', '/') + '</em>';
        };

        renderer.heading = function (text, level) {

          return   '<h' + level + ' class="markdown_heading">' + text + '</h' + level + '>';
        };

          renderer.code = function (code, language, escaped) {
            if (language !== undefined) {
              var fileName = language.indexOf('.');
              if (fileName !== -1) {
                return '<pre class="hljs">' + '<div class="markdown_file_name">' + '<div class="markdown_file_name_itself">' + language  + '</div>' + '</div>'
                + '<code>' +  hljs.highlightAuto(code).value + '</code>' + '</pre>';
              }
            }
              return '<pre class="hljs">' + '<code class="markdown_code">' +  hljs.highlightAuto(code).value + '</code>' + '</pre>';
            };

          renderer.blockquote = function (quote) {
            return '<div class="markdown_quote">'+ quote + '</div>';
          };

          renderer.list = function(body, ordered, start) {
            var type = ordered ? 'ol' : 'ul',
                startatt = (ordered && start !== 1) ? (' start="' + start + '"') : '';
            return '<' + type + startatt + '>\n' + body + '</' + type + '>\n';
          };

          renderer.listitem = function(text) {
            return '<li class="markdown_list">' + text + '</li>\n';
          };

          renderer.table = function(header, body) {
            if (body) body = '<tbody>' + body + '</tbody>';

            return '<table class="markdown_table">\n'
              + '<thead>\n'
              + header
              + '</thead>\n'
              + body
              + '</table>\n';
          };

          renderer.tablerow = function(content) {
            return '<tr>\n' + content + '</tr>\n';
          };

          renderer.tablecell = function(content, flags) {
            var type = flags.header ? 'th' : 'td';
            if (type === "td") {
              var class_name = "markdown_td"
            } else {
              var class_name = "markdown_th"
            }
            var tag = flags.align
              ? '<' + type + ' align="' + flags.align + ' class=' + class_name + '>'
              : '<' + type + ' class=' + class_name + '>';
            return tag + content + '</' + type + '>\n';
          };

          renderer.text = function(text) {
            var backspace = text.indexOf('`');
						var delete_line = text.indexOf('~')
						var asterisk = text.indexOf('*')
            if (backspace !== -1 || delete_line !== -1 || asterisk !== -1) {
              return text;
            }
            return '<p class="markdown_text">' + text + '</p>';
          };


					renderer.image = function(href, title, text) {
					  if (href === null) {
					    return text;
					  }
					  var out = '<p class="markdown_image"><img src="' + href + '" alt="' + text + '"></p>';
					  return out;
					};

					renderer.em = function(text) {
					  return '<em>' + text + '</em>';
					};

					renderer.del = function(text) {
					  return '<s>' + text + '</s>';
					};



        marked.setOptions({
            renderer: renderer,
            smartLists: false
        });

        new Vue({
            el: '#editor',
            data: {
                input: '# hello'
            },
            filters: {
                marked: marked
            }
        })

        new Vue({
            el: '#comment_editor',
            data: {
                input: '# hello'
            },
            filters: {
                marked: marked
            }
        })
    });
