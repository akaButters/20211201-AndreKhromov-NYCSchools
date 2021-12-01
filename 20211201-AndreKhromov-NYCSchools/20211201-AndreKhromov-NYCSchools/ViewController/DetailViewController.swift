import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var mathScoreLabel: UILabel!
    @IBOutlet weak var readingScoreLabel: UILabel!
    @IBOutlet weak var writingScoreLabel: UILabel!
    @IBOutlet weak var numberOfTestTakersLabel: UILabel!
    
    var schoolDetails: School!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        schoolNameLabel.text = schoolDetails.school_name
        mathScoreLabel.text = schoolDetails.sat_math_avg_score
        readingScoreLabel.text = schoolDetails.sat_critical_reading_avg_score
        writingScoreLabel.text = schoolDetails.sat_writing_avg_score
        numberOfTestTakersLabel.text = schoolDetails.num_of_sat_test_takers
    }
}
