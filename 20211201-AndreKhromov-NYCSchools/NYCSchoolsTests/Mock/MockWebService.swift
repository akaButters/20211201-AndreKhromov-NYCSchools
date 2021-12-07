import Foundation

// a Mock web service to mock unit test the fetching of Schools
class MockWebService: NetworkService {
    // a mock error result to pass back
    enum MockError: Error {
        case error
    }
    
    // a fake URL, setting it to an empty string will force a mock failure
    private let urlString: String
    
    // initialized with a successful mock string url
    init(urlString: String = "Mock URL") {
        self.urlString = urlString
    }
    
    // mock school results for a successful mock
    private var mockSchools = [
        School(dbn: "0000", school_name: "Mock School Name 1", num_of_sat_test_takers: "1", sat_critical_reading_avg_score: "800", sat_math_avg_score: "700", sat_writing_avg_score: "600"),
        School(dbn: "0001", school_name: "Mock School Name 2", num_of_sat_test_takers: "2", sat_critical_reading_avg_score: "500", sat_math_avg_score: "400", sat_writing_avg_score: "300")
    ]
    
    // the main point of this mock web service
    // is a successful invocation of the completion if the urlString is not empty,
    // otherwise a failure invocation
    func fetchSchools(completion: @escaping (Result<[School], Error>) -> Void) {
        if !urlString.isEmpty {
            completion(.success(mockSchools))
        } else {
            completion(.failure(MockError.error))
        }
    }
}
