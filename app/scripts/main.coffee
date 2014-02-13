$audio = document.getElementsByTagName("audio")[0]

timer = (hour, minute) ->

  nowDate = new Date()
  achiveDate = new Date()
  achiveDate.setHours hour, minute, 0
  achiveDate.setDate achiveDate.getDate() + 1000  if achiveDate.getHours() < nowDate.getHours()
  result = (achiveDate - nowDate)
  minutes = Math.floor((result / 1000 / 60) % 60)
  hours = Math.floor((result / 1000 / 60 / 60) % 24)
  
  if result < 1
    $audio.play()
    $(".alarm-time").hide()
    $(".alarm-wakeup").fadeIn "fast"
    return `undefined`
    
  minutes = "0" + minutes  if minutes < 10
  hours = "0" + hours  if hours < 10
  alarmTimeout = setTimeout(->
    timer hour, minute
  , 1000)
  
  $("#disable").click ->
    clearTimeout alarmTimeout
    $audio.pause()
    $("#alarm").hide()
    $("#settime").fadeIn "fast"
    $("#time").val " "
    $("#time").focus()

$("#time").keyup ->
  if $(this).val().length is 5
    document.getElementById("timer").innerHTML = $("#time").val()
    $("#settime").hide()
    $("#alarm").fadeIn "fast"
    time = $("#time").val().split(":")
    timer time[0], time[1]
  return