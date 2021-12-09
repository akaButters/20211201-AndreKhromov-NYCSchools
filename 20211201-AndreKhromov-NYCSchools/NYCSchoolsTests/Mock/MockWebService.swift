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
        School(dbNumber: "0000",
               schoolName: "Mock School Name 1",
               numberOfTakers: "1",
               averageReadingScore: "800",
               averageWritingScore: "700",
               averageMathScore: "600"),
        School(dbNumber: "0001",
               schoolName: "Mock School Name 2",
               numberOfTakers: "2",
               averageReadingScore: "500",
               averageWritingScore: "400",
               averageMathScore: "300")
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
