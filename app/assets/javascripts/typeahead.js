jQuery(document).ready(function(){
	$('.typeahead').typeahead({
	      source: function (query, process) {
						display_field = $(event.target).data("display-field")
	          objects = [];
	          map = {};
						update_id = $(event.target).data("update-id");
	          return $.get($(event.target).data("source"), { query: query }, function (data) {
            
	            $.each(data, function(i, object) {
	                map[object[display_field]] = object;
	                objects.push(object[display_field]);
	            });
	            return process(objects);
	          });
	      },
	      updater: function(item) {
				  $(update_id).val(map[item].id);
	        return item;
	      }  
	})
});