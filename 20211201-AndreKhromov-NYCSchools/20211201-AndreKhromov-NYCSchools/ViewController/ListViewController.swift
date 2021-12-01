import UIKit

class ListViewController: UITableViewController {
    
    enum Constants {
        static let SCHOOL_CELL = "SchoolCell"
        static let SEGUE_ID = "showDetail"
        static let BAD_SEGUE_ID = "Unknown segue identifier"
        static let BACK_BUTTON = "Back"
        static let NAV_TITLE = "NYC Schools"
        static let ALERT_TITLE = "Error"
        static let ALERT_MSG = "Could Not Fetch Data"
        static let ALERT_OK = "Ok"
    }
    
    var schoolStoreVM = SchoolStoreVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.NAV_TITLE

        // fetch the JSON data for the schools using the SchoolStore ViewModel
        schoolStoreVM.fetchSchools {
            (schoolsResult) in
            
            // on success, set the tableview with the new list of schools
            switch schoolsResult {
            case let .success(schools):
                self.schoolStoreVM.schools = schools
                self.tableView.reloadData()

            // the JSON data could not be fetched, put up the error alert
            // (a nicer UI presentation could be made with alternatives / suggestions)
            case .failure(_):
                self.failureAlert()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return schoolStoreVM.schools.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.SCHOOL_CELL, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.caption1)
        let item = schoolStoreVM.schools[indexPath.row]
        cell.textLabel?.text = item.school_name

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.SEGUE_ID:
            if let row = tableView.indexPathForSelectedRow?.row {
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.schoolDetails = schoolStoreVM.schools[row]
                navigationItem.title = Constants.BACK_BUTTON
            }
        default:
            preconditionFailure(Constants.BAD_SEGUE_ID)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = Constants.NAV_TITLE
    }
    
    private func failureAlert() {
        let alert = UIAlertController(title: Constants.ALERT_TITLE, message: Constants.ALERT_MSG, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ALERT_OK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
