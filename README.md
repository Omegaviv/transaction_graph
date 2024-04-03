# card_transactions

# Approach

What exactly we need to do?

=> From today to a year back, we have to display transactions done of every day. 

Data Structure to be used

=> I can have a list of transaction object, containting the time of transaction, id, and amount spend.
while building widgets for each day showing transaction I can pass a list of transactions objects of that day in widgets, to view details per day with onClick.


Dealing with UI

=> for UI, I can use simple approach to put the first week  to last week of whole year, inside row(List(columns)) pattern.

I will have to make sure that there are empty widgets or spaces in the start of first week and end of last week as per required. 


Building Week lable UI

I can provided 4 options as configure parameter of with main widget, to display none of the labels, to display all labels and even or odd indexed day.

Building Month Label UI

I can display all the month, starting from the month of starte date object to all values in list.


For displaying color and each day transaction spent, we can have a Map<DateTime, List\<Transaction>> object which will store transaction of each day. 


# How to use widget

Use TransactionGraph widget, and pass your data. Here data has to be in form of Map<DateTime,List<Transaction>>>.

Detail of Transaction object is present inside domain folder.

```
TransactionGraph(
    transactionData: yourData,
)
```

Currently in the code base, I have genreated List of Transaction objects then converted it to Map key value pare as per above.


1) Start date and End date

if nothing is passed it will conside end date as today and start date as one year back.

```
TransactionGraph(
    transactionData: yourData,
    startDate: DateTime,
    endDate: DateTime
)
```

2) You can also configure how week label and month labels are displayed

```
TransactionGraph(
    transactionData: yourData,
    weekLableVisiblityType: WeekLableVisiblityType.oddDays,
    monthLabelVisiblityType: MonthLabelVisiblityType.short
)
```

3) a few other thing you con configure is 

    size => size of the box representing each day
    fontSize
    margin => margin of the box representing each day
    baseColor => Color that will be used for muiltple shades of each day
    noTransactionColor => color of the day if no transaction there




# How to run 

I used flutter 3.19.3, you can use other version with suitable sdk versions.

```
flutter pub get
```

```
flutter run -d macos 
```

```
flutter run 
```
