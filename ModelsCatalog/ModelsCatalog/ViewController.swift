import UIKit
import NimbusModels

class TitleCell: UITableViewCell, TableCell {
    
    //MARK: - TableCell Protocol
    func updateCellWithObject(object: TableCellObject) {
        if object is TitleEntity {
            let cellObject = object as! TitleEntity
            self.textLabel?.text = cellObject.title
        }
    }
}

class TitleEntity: TableCellObject {
  var title: String

  init(_ title: String) {
    self.title = title
  }
    
    //MARK: - TableCellObject Protocol
    func tableCellClass() -> UITableViewCell.Type {
        return TitleCell.self
    }
}

class ViewController: UITableViewController {
  let model: TableModel<TitleEntity> = [[TitleEntity("Bob")]]

  override func viewDidLoad() {
    super.viewDidLoad()

    self.tableView.registerClass(TitleCell.self, forCellReuseIdentifier: String(TitleEntity))
    self.tableView.dataSource = self.model
  }
}
