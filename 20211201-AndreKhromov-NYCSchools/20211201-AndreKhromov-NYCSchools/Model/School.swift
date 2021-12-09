import Foundation

struct School: Codable {
    let dbNumber: String
    let schoolName: String
    let numberOfTakers: String
    let averageReadingScore: String
    let averageWritingScore: String
    let averageMathScore: String
    
    enum CodingKeys: String, CodingKey {
        case dbNumber = "dbn"
        case schoolName = "school_name"
        case numberOfTakers = "num_of_sat_test_takers"
        case averageReadingScore = "sat_critical_reading_avg_score"
        case averageWritingScore = "sat_writing_avg_score"
        case averageMathScore = "sat_math_avg_score"
    }
}


