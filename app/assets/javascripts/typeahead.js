jQuery(document).ready(function(){
	$('.typeahead').typeahead({
	      source: function (query, process) {
	          objects = [];
	          map = {};
						update_id = $(event.target).data("update-id");
	          return $.get($(event.target).data("source"), { query: query }, function (data) {
            
	            $.each(data, function(i, object) {
	                map[object.name] = object;
	                objects.push(object.name);
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