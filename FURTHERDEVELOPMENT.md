Ideas for further development:

- in future we should move api token into our own backend so it cannot be stolen from the device - now it's not safe
- generally 95% of CandleStickChart struct is a copy from UIKit app - it would be nice to have some StockAppUI package with shared UIViews and here we would just use the CandleStickChartView from the package to create it's SwiftUI version
- if you are going to do this then maybe think about other common things such as ErrorView or paddings, fonts, colors etc.
