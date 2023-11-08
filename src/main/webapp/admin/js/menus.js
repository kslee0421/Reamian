let main_btn = document.querySelector("#main_btn");
let info_btn = document.querySelector("#info_btn");
let member_btn = document.querySelector("#member_btn");
let notice_btn = document.querySelector("#notice_btn");
let faq_btn = document.querySelector("#faq_btn");
let reserve_btn = document.querySelector("#reserve_btn");
let admin_member_btn = document.querySelector("#admin_member_btn");

main_btn.addEventListener("click",function(){
	location.href='./admin_main.do';
});
info_btn.addEventListener("click",function(){
	location.href="./info_main.do";
});
member_btn.addEventListener("click",function(){
	location.href="./member_main.do";
});
notice_btn.addEventListener("click",function(){
	location.href="./notice_main.do";
});
faq_btn.addEventListener("click",function(){
	location.href="./faq_main.do";
});
reserve_btn.addEventListener("click",function(){
	location.href="./reserve_main.do";
});
admin_member_btn.addEventListener("click",function(){
	location.href="./config_main.do";
});
/*menu_btn.addEventListener("click",function(e){
     let lis = document.querySelectorAll("#menus>li");
     var menu_node = [].indexOf.call(lis,e.target);
     var go_page="";
     switch(menu_node){
        case 0:
        go_page = "./admin_main.do";
        break;
        case 1:
        go_page = "./info_main.do";
        break;
        case 2:
        go_page = "./member_main.do"; 
        break;
        case 3:
  		go_page = "./notice_main.do"; 
        break;
        case 4:
        go_page = "./faq_main.do";
        break;  
        case 5:
        go_page = "./reserve_main.do";
        break;   
        case 6:
        go_page = "./config_main.do";     
        break;
     }
     location.href=go_page;
});*/