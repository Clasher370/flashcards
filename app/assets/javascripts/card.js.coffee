$(document).ready ->
  $(".card").on("ajax:success", (e, data, status, xhr) ->
    console.log e
    console.log data
    console.log status
    console.log xhr
  ).on "ajax:error", (e, xhr, status, error) ->
    console.log e
    console.log xhr
    console.log status
    console.log error
