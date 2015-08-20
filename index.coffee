command: "python ./earthscope.widget/earthscope.py"

refreshFrequency: (1000 * 10)

style: """

  .earthview
    height: 100%
    width: 100%
    position: absolute
    z-index:0

  .flink
    font-size: 10pt
    a:link {color: #ffffff}
    a:visited {color: #d53e4f}
    a:hover {color: #d53e4f}
    a:active {color: #d53e4f}

  .wlink
    font-size: 10pt
    a:link {color: #ffffff}
    a:visited {color: #3288bd}
    a:hover {color: #3288bd}
    a:active {color: #3288bd}

  .dlink
    font-size: 10pt
    a:link {color: #ffffff}
    a:visited {color: #99d594}
    a:hover {color: #99d594}
    a:active {color: #99d594}

  .annotation
    color: white
    font-family: SFNS Display, Helvetica Neue, Helvetica, Arial, sans-serif
    text-shadow: 2px 2px rgba(0,0,0,0.1);
    position: fixed;
    right:  50px;
    bottom: 50px;

  .popup
    background-color: rgba(255,255,255,0.5)
    box-shadow: 2px 2px rgba(0,0,0,0.1);
    line-height: 160%
    text-align: center
    border-radius: 5px;
    box-sizing: border-box
    position: fixed
    padding: 5px
    right: 44px
    bottom: 68px
    display: none
    z-index: 1

  .small
    font-size: 10pt

  .share
    -webkit-transition-duration: .5s;
    -moz-transition-duration: .5s;
    -o-transition-duration: .5s;
    transition-duration: .5s;

  .region
    font-weight: Bold

  .country
    font-weight: Thin, UltraLight, Light

"""
render: -> """
    <head><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"></head>
    <div class='earthview'>
    <img id='image' src='image.jpg', width=1920, height=1440>
    </div>
    <div id='popup' class='popup annotation'>
      <span class='flink'><a href="javascript:;" title='Mark as Favorite'  id="fv"><i class="fa fa-heart">   </i></a></span><br>
      <span class='wlink'><a href="javascript:;" title='View on web'       id="ev"><i class="fa fa-globe">   </i></a></span><br>
      <span class='dlink'><a href="javascript:;" title='Copy to Downloads' id="dl"><i class="fa fa-download"></i></a></span><br>
    </div>
    <div class='annotation'>
    <text class="region" id="region"></text>
    <text class="country" id = "country"></text>
    <i class="small share fa fa-share-alt"></i>
    </div>
"""

update: (output, domEl) ->

  $dom = $(domEl)

  $info = JSON.parse(output)

  $dom.find('#country').html  $info.country
  $dom.find('#region').html  $info.region
  $dom.find('#image').attr("src", $info.image_path)
  $dom.find('#ev').attr("href", 'https://earthview.withgoogle.com' + $info.url)

  # remove old click events
  $dom.find('#fv').unbind('click');
  $dom.find('#dl').unbind('click');
  # copy to favorites / Downloads
  $dom.find('#fv').click => @run "cp earthscope.widget/image.jpg earthscope.widget/favorites/" + $info.url + '.jpg'
  $dom.find('#dl').click => @run "cp earthscope.widget/image.jpg ~/Downloads/" + $info.url + '.jpg'

  $dom.find('.share').hover ->
      $('.popup').css({'display': 'block'})
      $('.share').css({'-webkit-transform': 'rotate(90deg)'})
      $('.share').css({'-moz-transform': 'rotate(90deg)'})

  $dom.find('.earthview').hover ->
      $('.popup').css({'display': 'none'})
      $('.share').css({'-webkit-transform': 'rotate(0deg)'})
      $('.share').css({'-moz-transform': 'rotate(0deg)'})

  $dom.find('.popup').click ->
      $('.popup').css({'display': 'none'})
      $('.share').css({'-webkit-transform': 'rotate(0deg)'})
      $('.share').css({'-moz-transform': 'rotate(0deg)'})
      $('.share').css({'-o-transform': 'rotate(0deg)'})
