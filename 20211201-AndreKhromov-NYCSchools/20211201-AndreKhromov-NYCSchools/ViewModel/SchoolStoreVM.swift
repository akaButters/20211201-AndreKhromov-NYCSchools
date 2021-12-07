import Foundation

// This is a ViewModel that connects the School model's data to the ListViewController,
// and the DetailViewController. Each of which then alters the View,
// further decoupling itself from the model via dependecy injection.
class SchoolStoreVM {
    // an empty array of Schools that will be populated from the web
    var schools = [School]()
    
    // an indicator of the success or failure of a fetching the web data
    var fetchedDataSuccessfully = false
    
    // a NetworkService type that will be used to fetch the data from the web
    let webService: NetworkService
    
    init(webService: NetworkService) {
        self.webService = webService
    }
    
    // fetches the school data from the web via the NetworkService, which can be a WebService
    // for a real fetch or a MockWebService if you would like to see mock results outside of
    // a mock unit test
    func fetchSchoolsFromWeb() {
        webService.fetchSchools() { (result) in
            switch result {
            case let .success(schools):
                // sorts the fetched schools in alphabetical order
                self.schools = schools.sorted { $0.school_name < $1.school_name }
                // sets the fetch as a success
                self.fetchedDataSuccessfully = true
                
            default:
                // the failure case
                break
            }
            
            // post that the fetch has completed to notify the tableview list of schools to act
            // appropriately for the success or failure
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: ListViewController.Constants.NOTIFY_RELOAD),
                                            object: nil)
        }
    }
}

