# StockApp

## Project overview

The goal of this app is to provide a way for a user to manage watchlists of quotes. 

There are 5 screens: 

- Watchlists Screen - first screen presenting a collection of all the watchlists added by user

- Watchlist Screen - can be accessed by tapping on one of the watchlists on Watchlists Screen - it presents a collection of all the symbols related to the selected watchlist and their quotes

- Quote Screen - can be accessend by tapping on one of the symbols on Watchlist Screen - it presents chart data for last 30 days as well as quote related to the selected symbol

- Add New Watchlist Screen - can be accessed by tapping on + button on Watchlists Screen - it allows to add new watchlist

- Add New Symbol Screen - can be accessed by tapping on + button on Watchlist Screen - it allows to browse through available stock symbols and add one of them 

Pattern used is MVVM with Coordinator. Combine and async / await are in use too. There are also unit tests, darkmode and orientation changes support as well as support for different screen sizes (iPhone / iPad). UI is created with SwiftUI. Charts are created using DGCharts package. Whole logic of the app is moved into the StockAppLogic package which has 2 libraries: StockAppLogic (for UIKit and containing general logic) and StockAppLogicSwiftUI (which contains wrappers for SwiftUI).   

## H2 Installation 

- You need to get an api key from IEX Cloud API (https://iexcloud.io/ -> Start a Free Trial - you don’t need to enter any credit card information) and create environment variable with the api key

- To create environment variable click on Edit Scheme / go to Run tab / under arguments tab in environment variables section add new value with name 'API_TOKEN' and value equal to the api key obtained from IEX Cloud API (use publishable key)

- After these steps you should be set up to run the project
