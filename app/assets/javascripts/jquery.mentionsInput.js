/*
    jQuery `input` special event v1.0

    http://whattheheadsaid.com/projects/input-special-event

    (c) 2010-2011 Andy Earnshaw
    MIT license
    www.opensource.org/licenses/mit-license.php

    Modified by Kenneth Auchenberg
    * Disabled usage of onPropertyChange event in IE, since its a bit delayed, if you type really fast.
*/

(function($) {
  // Handler for propertychange events only
  function propHandler() {
    var $this = $(this);
    if (window.event.propertyName == "value" && !$this.data("triggering.inputEvent")) {
      $this.data("triggering.inputEvent", true).trigger("input");
      window.setTimeout(function () {
        $this.data("triggering.inputEvent", false);
      }, 0);
    }
  }

  $.event.special.input = {
    setup: function(data, namespaces) {
      var timer,
        // Get a reference to the element
        elem = this,
        // Store the current state of the element
        state = elem.value,
        // Create a dummy element that we can use for testing event support
        tester = document.createElement(this.tagName),
        // Check for native oninput
        oninput = "oninput" in tester || checkEvent(tester),
        // Check for onpropertychange
        onprop = "onpropertychange" in tester,
        // Generate a random namespace for event bindings
        ns = "inputEventNS" + ~~(Math.random() * 10000000),
        // Last resort event names
        evts = ["focus", "blur", "paste", "cut", "keydown", "drop", ""].join("." + ns + " ");

      function checkState() {
        var $this = $(elem);
        if (elem.value != state && !$this.data("triggering.inputEvent")) {
          state = elem.value;

          $this.data("triggering.inputEvent", true).trigger("input");
          window.setTimeout(function () {
            $this.data("triggering.inputEvent", false);
          }, 0);
        }
      }

      // Set up a function to handle the different events that may fire
      function handler(e) {
        // When focusing, set a timer that polls for changes to the value
        if (e.type == "focus") {
          checkState();
          clearInterval(timer);
          timer = window.setInterval(checkState, 250);
        } else if (e.type == "blur") {
          // When blurring, cancel the aforeset timer
          window.clearInterval(timer);
        } else {
          // For all other events, queue a timer to check state ASAP
          window.setTimeout(checkState, 0);
        }
      }

      // Bind to native event if available
      if (oninput) {
        return false;
//      } else if (onprop) {
//        // Else fall back to propertychange if available
//        $(this).find("input, textarea").andSelf().filter("input, textarea").bind("propertychange." + ns, propHandler);
      } else {
        // Else clutch at straws!
        $(this).find("input, textarea").andSelf().filter("input, textarea").bind(evts, handler);
      }
      $(this).data("inputEventHandlerNS", ns);
    },
    teardown: function () {
      var elem = $(this);
      elem.find("input, textarea").unbind(elem.data("inputEventHandlerNS"));
      elem.data("inputEventHandlerNS", "");
    }
  };

  // Setup our jQuery shorthand method
  $.fn.input = function (handler) {
    return handler ? this.bind("input", handler) : this.trigger("input");
  };

  /*
   The following function tests the element for oninput support in Firefox.  Many thanks to
   http://blog.danielfriesen.name/2010/02/16/html5-browser-maze-oninput-support/
   */
  function checkEvent(el) {
    // First check, for if Firefox fixes its issue with el.oninput = function
    el.setAttribute("oninput", "return");
    if (typeof el.oninput == "function") {
      return true;
    }
    // Second check, because Firefox doesn't map oninput attribute to oninput property
    try {

      // "* Note * : Disabled focus and dispatch of keypress event due to conflict with DOMready, which resulted in scrolling down to the bottom of the page, possibly because layout wasn't finished rendering.
      var e = document.createEvent("KeyboardEvent"),
        ok = false,
        tester = function(e) {
          ok = true;
          e.preventDefault();
          e.stopPropagation();
      };

      // e.initKeyEvent("keypress", true, true, window, false, false, false, false, 0, "e".charCodeAt(0));

      document.body.appendChild(el);
      el.addEventListener("input", tester, false);
      // el.focus();
      // el.dispatchEvent(e);
      el.removeEventListener("input", tester, false);
      document.body.removeChild(el);
      return ok;

    } catch(error) {

    }
  }
})(jQuery);

/**
*  @name							Elastic
*	@descripton						Elastic is jQuery plugin that grow and shrink your textareas automatically
*	@version						1.6.11
*	@requires						jQuery 1.2.6+
*
*	@author							Jan Jarfalk
*	@author-email					jan.jarfalk@unwrongest.com
*	@author-website					http://www.unwrongest.com
*
*	@licence						MIT License - http://www.opensource.org/licenses/mit-license.php
*/

(function($){ 
	jQuery.fn.extend({  
		elastic: function() {
		
			//	We will create a div clone of the textarea
			//	by copying these attributes from the textarea to the div.
			var mimics = [
				'paddingTop',
				'paddingRight',
				'paddingBottom',
				'paddingLeft',
				'fontSize',
				'lineHeight',
				'fontFamily',
				'width',
				'fontWeight',
				'border-top-width',
				'border-right-width',
				'border-bottom-width',
				'border-left-width',
				'borderTopStyle',
				'borderTopColor',
				'borderRightStyle',
				'borderRightColor',
				'borderBottomStyle',
				'borderBottomColor',
				'borderLeftStyle',
				'borderLeftColor'
				];
			
			return this.each( function() {

				// Elastic only works on textareas
				if ( this.type !== 'textarea' ) {
					return false;
				}
					
			var $textarea	= jQuery(this),
				$twin		= jQuery('<div />').css({
					'position'		: 'absolute',
					'display'		: 'none',
					'word-wrap'		: 'break-word',
					'white-space'	:'pre-wrap'
				}),
				lineHeight	= parseInt($textarea.css('line-height'),10) || parseInt($textarea.css('font-size'),'10'),
				minheight	= parseInt($textarea.css('height'),10) || lineHeight*3,
				maxheight	= parseInt($textarea.css('max-height'),10) || Number.MAX_VALUE,
				goalheight	= 0;
				
				// Opera returns max-height of -1 if not set
				if (maxheight < 0) { maxheight = Number.MAX_VALUE; }
					
				// Append the twin to the DOM
				// We are going to meassure the height of this, not the textarea.
				$twin.appendTo($textarea.parent());
				
				// Copy the essential styles (mimics) from the textarea to the twin
				var i = mimics.length;
				while(i--){
					$twin.css(mimics[i].toString(),$textarea.css(mimics[i].toString()));
				}
				
				// Updates the width of the twin. (solution for textareas with widths in percent)
				function setTwinWidth(){
					var curatedWidth = Math.floor(parseInt($textarea.width(),10));
					if($twin.width() !== curatedWidth){
						$twin.css({'width': curatedWidth + 'px'});
						
						// Update height of textarea
						update(true);
					}
				}
				
				// Sets a given height and overflow state on the textarea
				function setHeightAndOverflow(height, overflow){
				
					var curratedHeight = Math.floor(parseInt(height,10));
					if($textarea.height() !== curratedHeight){
						$textarea.css({'height': curratedHeight + 'px','overflow':overflow});
					}
				}
				
				// This function will update the height of the textarea if necessary 
				function update(forced) {
					
					// Get curated content from the textarea.
					var textareaContent = $textarea.val().replace(/&/g,'&amp;').replace(/ {2}/g, '&nbsp;').replace(/<|>/g, '&gt;').replace(/\n/g, '<br />');
					
					// Compare curated content with curated twin.
					var twinContent = $twin.html().replace(/<br>/ig,'<br />');
					
					if(forced || textareaContent+'&nbsp;' !== twinContent){
					
						// Add an extra white space so new rows are added when you are at the end of a row.
						$twin.html(textareaContent+'&nbsp;');
						
						// Change textarea height if twin plus the height of one line differs more than 3 pixel from textarea height
						if(Math.abs($twin.height() + lineHeight - $textarea.height()) > 3){
							
							var goalheight = $twin.height()+lineHeight;
							if(goalheight >= maxheight) {
								setHeightAndOverflow(maxheight,'auto');
							} else if(goalheight <= minheight) {
								setHeightAndOverflow(minheight,'hidden');
							} else {
								setHeightAndOverflow(goalheight,'hidden');
							}
							
						}
						
					}
					


				}
				
				// Hide scrollbars
				$textarea.css({'overflow':'hidden'});
				
				// Update textarea size on keyup, change, cut and paste
				$textarea.bind('keyup change cut paste', function(){
					update(); 
				});
				
				// Update width of twin if browser or textarea is resized (solution for textareas with widths in percent)
				$(window).bind('resize', setTwinWidth);
				$textarea.bind('resize', setTwinWidth);
				$textarea.bind('update', update);
				
				// Compact textarea on blur
				$textarea.bind('blur',function(){
					if($twin.height() < maxheight){
						if($twin.height() > minheight) {
							$textarea.height($twin.height());
						} else {
							$textarea.height(minheight);
						}
					}
				});
				
				// And this line is to catch the browser paste event
				$textarea.bind('input paste',function(e){ setTimeout( update, 250); });				
				
				// Run update once when elastic is initialized
				update();
				
			});
			
        } 
    }); 
})(jQuery);

/*
 * Mentions Input
 * Version 1.0.2
 * Written by: Kenneth Auchenberg (Podio)
 *
 * Using underscore.js
 *
 * License: MIT License - http://www.opensource.org/licenses/mit-license.php
 */

(function ($, _, undefined) {

  // Settings
  var KEY = { BACKSPACE : 8, TAB : 9, RETURN : 13, ESC : 27, LEFT : 37, UP : 38, RIGHT : 39, DOWN : 40, COMMA : 188, SPACE : 32, HOME : 36, END : 35 }; // Keys "enum"
  var defaultSettings = {
    triggerChar   : '@',
    onDataRequest : $.noop,
    minChars      : 2,
    showAvatars   : true,
    elastic       : true,
    classes       : {
      autoCompleteItemActive : "active"
    },
    templates     : {
      wrapper                    : _.template('<div class="mentions-input-box"></div>'),
      autocompleteList           : _.template('<div class="mentions-autocomplete-list"></div>'),
      autocompleteListItem       : _.template('<li data-ref-id="<%= id %>" data-ref-type="<%= type %>" data-display="<%= display %>"><%= content %></li>'),
      autocompleteListItemAvatar : _.template('<img src="<%= avatar %>" />'),
      autocompleteListItemIcon   : _.template('<div class="icon <%= icon %>"></div>'),
      mentionsOverlay            : _.template('<div class="mentions"><div></div></div>'),
      mentionItemSyntax          : _.template('@[<%= value %>](<%= type %>:<%= id %>)'),
      mentionItemHighlight       : _.template('<strong><span><%= value %></span></strong>')
    }
  };

  var utils = {
    htmlEncode       : function (str) {
      return _.escape(str);
    },
    highlightTerm    : function (value, term) {
      if (!term && !term.length) {
        return value;
      }
      return value.replace(new RegExp("(?![^&;]+;)(?!<[^<>]*)(" + term + ")(?![^<>]*>)(?![^&;]+;)", "gi"), "<b>$1</b>");
    },
    setCaratPosition : function (domNode, caretPos) {
      if (domNode.createTextRange) {
        var range = domNode.createTextRange();
        range.move('character', caretPos);
        range.select();
      } else {
        if (domNode.selectionStart) {
          domNode.focus();
          domNode.setSelectionRange(caretPos, caretPos);
        } else {
          domNode.focus();
        }
      }
    },
    rtrim: function(string) {
      return string.replace(/\s+$/,"");
    }
  };

  var MentionsInput = function (settings) {

    var domInput, elmInputBox, elmInputWrapper, elmAutocompleteList, elmWrapperBox, elmMentionsOverlay, elmActiveAutoCompleteItem;
    var mentionsCollection = [];
    var autocompleteItemCollection = {};
    var inputBuffer = [];
    var currentDataQuery;

    settings = $.extend(true, {}, defaultSettings, settings );

    function initTextarea() {
      elmInputBox = $(domInput);

      if (elmInputBox.attr('data-mentions-input') == 'true') {
        return;
      }

      elmInputWrapper = elmInputBox.parent();
      elmWrapperBox = $(settings.templates.wrapper());
      elmInputBox.wrapAll(elmWrapperBox);
      elmWrapperBox = elmInputWrapper.find('> div');

      elmInputBox.attr('data-mentions-input', 'true');
      elmInputBox.bind('keydown', onInputBoxKeyDown);
      elmInputBox.bind('keypress', onInputBoxKeyPress);
      elmInputBox.bind('input', onInputBoxInput);
      elmInputBox.bind('click', onInputBoxClick);
      elmInputBox.bind('blur', onInputBoxBlur);

      // Elastic textareas, internal setting for the Dispora guys
      if( settings.elastic ) {
        elmInputBox.elastic();
      }

    }

    function initAutocomplete() {
      elmAutocompleteList = $(settings.templates.autocompleteList());
      elmAutocompleteList.appendTo(elmWrapperBox);
      elmAutocompleteList.delegate('li', 'mousedown', onAutoCompleteItemClick);
    }

    function initMentionsOverlay() {
      elmMentionsOverlay = $(settings.templates.mentionsOverlay());
      elmMentionsOverlay.prependTo(elmWrapperBox);
    }

    function updateValues() {
      var syntaxMessage = getInputBoxValue();

      _.each(mentionsCollection, function (mention) {
        var textSyntax = settings.templates.mentionItemSyntax(mention);
        syntaxMessage = syntaxMessage.replace(mention.value, textSyntax);
      });

      var mentionText = utils.htmlEncode(syntaxMessage);

      _.each(mentionsCollection, function (mention) {
        var formattedMention = _.extend({}, mention, {value: utils.htmlEncode(mention.value)});
        var textSyntax = settings.templates.mentionItemSyntax(formattedMention);
        var textHighlight = settings.templates.mentionItemHighlight(formattedMention);

        mentionText = mentionText.replace(textSyntax, textHighlight);
      });

      mentionText = mentionText.replace(/\n/g, '<br />');
      mentionText = mentionText.replace(/ {2}/g, '&nbsp; ');

      elmInputBox.data('messageText', syntaxMessage);
      elmMentionsOverlay.find('div').html(mentionText);
    }

    function resetBuffer() {
      inputBuffer = [];
    }

    function updateMentionsCollection() {
      var inputText = getInputBoxValue();

      mentionsCollection = _.reject(mentionsCollection, function (mention, index) {
        return !mention.value || inputText.indexOf(mention.value) == -1;
      });
      mentionsCollection = _.compact(mentionsCollection);
    }

    function addMention(mention) {

      var currentMessage = getInputBoxValue();

      // Using a regex to figure out positions
      var regex = new RegExp("\\" + settings.triggerChar + currentDataQuery, "gi");
      regex.exec(currentMessage);

      var startCaretPosition = regex.lastIndex - currentDataQuery.length - 1;
      var currentCaretPosition = regex.lastIndex;

      var start = currentMessage.substr(0, startCaretPosition);
      var end = currentMessage.substr(currentCaretPosition, currentMessage.length);
      var startEndIndex = (start + mention.value).length + 1;

      mentionsCollection.push(mention);

      // Cleaning before inserting the value, otherwise auto-complete would be triggered with "old" inputbuffer
      resetBuffer();
      currentDataQuery = '';
      hideAutoComplete();

      // Mentions & syntax message
      var updatedMessageText = start + mention.value + ' ' + end;
      elmInputBox.val(updatedMessageText);
      updateValues();

      // Set correct focus and selection
      elmInputBox.focus();
      utils.setCaratPosition(elmInputBox[0], startEndIndex);
    }

    function getInputBoxValue() {
      return $.trim(elmInputBox.val());
    }

    function onAutoCompleteItemClick(e) {
      var elmTarget = $(this);
      var mention = autocompleteItemCollection[elmTarget.attr('data-uid')];

      addMention(mention);

      return false;
    }

    function onInputBoxClick(e) {
      resetBuffer();
    }

    function onInputBoxBlur(e) {
      hideAutoComplete();
    }

    function onInputBoxInput(e) {
      updateValues();
      updateMentionsCollection();

      var triggerCharIndex = _.lastIndexOf(inputBuffer, settings.triggerChar);
      if (triggerCharIndex > -1) {
        currentDataQuery = inputBuffer.slice(triggerCharIndex + 1).join('');
        currentDataQuery = utils.rtrim(currentDataQuery);

        _.defer(_.bind(doSearch, this, currentDataQuery));
      }
    }

    function onInputBoxKeyPress(e) {
      if(e.keyCode !== KEY.BACKSPACE) {
        var typedValue = String.fromCharCode(e.which || e.keyCode);
        inputBuffer.push(typedValue);
      }
    }

    function onInputBoxKeyDown(e) {

      // This also matches HOME/END on OSX which is CMD+LEFT, CMD+RIGHT
      if (e.keyCode == KEY.LEFT || e.keyCode == KEY.RIGHT || e.keyCode == KEY.HOME || e.keyCode == KEY.END) {
        // Defer execution to ensure carat pos has changed after HOME/END keys
        _.defer(resetBuffer);

        // IE9 doesn't fire the oninput event when backspace or delete is pressed. This causes the highlighting
        // to stay on the screen whenever backspace is pressed after a highlighed word. This is simply a hack
        // to force updateValues() to fire when backspace/delete is pressed in IE9.
        if (navigator.userAgent.indexOf("MSIE 9") > -1) {
          _.defer(updateValues);
        }

        return;
      }

      if (e.keyCode == KEY.BACKSPACE) {
        inputBuffer = inputBuffer.slice(0, -1 + inputBuffer.length); // Can't use splice, not available in IE
        return;
      }

      if (!elmAutocompleteList.is(':visible')) {
        return true;
      }

      switch (e.keyCode) {
        case KEY.UP:
        case KEY.DOWN:
          var elmCurrentAutoCompleteItem = null;
          if (e.keyCode == KEY.DOWN) {
            if (elmActiveAutoCompleteItem && elmActiveAutoCompleteItem.length) {
              elmCurrentAutoCompleteItem = elmActiveAutoCompleteItem.next();
            } else {
              elmCurrentAutoCompleteItem = elmAutocompleteList.find('li').first();
            }
          } else {
            elmCurrentAutoCompleteItem = $(elmActiveAutoCompleteItem).prev();
          }

          if (elmCurrentAutoCompleteItem.length) {
            selectAutoCompleteItem(elmCurrentAutoCompleteItem);
          }

          return false;

        case KEY.RETURN:
        case KEY.TAB:
          if (elmActiveAutoCompleteItem && elmActiveAutoCompleteItem.length) {
            elmActiveAutoCompleteItem.trigger('mousedown');
            return false;
          }

          break;
      }

      return true;
    }

    function hideAutoComplete() {
      elmActiveAutoCompleteItem = null;
      elmAutocompleteList.empty().hide();
    }

    function selectAutoCompleteItem(elmItem) {
      elmItem.addClass(settings.classes.autoCompleteItemActive);
      elmItem.siblings().removeClass(settings.classes.autoCompleteItemActive);

      elmActiveAutoCompleteItem = elmItem;
    }

    function populateDropdown(query, results) {
      elmAutocompleteList.show();

      // Filter items that has already been mentioned
      var mentionValues = _.pluck(mentionsCollection, 'value');
      results = _.reject(results, function (item) {
        return _.include(mentionValues, item.name);
      });

      if (!results.length) {
        hideAutoComplete();
        return;
      }

      elmAutocompleteList.empty();
      var elmDropDownList = $("<ul>").appendTo(elmAutocompleteList).hide();

      _.each(results, function (item, index) {
        var itemUid = _.uniqueId('mention_');

        autocompleteItemCollection[itemUid] = _.extend({}, item, {value: item.name});

        var elmListItem = $(settings.templates.autocompleteListItem({
          'id'      : utils.htmlEncode(item.id),
          'display' : utils.htmlEncode(item.name),
          'type'    : utils.htmlEncode(item.type),
          'content' : utils.highlightTerm(utils.htmlEncode((item.name)), query)
        })).attr('data-uid', itemUid);

        if (index === 0) {
          selectAutoCompleteItem(elmListItem);
        }

        if (settings.showAvatars) {
          var elmIcon;

          if (item.avatar) {
            elmIcon = $(settings.templates.autocompleteListItemAvatar({ avatar : item.avatar }));
          } else {
            elmIcon = $(settings.templates.autocompleteListItemIcon({ icon : item.icon }));
          }
          elmIcon.prependTo(elmListItem);
        }
        elmListItem = elmListItem.appendTo(elmDropDownList);
      });

      elmAutocompleteList.show();
      elmDropDownList.show();
    }

    function doSearch(query) {
      if (query && query.length && query.length >= settings.minChars) {
        settings.onDataRequest.call(this, 'search', query, function (responseData) {
          populateDropdown(query, responseData);
        });
      } else {
        hideAutoComplete();
      }
    }

    function resetInput() {
      elmInputBox.val('');
      mentionsCollection = [];
      updateValues();
    }

    // Public methods
    return {
      init : function (domTarget) {

        domInput = domTarget;

        initTextarea();
        initAutocomplete();
        initMentionsOverlay();
        resetInput();

        if( settings.prefillMention ) {
          addMention( settings.prefillMention );
        }

      },

      val : function (callback) {
        if (!_.isFunction(callback)) {
          return;
        }

        var value = mentionsCollection.length ? elmInputBox.data('messageText') : getInputBoxValue();
        callback.call(this, value);
      },

      reset : function () {
        resetInput();
      },

      getMentions : function (callback) {
        if (!_.isFunction(callback)) {
          return;
        }

        callback.call(this, mentionsCollection);
      }
    };
  };

  $.fn.mentionsInput = function (method, settings) {

    var outerArguments = arguments;

    if (typeof method === 'object' || !method) {
      settings = method;
    }

    return this.each(function () {
      var instance = $.data(this, 'mentionsInput') || $.data(this, 'mentionsInput', new MentionsInput(settings));

      if (_.isFunction(instance[method])) {
        return instance[method].apply(this, Array.prototype.slice.call(outerArguments, 1));

      } else if (typeof method === 'object' || !method) {
        return instance.init.call(this, this);

      } else {
        $.error('Method ' + method + ' does not exist');
      }

    });
  };

})(jQuery, _);




