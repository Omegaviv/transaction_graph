# card_transactions

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Approach

What exactly we need to do?

=> From today to a year back, we have to display transactions done in every day of every day. 

Data Structure to be used

=> I can have a list of transaction object, containting the time of transaction, id, and amount spend.
while building widgets for each day showing transaction I can pass a list of transactions objects of that day in widgets to view details per day on click.


Dealing with UI

=> for UI, I can use simple approach to put the first week  to last week of whole year, inside row(List(columns)) pattern.

I will have to make sure that there are empty widgets or spaces in the start of first week and end of last week as per required. 


Building Week lable UI

I can provided 4 options as configure parameter of with main widget, to display none of the labels, to display all labels and even or odd indexed day.

Building Month Label UI

I can display all the month, starting from the month of starte date object to all values in list.


For displaying color and each day transaction spent, we can have a map<DateTime, List<Transaction>> object which will store transaction of each day. 

