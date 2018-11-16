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
//= require main/highlight.pack.js
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require tag-it
//= require turbolinks
//= require_tree ./main

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

          return   '<h' + level + ' class="markdown_heading">' + text + '</h' + level + '>' + '<style type="text/css">h' + level + '.markdown_heading {padding-bottom: 2px;border-bottom: inset 2px #ccc;}</style>';
        };

          renderer.code = function (code, language, escaped) {
            if (language !== undefined) {
              var fileName = language.indexOf('.');
              if (fileName !== -1) {
                return '<pre class="hljs">' + '<div id="markdown_language">' + '<div id="markdown_language_itself">' + '<strong>' + language + '</strong>' + '</div>' + '</div>'
                + '<code>' +  hljs.highlightAuto(code).value + '</code>' + '</pre>'
                + '<style type="text/css">pre.hljs {background-color: #333;margin-top:10px;margin-left: -20px;margin-right: -20px;padding: 20px;}'
                + 'div#markdown_language {background-color: #333;color: #000; width: 100%;margin-bottom: 20px;}'
                + 'div#markdown_language_itself {color: #fff;display: inline-block;}</style>';
              }
            }
              return '<pre class="hljs">' + '<code id="markdown_code">' +  hljs.highlightAuto(code).value + '</code>' + '</pre>'
              + '<style type="text/css">pre.hljs {background-color: #333;margin-top:10px;margin-left: -20px;margin-right: -20px;padding-left: 35px;padding-top: 10px;padding-bottom: 10px;}</style>';
            };

          renderer.blockquote = function (quote) {
            return '<div id="quote">'+ quote + '</div>' + '<style type="text/css">div#quote {border-left:inset 10px #ccc;color: #333;padding-left: 10px;padding-top: 15px;padding-bottom: 15px;margin-top: 10px;}</style>';
          };

          renderer.list = function(body, ordered, start) {
            var type = ordered ? 'ol' : 'ul',
                startatt = (ordered && start !== 1) ? (' start="' + start + '"') : '';
            return '<' + type + startatt + '>\n' + body + '</' + type + '>\n';
          };

          renderer.listitem = function(text) {
            return '<li class="markdown_list">' + text + '</li>\n' + '<style type="text/css">li.markdown_list {margin-left: 20px; white-space:normal;}</style>';
          };

          renderer.table = function(header, body) {
            if (body) body = '<tbody>' + body + '</tbody>';

            return '<table class="markdown_table">\n'
              + '<thead>\n'
              + header
              + '</thead>\n'
              + body
              + '</table>\n'
              + '<style type="text/css">'
              + 'table.markdown_table {display: inline-block;height: auto;width: 100%height: auto;margin-top: 10px;border-collapse: collapse;text-align: center;}td.markdown_tdh {border: solid 1px;padding: 0.5em;}th {background-color: #ccc;border: solid 1px;padding: 0.5em;}'
              + '</style>';
          };

          renderer.tablerow = function(content) {
            return '<tr>\n' + content + '</tr>\n';
          };

          renderer.tablecell = function(content, flags) {
            var type = flags.header ? 'th' : 'td';
            var tag = flags.align
              ? '<' + type + ' align="' + flags.align + ' class="markdown_tdh">'
              : '<' + type + ' class="markdown_tdh">';
            return tag + content + '</' + type + '>\n';
          };

          renderer.text = function(text) {
            var escape_letter = text.indexOf('`');
            if (escape_letter !== -1) {
              return text;
            }
            return '<p class="markdown_text">' + text + '</p>'+ '<style type="text/css">p.markdown_text {white-space:pre;}</style>';
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
