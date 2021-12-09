import UIKit

class ListViewController: UITableViewController {
    
    enum Constants {
        static let NOTIFY_RELOAD = "reload"
        static let SCHOOL_CELL = "SchoolCell"
        static let SEGUE_ID = "showDetail"
        static let BAD_SEGUE_ID = "Unknown segue identifier"
        static let BACK_BUTTON = "Back"
        static let NAV_TITLE = "NYC Schools"
        static let ALERT_TITLE = "Error"
        static let ALERT_MSG = "Could Not Fetch Data"
        static let ALERT_OK = "Ok"
    }
    
    var schoolStoreVM: SchoolStoreVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // subscribe to be informed of when the data from the web has been fecthed or failed
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadList),
                                               name: NSNotification.Name(rawValue: Constants.NOTIFY_RELOAD),
                                               object: nil)
        schoolStoreVM.fetchSchoolsFromWeb()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = Constants.NAV_TITLE
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
        cell.textLabel?.text = item.schoolName

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
    
    private func failureAlert() {
        let alert = UIAlertController(title: Constants.ALERT_TITLE, message: Constants.ALERT_MSG, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ALERT_OK, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func reloadList() {
        if schoolStoreVM.fetchedDataSuccessfully {
            // reload the tableview with the fetched data
            self.tableView.reloadData()
        } else {
            // the web data could not be fetched, put up the failure alert
            // (a nicer UI presentation could be made with alternatives / suggestions)
            self.failureAlert()
        }
    }
}
