# README #
Hi there! This app is a sample of use for http://openweathermap.org/ API. You can pull to refresh to try random cities. Please notice the architecture used for this project was MVVM, which IMHO makes everything cleaner and also easier to implement unit test.

This project uses external AFNetworking library to handle connections, plus Mantle to parse JSON nicely, managed by Cocoapods. 
On your terminal:

$ sudo gem install cocoapods

$ pod install

And then open the .xcworkspace! =]

### Things to do ###

* Add unit tests, using Expecta to test Mantle
* Grab user location dynamically
* Improve UI, showing more details for each forecast - maybe in a master->detail scheme?
* Save data offline - it could give a boost when the user reopen the app. I'd go for Realm, as it's very simple to implement.