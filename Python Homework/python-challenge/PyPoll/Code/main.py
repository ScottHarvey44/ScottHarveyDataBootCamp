import os
import csv

electionData = os.path.join('..', 'Resources', 'election_data.csv')

totalVotes = int(0)
candidates = list()
khanVotes = float(0)
correyVotes = float(0)
liVotes = float(0)
otooleyVotes = float(0)
electionWinner = str

with open(electionData, 'r') as csvfile:

    csvreader = csv.reader(csvfile, delimiter=',')

    header = next(csvreader)

    for rows in csvreader:
        totalVotes = totalVotes + 1
        if rows[2] not in candidates:
           candidates.append(rows[2])
        if rows[2] == "Khan":
            khanVotes = khanVotes + 1
        elif rows[2] == "Correy":
            correyVotes = correyVotes + 1
        elif rows[2] == "Li":
            liVotes = liVotes + 1
        elif rows[2] == "O'Tooley":
            otooleyVotes = otooleyVotes + 1

    if max(khanVotes, liVotes, correyVotes, otooleyVotes) == khanVotes:
        electionWinner = "Khan"
    elif max(khanVotes, liVotes, correyVotes, otooleyVotes) == liVotes:
        electionWinner = "Li"
    elif max(khanVotes, liVotes, correyVotes, otooleyVotes) == correyVotes:
        electionWinner = "Correy"
    elif max(khanVotes, liVotes, correyVotes, otooleyVotes) == otooleyVotes:
        electionWinner = "O'Tooley"

khanPCT = round(((khanVotes/totalVotes)*100),3)
correyPCT = round(((correyVotes/totalVotes)*100),3)
liPCT = round(((liVotes/totalVotes)*100),3)
otooleyPCT = round(((otooleyVotes/totalVotes)*100),3)

print("Election Results")
print("-------------------------")
print("Total Votes: " + str(totalVotes))
print("-------------------------")
print('Khan: ' + str(khanPCT) + "% (" + str(int(khanVotes)) + ')')
print('Correy: ' + str(correyPCT) + "% (" + str(int(correyVotes)) + ')')
print('Li: ' + str(liPCT) + "% (" + str(int(liVotes)) + ')')
print("O'Tooley: " + str(otooleyPCT) + "% (" + str(int(otooleyVotes)) + ')')
print("-------------------------")
print("Winner: " + electionWinner)
print("-------------------------")