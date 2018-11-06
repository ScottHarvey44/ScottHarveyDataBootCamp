import os
import csv

budgetData = os.path.join('..','Resources','budget_data.csv')

months = 0
totalMoney = 0
averageChange = 0
grtInc = 0
grtDec = 0
i = 0
j = 0

# Read in the CSV fileact
with open(budgetData, 'r') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',')

    header = next(csvreader)

    for rows in csvreader:
        months = months + 1
        totalMoney = totalMoney + int(rows[1])
        if rows == 1:
            i = int(rows[1])
        else:
            j = int(rows[1])
            change = j - ils
            i = j
            averageChange = averageChange + change
        if int(rows[1]) > grtInc:
            grtInc = int(rows[1])
            grtIncMon = rows[0]
        elif int(rows[1]) < grtDec:
            grtDec = int(rows[1])
            grtDecMon = rows[0]

averageChange = averageChange/int(months)
print("Financial Analysis")
print("----------------------------")
print("Total Months: " + months)
print("Total: $ " + totalMoney)
print("Average  Change: $ " + averageChange)
print("Greatest Increase in Profits: " + grtIncMon + grtInc)
print("Greatest Decrease in Profits: " + grtDecMon + grtDec)