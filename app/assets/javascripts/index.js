function changeVisible(){
  var tbl = document.getElementsByClassName("target");
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