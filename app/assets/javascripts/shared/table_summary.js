function addCommas(str) {
    var parts = (str + "").split("."),
        main = parts[0],
        len = main.length,
        output = "",
        i = len - 1;

    while(i >= 0) {
        output = main.charAt(i) + output;
        if ((len - i) % 3 === 0 && i > 0) {
            output = "," + output;
        }
        --i;
    }
    // put decimal part back
    if (parts.length > 1) {
        output += "." + parts[1];
    }
    return output;
}

function table_summary(){
  $('table.sum-table').each(function(index, sumtable){
    var columns_count = parseInt($(sumtable).attr('total_columns'));
    var sum_float_columns = eval('[' + $(sumtable).attr('sum_float_columns') + ']');
    var sum_int_columns = eval('[' + $(sumtable).attr('sum_int_columns') + ']');
    var sum_row = $('<tr class="bg-success" />');
    for(var i=0; i<columns_count; i++){
      if (i==0){
        sum_row.append('<td>合计</td>');
      } else {
        if(sum_float_columns.indexOf(i)>=0){
          var sum = 0;
          $(sumtable).find('tbody td:nth-child('+ (i+1) +')').each(function(index, node){
            sum += Number($(node).text().replace(',', ''));
          });
          sum_row.append('<td class="text-right">'+ addCommas(sum.toFixed(2)) +'</td>');
        } else if(sum_int_columns.indexOf(i)>=0) {
          var sum = 0;
          $(sumtable).find('tbody td:nth-child('+ (i+1) +')').each(function(index, node){
            sum += Number($(node).text().replace(',', ''));
          });
          sum_row.append('<td class="text-right">'+ sum.toFixed(0) +'</td>');
        } else {
          sum_row.append($('<td>'+i+'</td>'));
        }
      }
    }
    $(sumtable).find('tbody').append(sum_row);
  });
}
