// from data.js
var tableData = data;

// YOUR CODE HERE!
var tbody = d3.select("tbody");

//create function to display data.js
data.forEach((ufoReport) => {
    var row = tbody.append("tr");
    Object.entries(ufoReport).forEach(([key, value]) => {
      var cell = tbody.append("td");
      cell.text(value);
    });
  });

//filter
  var ufoSightings = data;

  // Select the submit button
  var submit = d3.select("#filter-btn");
  
  submit.on("click", function() {
  
    // Prevent the page from refreshing
    d3.event.preventDefault();
  
    // Select the input element and get the raw HTML node
    var inputElement = d3.select("#datetime");
  
    // Get the value property of the input element
    var inputValue = inputElement.property("value");
  
    var filteredData = ufoSightings.filter(sighting => sighting.datetime === inputValue);

    var emptyrow = d3.selectAll('tbody>tr');
    Object.entries(ufoSightings).forEach(() => {
      var emptycell = d3.selectAll('tbody>td').text('');
    });
  });


  filteredData.forEach((ufoSightings) => {
    var row = tbody.append("tr");
    Object.entries(ufoSightings).forEach(([key, value]) => {
      var cell = tbody.append("td");
      cell.text(value);
    });
  });



