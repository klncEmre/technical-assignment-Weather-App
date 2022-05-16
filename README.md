# techincal-assignment-Weather-App


This project written in Swift by Emre Kılınc <br>

You need to have Xcode Installed. 
<br>
Please open weather_app.xcworkspace with Xcode and run the simulator then on xcode Debug -> Simulate Location -> Pick a city. 
<br>
If cities are not available to select you have gps problem because of simulator, just re-run app and try toselect a city 

I have used: <br>
  -UIKIT  <br>
  -ALAMOFIRE <br>
  -COCOAPODS <br>
  -CoreLocation <br>
  
  
If you can not see the cities as listed in mainpage, please go to xcode -> Debug -> Simulate Location -> Pick a city. If cities are not available to select, re-run app and select now. <br>

-- API: https://www.metaweather.com/api/ Gives only next 6days weather data so I could only show them. <br>
-- API : Api gives all locations as city type (actually they write that there are other types but api does not give another type in my tests.) because of this Main Page and Nearby Cities are listed as same most of the times.(but in case of other type locations, I filtered the all locations and listed the only city type locations in Nearby Cities)


