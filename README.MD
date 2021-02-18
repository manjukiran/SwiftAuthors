# SwiftAuthor!

## Background
The repository has the application source code for viewing the commit list to the Swift Github Repository.


## Swift

### Current Application

This is a simple list app that allows users to see a list of Cakes.  
The app is written in Swift and downloads the data and shows the commit list in a simple, smooth scroll. 



#### App Description
 
The app contains two screens which display 
-  list of commits
- detail pages for the commit
    

### Additional Features

- The app contains a placeholder loading screen for when the app first starts and is seeking data
- All image data is cached for easy retrieval
- Theme support for changing the color based on the marketing team's requirements
- The app contains a placeholder loading screen for when no data could be fetched

### Technical Design

The app currently uses a simple MVVM design pattern with the following grouping. MVVM pattern along with dependency injection was chosen to aid in testing whilst ensuring  classes are light weight in nature.  

The app also uses the new build system to aid in XCode 12's ability to load the needed Test runners. 
If the tests fail to run (due to the missing bundle/resources error), please select Legacy Build System for project settings in Xcode.

1) Utilities 

    - 1.a) Networking - These classes are used to fetch data, parse into the required object type and returned. The app will need an SSL certificate from the backend to improve security and stop MITM attacks.The class currently has a placeholder where SSL pinning can be implemented.
    - 1.b) Data Sync - Used by data models to retrieve data using the Networking utilities 
    - 1.c) Cache - A caching utility for images

2) View Models - There is one view model in the project for the list of Commits. The view model is  used by the corresponding view controllers to retrieve / refresh data and provide the necessary filtering.

3) Data Models - The models adhere to the Codable protocol. We can extend these data models to be based on NSManagedObject and conform to Codable protocols. 

4) View Controllers - The two view controllers are used to only display the models and capture user interactions; whilst the view models take care of the filtering 

5) Extensions - The app uses a number of extensions that enhance the ability of basic Apple classes. These extensions help in reducing code whilst ensuring consistency across the app.

6) Localisation - The app currently supports English, French and German but can be extended easily to support other languages
