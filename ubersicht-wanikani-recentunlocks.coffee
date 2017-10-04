options =
  api_key: ""
  spawn_x: "right"
  spawn_y: "bottom"
  spawn_offset_x: 0
  spawn_offset_y: 50
  recent_unlock_amt: 8

refreshFrequency: 900

command: "curl --silent https://www.wanikani.com/api/user/#{options.api_key}/recent-unlocks/#{options.recent_unlock_amt}"

render: (output) -> """

<span>Recent Unlocks</span>

<ul>
  <li><label id="item-1">-</label></li>
  <li><label id="item-2">-</label></li>
  <li><label id="item-3">-</label></li>
  <li><label id="item-4">-</label></li>
  <li><label id="item-5">-</label></li>
</ul>

"""

style: """

position: absolute;
#{options.spawn_x}: #{options.spawn_offset_x}px;
#{options.spawn_y}: #{options.spawn_offset_y}px;
margin: 1rem;

color: #FFFFFF;
font-family: 'Roboto', sans-serif;

span
  font-weight: bold;

ul
  display: flex;
  flex-direction: column;
  list-style: none;

  margin: 0;
  padding: 0;

  li
    font-size: 24pt;

"""

update: (output, domEl) ->
  try
    data = JSON.parse(output)
  catch e
    return 0

  ui = data.user_information
  ri = data.requested_information

  menu = (i, dish) -> "Menu Item #{i}: #{dish}" 
  menu i + 1, $(domEl).find('#item-' + i.toString()).text(character.character) for character, i in ri

afterRender: (widget) ->
  $.ajax({
    url: "https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js",
    cache: true,
    dataType: "script",
    success: ->
      $(widget).draggable()
      return
  })