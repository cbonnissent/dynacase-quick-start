$(document).on("ready", function() {

    $("body").prepend( 
	$("<a/>")
	    .addClass("help-access")
	    .html("J'ai besoin d'aide ?")
	    .attr("href","http://forum.dynacase.org/viewforum.php?id=23")
	    .attr("target", "_blank")
	    .append( 
		$("<div/>")
		    .html("J'utilise le forum")
	    )
    );


});
