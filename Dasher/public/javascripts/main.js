// widget card toggle handler //
$(function(){
    $(".flipBox").flip({
        trigger: 'click'
    });
});



function insertCal(){
    $('.front.widget7').html('<div class="calendarWidget"></div>');
    $('.calendarWidget').jqxCalendar({theme: "arctic", width:250, height:250});
}

//add clock in widget1 location
function insertClock(){
    $('.front.widget1').html('<div class="clockWidget"></div>');
    // FlipClock initialization  
    var ServerTime = $('#my_time').val();
    var d = new Date();
    var n = d.getHours();
    var diff = ServerTime - n;
    $('.clockWidget').FlipClock(diff,{  
        clockFace: 'TwentyFourHourClock',
        showSeconds: false  
    });  
}

//add weather in widget3 location
function insertWeather(city, units){
    $('.front.widget3').html('<div class="weatherWidget"></div>')
    $(document).ready(function() {
        getWeather(); //Get the initial weather.
        setInterval(getWeather, 600000); //refresh every 10 minutes 
    });
        function getWeather(){
            $.simpleWeather({
                location: city,
                woeid: '',
                unit: units,
                success: function(weather) {
                var html = '<h2><i class="icon-'+weather.code+'"></i> '+weather.temp+'&deg;'+weather.units.temp+'</h2>';
                html += '<div>'+weather.city+', '+weather.region+'</div>';
                html += '<div class="currently">'+weather.currently+'</div>';
                html += '<div>'+weather.wind.direction+'. '+weather.wind.speed+' '+weather.units.speed+'</div>';
                $('.weatherWidget').html(html)
          },
            error: function(error) {
                $('.weatherWidget').html(error)
            }
        });
    }
}

//add date in widget2 location
function insertDate(){
    $('.front.widget2').html('<div class="dateWidget"></div>');
    var d = new Date();
    var dayOfWeek = d.getDay();
    var dayOfMonth = d.getDate();
    var month = d.getMonth();
    var dayNames = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    var monthNames = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 
    'August', 'September', 'October', 'November', 'December'];
    var year = d.getFullYear();
    $('.dateWidget').html(
        '<div class="DOW">'+ dayNames[dayOfWeek] + '</div>'+
        '<div class "DateString">'+ monthNames[month] + ' ' + dayOfMonth + ' '+ year +'</div>');
}

// add greeting to widget4 location
function insertGreeting(name) {
    $('.front.widget4').html('<div class="greetingWidget"></div>');
    
    var d = new Date();
    var hours = d.getHours();
    if (hours < 12) {
        $('.greetingWidget').html('Good morning, ' + name);
    }
    else if(hours < 17){
        $('.greetingWidget').html('Good afternoon, ' + name);
    }  
    else if(hours < 22){
        $('.greetingWidget').html('Good evening, ' + name);
    }  
    else {
        $('.greetingWidget').html('Good night, ' + name);
    }
}



function insertNews() {
    $('.front.widget5').html('<div class="newsWidget"></div>');
    var html = [];
    console.log(html.length < 1);
        function getNews(){
            $.get('http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml', function (data) {
                // console.log(data);
                $(data).find("channel>item:lt(5)").each(function () { // or "item" or whatever suits your feed
                    var el = $(this);
                    console.log("title      : " + el.find("title").text());
                    html.push('</br>' +   '<a target="_blank" href="' + el.find("link").text() + '">' +el.find("title").text() + '</a>');
                    $('.newsWidget').html(html[0])
                });
            });
            console.log(html);  
        }
        getNews();
        setInterval(getNews, 600000);
        var i = 0;
        setInterval(()=>{
            if(i < html.length){
                $('.newsWidget').html(html[i += 1])
            }else{
                i = 0;
                $('.newsWidget').html(html[0])
            }
        }, 10000); 
}

function insertForecast(city, units) {
    $('.front.widget6').html('<div class="forecastWidget"></div>');
    $(document).ready(function() {
        getWeather(); //Get the initial weather.
        setInterval(getWeather, 600000);  
    });
    function getWeather(){
        $.simpleWeather({
        location: city,
              woeid: '',
              unit: units,
              success: function(weather) {
                var html = '';    
                for(var i=0;i<weather.forecast.length;i++) {
                  html += '<p>'+weather.forecast[i].day+': '+weather.forecast[i].high+'</p>';
                  html +='<h2><i class="icon-'+weather.forecast[i].code+'"></i></h2>'
                }
                $('.forecastWidget').html(html)
              },
              error: function(error) {
                $('.forecastWidget').html(error)
              }
        });
    }
}




    



//on document load
insertClock();
insertWeather('Atlanta, GA', 'f');
insertDate();
insertGreeting('Jennifer');
insertForecast('Atlanta, GA', 'f');
insertNews();
insertCal();

//on widget selection
function clock(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget1');
    insertClock();
}

function weather(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget3');
    insertWeather('Atlanta, GA', 'f'); 
}

function date(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget2');
    insertDate();
}

function greeting(elt,name) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget4');
    insertGreeting(name);
}

function news(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget5');
    insertNews();
}

function forecast(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget6');
    insertForecast('Atlanta, GA', 'f');
}

function calendar(elt) {
    var $front = $(elt).parent().prev();
    $front.removeClass(); //removes class
    $front.addClass('front widget7');
    insertCal();  
}