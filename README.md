# Banjo Square App

iOS app using foursquare API to show most relevants venues around user location.

The solution consists on a framework (private cocoapods) that has 2 features:

*Dashboard*:  It's a map with a list of venues, has a refresh button and settings for update the radius for the search. It needs the user location.

*Venue Detail*: It's the view for the venue. Basic information.

The architecture of each feature was made with MVP. I used my own xcode-template : 
- https://github.com/polar133/mvp-xcode-template

It's threat safe and is based on POP (protocol oriented programming)

Contains unit test for the model/service layer for both features with above 80% of coverage for each file.

P.D: The name Banjo it's because it's the new character available in Smash Bros Ultimate 🤓