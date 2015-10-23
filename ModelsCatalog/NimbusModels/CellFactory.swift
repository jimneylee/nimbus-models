import UIKit

public struct AnyEntityBackedCell<Entity, Cell: UIView> {
  static public func configure(entity: Entity, cell: Cell) {
    print("Fallback")
  }
}

public protocol CellRecyclerType {
  typealias Cell: UIView

  func dequeueCell(withIdentifier identifier: String, forIndexPath indexPath: NSIndexPath) -> Cell
}

public protocol CellFactoryType {
  typealias Entity
  typealias CellRecycler: CellRecyclerType

  /// Creates a new cell for the given entity and index path
  func cellForEntity(entity: Entity, indexPath: NSIndexPath, cellRecycler: CellRecycler) -> CellRecycler.Cell
}

extension UITableView : CellRecyclerType {
  public func dequeueCell(withIdentifier identifier: String, forIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return self.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
  }
}

extension UICollectionView : CellRecyclerType {
  public func dequeueCell(withIdentifier identifier: String, forIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return self.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
  }
}

extension CellFactoryType {
  public func cellForEntity(entity: Entity, indexPath: NSIndexPath, cellRecycler: CellRecycler) -> CellRecycler.Cell {
    let cell = cellRecycler.dequeueCell(withIdentifier: String(entity.dynamicType), forIndexPath: indexPath)
    AnyEntityBackedCell<Entity, CellRecycler.Cell>.configure(entity, cell: cell)
    return cell
  }
}

public class AnyCellFactory<EntityType, CellRecyclerT: CellRecyclerType> : CellFactoryType {
  public typealias Entity = EntityType
  public typealias CellRecycler = CellRecyclerT
}
