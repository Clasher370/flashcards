var count=0;

setInterval(timer, 1000);

function timer() {
  count += 1;
  $('#timer').val(count);
}
