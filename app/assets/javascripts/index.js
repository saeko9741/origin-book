function hiddenWord(){
  var tbl = document.getElementsByClassName("word");
  if(tbl[1].style.visibility == "visible"){
     for(var i=0; i<tbl.length; i++){
         tbl[i].style.visibility = "hidden";
     }
  }else{
     for(var i=0; i<tbl.length; i++){
         tbl[i].style.visibility = "visible";
     }
  }
}

function hiddenMeaning(){
  var tbl = document.getElementsByClassName("meaning");
  if(tbl[1].style.visibility == "visible"){
     for(var i=0; i<tbl.length; i++){
         tbl[i].style.visibility = "hidden";
     }
  }else{
     for(var i=0; i<tbl.length; i++){
         tbl[i].style.visibility = "visible";
     }
  }
}