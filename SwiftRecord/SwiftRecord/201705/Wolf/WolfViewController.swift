//
//  WolfViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2017/5/10.
//  Copyright © 2017年 wang. All rights reserved.
//

import UIKit

class WolfViewController: UIViewController {
    
    let VISIT_PATH:NSString      = "visit_path"
    let RECORD_STATUS:NSString   = "record_status"
    
    enum ProcessHereToThere: Int {
        case FarmerFromHereToThere = 0
        case FarmerWithWolfFromHereToThere
        case FarmerWithSheepFromHereToThere
        case FarmerWithVegetableFromHereToThere
    }
    
    enum ProcessTHereToHere: Int {
        case FarmerFromThereToHere = 0
        case FarmerWithWolfFromThereToHere
        case FarmerWithSheepFromThereToHere
        case FarmerWithVegetableFromThereToHere
    }
    
    enum SortWhole: Int {
        case FarmerSort = 0
        case WolfSort
        case SheepSort
        case VegetableSort
    }
    
    private var sortArray:NSMutableArray = NSMutableArray.init(capacity: 5);
    private var hereToThereArr = [ProcessHereToThere.FarmerFromHereToThere,
                                  ProcessHereToThere.FarmerWithWolfFromHereToThere,
                                  ProcessHereToThere.FarmerWithSheepFromHereToThere,
                                  ProcessHereToThere.FarmerWithVegetableFromHereToThere]
    private var thereToHereArr = [ProcessTHereToHere.FarmerFromThereToHere,
                                  ProcessTHereToHere.FarmerWithWolfFromThereToHere,
                                  ProcessTHereToHere.FarmerWithSheepFromThereToHere,
                                  ProcessTHereToHere.FarmerWithVegetableFromThereToHere]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var startBtn: UIButton!
    
    @IBAction func onClickStartBtn(_ sender: Any)
    {
        start(sort: 0);
    }
    
    
    private func start(sort:Int)
    {
        var index = sort
        
//        printResult(index: index)
        
        if isFinished(index:index) {
            printResult(index: index);
            
            return;
        }
        
        let farmer:Farmer = fetchFarmer(index: index)
        
        
        switch farmer.sitStatus {
        case .HERE:
            let preDic:NSMutableDictionary? = fetchDic(index: sort)
            
            for i in 0..<hereToThereArr.count
            {
                let process:ProcessHereToThere = hereToThereArr[i]
                let prePreocess:ProcessTHereToHere = thereToHereArr[i]
                
                if isValid(process: process, item: preDic!)
                {
                    let dic:NSMutableDictionary?
                    if index >= sortArray.count {
                        dic = NSMutableDictionary.init(dictionary: preDic!)
                        
                        sortArray.add(dic as Any)
                    } else {
                        dic = fetchDic(index: index)
                    }
                    var arr:NSMutableArray? = dic?.object(forKey: VISIT_PATH) as? NSMutableArray
                    
                    if (arr != nil
                        && 0 < (arr?.count)!)
                    {
                        if (arr?.lastObject is ProcessHereToThere)
                        {
                            continue;
                        }
                        
                        let tempProcess = arr?.lastObject as! ProcessTHereToHere
                        
                        if tempProcess == prePreocess
                        {
                            continue;
                        }
                    } else {
                        arr = NSMutableArray.init();
                    }
                    
                    arr?.add(process)
                    operation(process: process, index:index)
                    
                    dic?.setValue(arr, forKey: VISIT_PATH as String)
                    sortArray.replaceObject(at: index, with: dic as Any)
                    
                    start(sort: index)
                    
                    index += 1
                }
            }
            
            break
            
        case .THERE:
            let preDic:NSMutableDictionary? = fetchDic(index: sort)
            
            for i in 0..<thereToHereArr.count
            {
                let process = thereToHereArr[i]
                let prePreocess = hereToThereArr[i]
                
                if isValid(process: process, item: preDic!)
                {
                    let dic:NSMutableDictionary?
                    if index >= sortArray.count {
                        dic = NSMutableDictionary.init(dictionary: preDic!)
                        
                        sortArray.add(dic as Any)
                    } else {
                        dic = fetchDic(index: index)
                    }
                    
                    var arr:NSMutableArray? = dic?.object(forKey: VISIT_PATH) as? NSMutableArray
                    
                    if (arr != nil
                        && 0 < (arr?.count)!)
                    {
                        if arr?.lastObject is ProcessTHereToHere {
                            continue
                        }
                        
                        let tempProcess = arr?.lastObject as! ProcessHereToThere
                        
                        if prePreocess == tempProcess
                        {
                            continue
                        }
                    } else {
                        arr = NSMutableArray.init();
                    }
                    
                    arr?.add(process)
                    operation(process: process, index: index)
                    
                    dic?.setValue(arr, forKey: VISIT_PATH as String)
                    sortArray.replaceObject(at: index, with: dic as Any)
                    
                    start(sort: index)
                    
                    index += 1
                }
            }
            
            break
        }
    }
    
    private func fetchFarmer(index:Int) -> Farmer
    {
        var recordStatusArr:NSArray
        
        if index >= sortArray.count {
            recordStatusArr = initialRecordStatus()
            let item:NSDictionary = NSDictionary.init(objects: [NSArray.init(), recordStatusArr],
                                                      forKeys: [VISIT_PATH, RECORD_STATUS])
            
            sortArray.add(item)
        } else {
            let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
            
            recordStatusArr = item.object(forKey: RECORD_STATUS) as! NSArray
        }
        
        return recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
    }
    
    private func initialRecordStatus() -> NSArray
    {
        let farmer:Farmer = Farmer();
        let wolf:Wolf = Wolf();
        let sheep:Sheep = Sheep();
        let vegetable:Vegetable = Vegetable();
        
        let statusArr = NSArray.init(objects: farmer, wolf, sheep, vegetable)
        
        return statusArr
    }
    
    private func fetchDic(index:Int) -> NSMutableDictionary
    {
        let dic:NSMutableDictionary? = NSMutableDictionary.init(dictionary: (sortArray.object(at: index) as? NSDictionary)!) ;
        
        return dic!
    }
    
    private func isFinished(index:Int) -> Bool
    {
        if index >= sortArray.count {
            return false
        }
        
        let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
        
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        if farmer.sitStatus == .HERE {
            return false
        }
        
        if wolf.sitStatus == .HERE {
            return false
        }
        
        if sheep.sitStatus == .HERE {
            return false
        }
        
        if vegetable.sitStatus == .HERE {
            return false
        }
        
        return true
    }
    
    private func stayHERE(index: Int) -> NSMutableArray
    {
        let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
        
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        let hereArr = NSMutableArray.init(capacity: 5);
        
        switch farmer.sitStatus {
        case .HERE:
            hereArr.add(farmer)
            break
        default:
            break
        }
        
        switch wolf.sitStatus {
        case .HERE:
            hereArr.add(wolf);
        default:
            break;
        }
        
        switch sheep.sitStatus {
        case .HERE:
            hereArr.add(sheep);
        default:
            break;
        }
        
        switch vegetable.sitStatus {
        case .HERE:
            hereArr.add(vegetable);
        default:
            break;
        }
        
        
        return hereArr;
    }
    
    private func stayTHERE(index: Int) -> NSMutableArray
    {
        let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
        
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        let thereArr = NSMutableArray.init(capacity: 5);
        
        switch farmer.sitStatus {
        case .THERE:
            thereArr.add(farmer);
        default:
            break;
        }
        
        switch wolf.sitStatus {
        case .THERE:
            thereArr.add(wolf);
        default:
            break;
        }
        
        switch sheep.sitStatus {
        case .THERE:
            thereArr.add(sheep);
        default:
            break;
        }
        
        switch vegetable.sitStatus {
        case .THERE:
            thereArr.add(vegetable);
        default:
            break;
        }
        
        
        return thereArr;
    }
    
    
    private func isValid(process:ProcessHereToThere, item:NSDictionary) -> Bool
    {
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        switch process {
        case .FarmerFromHereToThere:
            
            if farmer.sitStatus == .HERE {
                if sheep.sitStatus == .HERE
                    && vegetable.sitStatus == .HERE
                {
                    return false
                }
                
                if wolf.sitStatus == .HERE
                    && sheep.sitStatus == .HERE
                {
                    return false
                }
                
                return true
            } else {
                return false
            }
            
        case .FarmerWithWolfFromHereToThere:
            if wolf.sitStatus == .HERE
            {
                if sheep.sitStatus == .HERE
                    && vegetable.sitStatus == .HERE
                {
                    return false
                }
                else
                {
                    return true
                }
            } else {
                return false
            }
            
            
        case .FarmerWithSheepFromHereToThere:
            if sheep.sitStatus == .HERE
            {
                return true
            } else {
                return false
            }
            
        case .FarmerWithVegetableFromHereToThere:
            if vegetable.sitStatus == .HERE
            {
                if wolf.sitStatus == .HERE
                    && sheep.sitStatus == .HERE
                {
                    return false
                }
                else
                {
                    return true
                }
            } else {
                return false
            }
        }
    }
    
    private func isValid(process:ProcessTHereToHere, item:NSMutableDictionary) -> Bool
    {
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        switch process {
        case .FarmerFromThereToHere:
            if farmer.sitStatus == .THERE {
                if sheep.sitStatus == .HERE
                    && vegetable.sitStatus == .HERE
                {
                    return false
                }
                
                if wolf.sitStatus == .HERE
                    && sheep.sitStatus == .HERE
                {
                    return false
                }
                
                return true
            } else {
                return false
            }
            
        case .FarmerWithWolfFromThereToHere:
            if wolf.sitStatus == .THERE
            {
                if sheep.sitStatus == .THERE
                    && vegetable.sitStatus == .THERE
                {
                    return false
                } else
                {
                    return true
                }
            } else {
                return false
            }
            
            
        case .FarmerWithSheepFromThereToHere:
            if sheep.sitStatus == .THERE
            {
                return true
            } else
            {
                return false
            }
            
        case .FarmerWithVegetableFromThereToHere:
            if vegetable.sitStatus == .THERE
            {
                if wolf.sitStatus == .THERE
                    && vegetable.sitStatus == .THERE
                {
                    return false
                }
                else
                {
                    return true
                }
            } else {
                return false
            }
        }
        
    }
    
    private func operation(process: ProcessHereToThere, index:Int)
    {
        let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
        
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        switch process {
        case .FarmerFromHereToThere:
            farmer.sitStatus = .THERE
            
        case .FarmerWithWolfFromHereToThere:
            wolf.sitStatus = .THERE
            farmer.sitStatus = .THERE
            
        case .FarmerWithSheepFromHereToThere:
            sheep.sitStatus = .THERE
            farmer.sitStatus = .THERE
            
        case .FarmerWithVegetableFromHereToThere:
            vegetable.sitStatus = .THERE
            farmer.sitStatus = .THERE
        }
    }
    
    private func operation(process: ProcessTHereToHere, index:Int)
    {
        let item:NSDictionary = sortArray.object(at: index) as! NSDictionary
        
        let recordStatusArr:NSArray = item.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = recordStatusArr.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = recordStatusArr.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = recordStatusArr.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        switch process {
        case .FarmerFromThereToHere:
            farmer.sitStatus = .HERE
            
        case .FarmerWithWolfFromThereToHere:
            wolf.sitStatus = .HERE
            farmer.sitStatus = .HERE
            
        case .FarmerWithSheepFromThereToHere:
            sheep.sitStatus = .HERE
            farmer.sitStatus = .HERE
            
        case .FarmerWithVegetableFromThereToHere:
            vegetable.sitStatus = .HERE
            farmer.sitStatus = .HERE
        }
    }
    
    private func printResult(index: Int)
    {
        if index >= sortArray.count
        {
            return
        }
        
        let item:NSDictionary? = sortArray.object(at: index) as? NSDictionary;
        let result:NSArray? = item?.object(forKey: VISIT_PATH) as? NSArray
        
        
        print("方案：\(index) \n")
        
        for process in result!
        {
            switch process {
            case ProcessHereToThere.FarmerFromHereToThere:
                print("农夫独自过去 \n")
                
                break
                
            case ProcessHereToThere.FarmerWithWolfFromHereToThere:
                print("农夫带狼过去 \n")
                
                break
                
            case ProcessHereToThere.FarmerWithSheepFromHereToThere:
                print("农夫带羊过去 \n")
                
                break
                
            case ProcessHereToThere.FarmerWithVegetableFromHereToThere:
                print("农夫带白菜过去 \n")
                
                break
                
            case ProcessTHereToHere.FarmerFromThereToHere:
                print("农夫独自回来 \n")
                
                break
            
            case ProcessTHereToHere.FarmerWithWolfFromThereToHere:
                print("农夫带狼回来 \n")
                
                break
                
            case ProcessTHereToHere.FarmerWithSheepFromThereToHere:
                print("农夫带羊回来 \n")
                
                break
                
            case ProcessTHereToHere.FarmerWithVegetableFromThereToHere:
                print("农夫带白菜回来 \n")
                
                break
                
            default:
                break
            }
        }
        
    }
}
