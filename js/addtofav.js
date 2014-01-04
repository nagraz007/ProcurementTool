    function addToFav() { 
		if(window.sidebar){
			window.sidebar.addPanel(document.title, this.location,"");
		}
		else{
        	window.external.AddFavorite(this.location,document.title);
		}
    }        
 /*   if(window.external) {
        document.write('<a href="javascript:addToFav()">Bookmark Us</a>'); 
	}
    else {
        document.write('<div>Bookmark (Ctrl+D)</div>');
	}*/
