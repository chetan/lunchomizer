function addCodeToFunction(func, code) {
    if (func == undefined)
	    return code;
    else {
	    return function(){
	        func();
	        code();
	    }
    }
}