$(function() { 
 return $("a[data-background-color]").click(function() { 
 var backgroundColor, textColor; 
 backgroundColor = $(this).data("background-color"); 
 textColor = $(this).data("text-color"); 
 return paintIt(this, backgroundColor, textColor); 
 });