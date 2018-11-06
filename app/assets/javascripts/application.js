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
//= require highlight.pack.js
//= require rails-ujs
//= require activestorage
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require tag-it
//= require turbolinks
//= require_tree .

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

          return   '<h' + level + '>' + text + '</h' + level + '>' + '<style type="text/css">h' + level + ' {padding-bottom: 2px;border-bottom: inset 2px #ccc;}</style>';
        };

          renderer.code = function (code, language, escaped) {
            if (language !== undefined) {
              var fileName = language.indexOf('.');
              if (fileName !== -1) {
                return '<pre class="hljs">' + '<div id="language">' + '<div id="language_itself">' + '<strong>' + language + '</strong>' + '</div>' + '</div>'
                + '<code>' +  hljs.highlightAuto(code).value + '</code>' + '</pre>'
                + '<style type="text/css">pre.hljs {background-color: #333;margin-top:10px;margin-left: -20px;margin-right: -20px;}'
                + 'div#language {background-color: #333;color: #000; width: 100%;margin-bottom: 20px;}'
                + 'div#language_itself {color: #fff;display: inline-block;}</style>';
              }
            }
              return '<pre class="hljs">' + '<code id="code">' +  hljs.highlightAuto(code).value + '</code>' + '</pre>'
              + '<style type="text/css">pre.hljs {background-color: #333;margin-top:10px;margin-left: -20px;margin-right: -20px;padding-left: 35px;}</style>';
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
            return '<li>' + text + '</li>\n' + '<style type="text/css">li {margin-left: 20px; white-space:normal;}</style>';
          };

          renderer.table = function(header, body) {
            if (body) body = '<tbody>' + body + '</tbody>';

            return '<table>\n'
              + '<thead>\n'
              + header
              + '</thead>\n'
              + body
              + '</table>\n'
              + '<style type="text/css">'
              + 'table {margin-top: 10px;border-collapse: collapse;}td {border: solid 1px;padding: 0.5em;}th {background-color: #ccc;border: solid 1px;padding: 0.5em;}'
              + '</style>';
          };

          renderer.tablerow = function(content) {
            return '<tr>\n' + content + '</tr>\n';
          };

          renderer.tablecell = function(content, flags) {
            var type = flags.header ? 'th' : 'td';
            var tag = flags.align
              ? '<' + type + ' align="' + flags.align + '">'
              : '<' + type + '>';
            return tag + content + '</' + type + '>\n';
          };

          renderer.text = function(text) {
            return '<p class="unique">' + text + '</p>'+ '<style type="text/css">p.unique {white-space:pre;}</style>';
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
    });
