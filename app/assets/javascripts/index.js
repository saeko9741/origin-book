// function hide(n){
// var tbl=document.getElementById("tbl1");
// // <td id="tbl1">単語の意味(1行目)</td>
// var trs=tbl.getElementsByTagName("tr");
// // HTMLCollection(9) [tr, tr, tr, tr, tr, tr, tr, tr, tr]
// for(var i=0; i<trs.length; ++i){
// var tds=trs[i].getElementsByTagName("td");
// tds[n].style.display = "none";
// }
// }

// 表示・非表示各ボタン
// function hyouji(num)
// {
//   if (num == 0)
//   {
//     document.getElementById("visi").style.visibility="visible";
//   }
//   else
//   {
//     document.getElementById("visi").style.visibility="hidden";
//   }
// }

// 表示・非表示ボタン(1つ)
function changeVisible(){
  var str = document.getElementById("target");
  if(str.style.visibility == "visible"){
    str.style.visibility = "hidden";
  }else{
    str.style.visibility = "visible";
  }
}