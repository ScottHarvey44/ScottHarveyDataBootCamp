d3.csv("aac_shelter_outcomes_eng.csv", function(error, shelterData){

  // Throw an error if one occurs
  if (error) throw error;

  // Print the sheltersData
  console.log(shelterData);
  });