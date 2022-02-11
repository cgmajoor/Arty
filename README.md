# Arty
## About the project
Art browser iOS application for Rijksmuseum

## How to download & run
* Download the project from Github and open the Arty.xcworkspace in Xcode.
* You can get an API_KEY from [Rijksstudio](https://www.rijksmuseum.nl/en/rijksstudio). More detail about the API you can find on [RijksData](https://data.rijksmuseum.nl/object-metadata/api/)
* Run the application on a simulator or device with minimum version iOS 15.0

## Tasks
- [x] Setup Project
- [x] Architecture used
- [ ] Handle failures
- [x] Setup git
- [x] Use Dutch Rijksmuseum API
- [x] Add a welcome page
- [x] Add an overview page with a list of artwork
- [x] Overview page is paginated
- [x] List in overview page has sections
- [x] List in overview page has headers
- [x] Items should have text and image
- [ ] Add a art detail page with detail about selected artwork
- [x] Add routing
- [x] Load and convert JSON to objects asynchronously
- [x] Show a loading icon or animation
- [ ] Automated tests
- [x] No SwiftUI, no reactive, no storyboards
- [x] Pods

## My approach
I first gathering requirements and observing the Rijsmuseum API, I described the application with a narrative, in user stories. Here I could see that as a user I would like to browse a Library showing ArtCards of Artworks. When I tap on an ArtCard it will navigate to a detail screen which will show more detail about that Artwork. I took these nouns I used in my narrative as my models in business logic. For user experience on how to browse this library: I came up with a design that looks like AppStore. As someone who likes to learn drawing or painting I would like to be able to browse them separately to get some inspiration. For this, I wanted to use the [UICollectionView with compositional layout](https://developer.apple.com/documentation/uikit/uicollectionviewcompositionallayout) with ArtTypes (such as painting, drawing, sculpture, print, photography) in the Rijksmuseum API as sections. I divided it into smaller tasks separating this big task into smaller tasks to work on. After creating the application and git repository for the project, I added a separate framework for Data layer. I created the initial view controllers to interface with my actions. I first focused on getting the data. I used Moya library to connect to API endpoint and Resolver for dependency injection. Added some routing and navigation between the screens. Then I tested repository and getting data. I also adeded a pagination which I tested with a button first. There is still things to be done. Such as error handling, loading images asynchronously. I think of using [SDWebImage Swift Package](https://github.com/SDWebImage/SDWebImage) for this.

## Pitfalls
- For the sake of easiness, I used an MVVM architecture with ViewController taking care of the presentation while ViewModel is taking care of the business logic, getting data from Data layer and providing the ViewController with data to show. This has consequences such as the business logic is not isolated and decoupled. The entities in Domain layer are dependent on the models in Data layer. We could solve these coupling by implementing Clean Architecture where Domain layer is not depending on any layer. And App, Presentation and Data layers that depend on it. And connect them using dependency injection and inversion of control via making them conform to protocols and passing them the concrete implementation that conforms to the expected protocol. This way we can test our app better.
- I like using Generics but some components might become too abstract and hard to understand.
- Using extensions on existing types are powerful, but means any object that subclasses those extended types will inherit those features even if they don't need it.

## Future ToDo
- [ ] Create a development scheme that will run on mock data.
- [ ] Extract environment variables and secrets. Keeping these as literals in the app is dangerous, as it needs manual attention to remove them before a commit on repository.
- [ ] Separate literals because they are prone to fail by misspelling. Replace them with enumarations. [R.swift](https://github.com/mac-cain13/R.swift) can be used for this.
- [ ] Add changing parts as plug-ins. This can help suit testing for our needs.
- [ ] We could separate the business layer from presentation layer to make components decoupled from each other for better testability.
- [ ] As the application grows we could see what parts are being duplicated, we could either create some base classes and inherit from them to avoid code duplication or we could isolate some capabilities as protocols to make it more granular.
- [ ] We should check layout for iPad, small and larger device sizes.
- [ ] It would be nice it target iOS version is at least 2 versions lower than the latest iOS version available.
- [ ] 
## Helper Tools
- .gitignore from [github/gitignore](https://github.com/github/gitignore/blob/main/Swift.gitignore)
- .swiftlint.yml from [SwiftLint](https://github.com/realm/SwiftLint)
- To check API [Postman](http://postman.com/)
- JSON [JsonFormatter](https://jsonformatter.org/json-pretty-print)
- JSON [QuickType](https://app.quicktype.io)
