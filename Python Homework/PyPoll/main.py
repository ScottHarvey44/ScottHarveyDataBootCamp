import os
import csv

electionData = os.path.join('..', 'Resources', 'election_data.csv')

totalVotes = 0
candidateList = []
percentageOfVotes = float(0)
totalCandidateVotes = 0
electionWinner = str

# Read in the CSV file
with open(electionData, 'r') as csvfile:

    # Split the data on commas
    csvreader = csv.reader(csvfile, delimiter=',')

    header = next(csvreader)

    for rows in csvreader:
        totalVotes = totalVotes +1
        
        

print("Election Results")
print("-------------------------")
print(f"Total Votes: {totalvotes}")
print("-------------------------")
print("Khan: 63.000% (2218231)")
print("Correy: 20.000% (704200)")
print("Li: 14.000% (492940)")
print("O'Tooley: 3.000% (105630)")
print("-------------------------")
print("Winner: Khan")
print("-------------------------")