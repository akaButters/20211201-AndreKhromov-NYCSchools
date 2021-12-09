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
        
        schoolNameLabel.text = schoolDetails.schoolName
        mathScoreLabel.text = schoolDetails.averageMathScore
        readingScoreLabel.text = schoolDetails.averageReadingScore
        writingScoreLabel.text = schoolDetails.averageWritingScore
        numberOfTestTakersLabel.text = schoolDetails.numberOfTakers
    }
}
