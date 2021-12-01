import Foundation

// This is a ViewModel that connects the School model's data to the ListViewController,
// and the DetailViewController. Each of which then alters the View,
// further decoupling itself from the model via dependecy injection.
class SchoolStoreVM {
    enum Constants {
        static let FETCH_TIMEOUT = 15.0
        static let URL_STRING = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        static let FATAL_ERROR_URL = "FATAL ERROR: URL could not be created"
    }
    
    // an array of Schools that will be populated from the web
    var schools = [School]()
    
    // parses the JSON data into an array of School and returns the array,
    // or returns a failure result with the error if unsuccessful
    private func parseJSON(fromData data: Data) -> Result<[School], Error> {
        do {
            let decodedData = try JSONDecoder().decode([School].self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(error)
        }
    }
    
    // checks that JSON data exists and processes it via parsing,
    // or returns a failure result with an error if unsuccessful
    private func processJSONRequest(data: Data?, error: Error?) -> Result<[School], Error> {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return parseJSON(fromData: jsonData)
    }
    
    // fetches the schools from the web, and runs the completion closure with
    // either the successful results of the School array being populated,
    // or returns a failure result with an error if unsuccessful
    func fetchSchools(completion: @escaping (Result<[School], Error>) -> Void) {
        if let url = URL(string: Constants.URL_STRING) {
            let request = URLRequest(url: url)
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = Constants.FETCH_TIMEOUT
            let session = URLSession(configuration: sessionConfig)
            let task = session.dataTask(with: request) {
                (data, response, error) in
                
                let result = self.processJSONRequest(data: data, error: error)
                // dispatch the results onto the main thread to alter the view
                OperationQueue.main.addOperation {
                    completion(result)
                }
            }
            task.resume()
        } else {
            // end the program because continuation without a URL is impossible
            preconditionFailure(Constants.FATAL_ERROR_URL)
        }
    }
}

