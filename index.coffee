command: "python ./earthscope.widget/earthscope.py"

refreshFrequency: (1000 * 10)

style: """
  top: 0%
  left: 0%
  color: #fff

  .earthview
    height: 100%
    width: 100%
    position: absolute
    z-index:-1

  .annotation
    font-family: SFNS Display, Helvetica Neue, Helvetica, Arial, sans-serif
    text-shadow: 2px 2px rgba(0,0,0,0.1);
    position: fixed
    right:  50px
    bottom: 50px
    a:link {color: #ffffff}
    a:visited {color: #ffffff}
    a:hover {color: #ffffff}
    a:active {color: #dddddd}

  .region
    font-weight: Bold

  .country
    font-weight: Thin, UltraLight, Light

"""
render: -> """
    <head><link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.4.0/css/font-awesome.min.css"></head>
    <div class='earthview'>
    <img id='image' src='', width=1920, height=1400>
    </div>
    <div class='annotation'>
    <text class="region" id="region"></text> <text class="country" id = "country"></text> <a class='globe' href='' id="url"><i class="fa fa-globe"></i></a>
    </div>
"""

update: (output, domEl) ->

  $dom = $(domEl)

  $info = JSON.parse(output)

  $dom.find('#country').html  $info.country
  $dom.find('#region').html  $info.region
  $dom.find('#image').attr("src", $info.image_path)
  $dom.find('#url').attr("href", 'https://earthview.withgoogle.com' + $info.url)
