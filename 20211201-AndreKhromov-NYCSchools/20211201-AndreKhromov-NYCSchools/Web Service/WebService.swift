import Foundation

protocol NetworkService {
    func fetchSchools(completion: @escaping (Result<[School], Error>) -> Void)
}

class WebService: NetworkService {
    enum Constants {
        static let FETCH_TIMEOUT = 15.0
        static let URL_STRING = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
        static let FATAL_ERROR_URL = "FATAL ERROR: URL could not be created"
    }
    
    // the url to fetch from, shouldn't be changed but can be changed if you
    // want to see or test the Failure Alert on the ListViewController view.
    private let urlString: String
    
    // initialized with the preset NYC school url
    // can be changed if you want to see or test the Failure Alert on the ListViewController view.
    init(urlString: String = Constants.URL_STRING) {
        self.urlString = urlString
    }
    
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
        if let url = URL(string: self.urlString) {
            let request = URLRequest(url: url)
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = Constants.FETCH_TIMEOUT
            let session = URLSession(configuration: sessionConfig)
            session.dataTask(with: request) {
                (data, response, error) in
                
                let result = self.processJSONRequest(data: data, error: error)
                // dispatch the results onto the main thread to alter the view
                DispatchQueue.main.async {
                    completion(result)
                }
            }.resume()
        } else {
            // end the program because continuation without a URL is impossible
            preconditionFailure(Constants.FATAL_ERROR_URL)
        }
    }
}
