///bin/true; exec js "$0" "$@"

/// See http://gionkunz.github.io/chartist-js/examples.html
//! <link rel="stylesheet" href="chartist.min.css">
//! <script src="chartist.min.js"></script>

//! <h1>Проста діаграма</h1>

var data; //-

data = {
  // A labels array that can contain any sort of values
  labels: ['пн', 'вт', 'ср', 'чт', 'пт'],
  // Our series array that contains series objects or in this case series data arrays
  series: [
    [5, 2, 4, 2, 0],
    [1, 2, null, 2, 3]
  ]
}

///! <div class="ct-chart ct-perfect-fourth"></div>
//! <div class="ct-chart ct-perfect-fourth" style="max-width: 600px"></div>
//! <script>new Chartist.Line('.ct-chart', data, {low:0, showArea:true, axisY: { onlyInteger: true} }); </script>

// Кінець графіка
