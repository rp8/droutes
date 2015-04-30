var delay = (function () {
    var timer = 0;
    return function (callback, ms) {
      clearTimeout(timer);
      timer = setTimeout(callback, ms);
    };
  }
)();

$(
  function() {
    // pagination links
    $('#customers th a, #customers .pagination a').live('click', 
      function() {
        $.getScript(this.href);
        return false;
      }
    );

    // search form via submit
    $('#customers_search').submit(
      function() {
        $.get(this.action, $(this).serialize(), null, 'script');
        return false;
      }
    );

    // search form via keypress
    $('#customers_search input').keyup(
      function() {
        delay(function() {
            $.get($('#customers_search').attr('action'), 
            $('#customers_search').serialize(), null, 'script');
            return false;
          }, 300
        );
      }
    );

    // direction
    $('#direction').live('click', function(event) {
        $(this).attr('href', $(this).attr('data-href') + $('#customer_address').val());
        this.click();
      }
    );

    // focus on first textbox
    $(window).load(
      function() {
        $(':input:visible:enabled:first').focus();
      }
    );

    // popup new
    $('a[data-popup]').live('click', function(e) { 
      window.open($(this)[0].href); 
        e.preventDefault(); 
    }); 
  }
);
