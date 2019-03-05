function buildMetadata(sample) {
  
  var url1 = `/metadata/${sample}`
  d3.json(url1).then(function(data) {
   d3.select("#sample-metadata").html("")
    Object.entries(data).forEach(([key, value])=>{
      d3.select("#sample-metadata").append("li").text(`${key}: ${value}`)

    })
   })
}

function buildCharts(sample) {

    var defaultURL = `/samples/${sample}`;
    d3.json(defaultURL).then(function(data) {
    var trace1 = {
        x: data.otu_ids,
        y: data.sample_values,
        text: data.otu_labels,
        mode: 'markers',
        marker: {
          size: data.sample_values,
          color: data.otu_ids
        }
      };
      
      var bubbleData = [trace1];
      var layout = { margin: { t: 30, b: 100 } };
      Plotly.plot("bubble", bubbleData);

      var pieData = [{
        'values': data.sample_values.slice(0,10),
        'labels': data.otu_ids.slice(0,10),
        type: 'pie'
      }];

      Plotly.plot("pie", pieData);

    });
  }
function init() {
  // Grab a reference to the dropdown select element
  var selector = d3.select("#selDataset");

  // Use the list of sample names to populate the select options
  d3.json("/names").then((sampleNames) => {
    sampleNames.forEach((sample) => {
      selector
        .append("option")
        .text(sample)
        .property("value", sample);
    });

    // Use the first sample from the list to build the initial plots
    const firstSample = sampleNames[0];
    buildCharts(firstSample);
    buildMetadata(firstSample);
  });
}

function optionChanged(newSample) {
  // Fetch new data each time a new sample is selected
  buildCharts(newSample);
  buildMetadata(newSample);
}

// Initialize the dashboard
init();
