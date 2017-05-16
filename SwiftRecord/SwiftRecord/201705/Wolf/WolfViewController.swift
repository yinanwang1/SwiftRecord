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
    let PRE_NUMBER:NSString      = "number_pre"
    let PRE_VALUE:NSString       = "number_value"
    var bestWaySteps:Int         = Int(INT_MAX)
    
    
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
    
    private var preArray:NSMutableArray = NSMutableArray.init(capacity: 5);
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
        
        let result:NSMutableArray? = recordPathsAtIndex(index: index)
        
        if (result?.count)! > bestWaySteps {
            return
        }
        
        if isFinished(index:index) {
            printResult(index: index);
            
            return;
        }
        
        var preDic:NSMutableDictionary? = nil
        
        for i in 0..<preArray.count {
            let item:NSDictionary = preArray.object(at: i) as! NSDictionary
            
            let number = item.object(forKey: PRE_NUMBER)
            if number as! Int == sort {
                preDic = NSMutableDictionary.init(dictionary: item.object(forKey: PRE_VALUE) as! NSDictionary)
            }
        }
        
        if nil == preDic {
            preDic = initialStatus()
            
            let tempDic = NSDictionary.init(objects: [sort, preDic as Any],
                                            forKeys: [PRE_NUMBER, PRE_VALUE])
            
            preArray.add(tempDic as Any)
        }
        
        let recordStatusArr:NSArray = preDic!.object(forKey: RECORD_STATUS) as! NSArray
        
        let farmer:Farmer = recordStatusArr.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        
        switch farmer.sitStatus {
        case .HERE:
            for i in 0..<hereToThereArr.count
            {
                let process:ProcessHereToThere = hereToThereArr[i]
                let prePreocess:ProcessTHereToHere = thereToHereArr[i]
                
                if isValid(process: process, item: preDic!)
                {
                    var arr:NSMutableArray? = NSMutableArray.init(array:(preDic?.object(forKey: VISIT_PATH)) as! NSArray)
                    let record:NSArray? = preDic?.object(forKey: RECORD_STATUS) as? NSArray
                    
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
                    
                    index += 1
                    
                    arr?.add(process)
                    let recordStatusArr = operation(process: process, record:record!)
                    let item:NSMutableDictionary = NSMutableDictionary.init(objects: [arr as Any, recordStatusArr],
                                                                            forKeys: [VISIT_PATH, RECORD_STATUS])
                    
                    let tempDic = NSDictionary.init(objects: [index, item as Any],
                                                    forKeys: [PRE_NUMBER, PRE_VALUE])
                    
                    preArray.add(tempDic)
                    
                    start(sort: index)
                    
                }
            }
            
            break
            
        case .THERE:
            for i in 0..<thereToHereArr.count
            {
                let process = thereToHereArr[i]
                let prePreocess = hereToThereArr[i]
                
                if isValid(process: process, item: preDic!)
                {
                    var arr:NSMutableArray? = NSMutableArray.init(array:(preDic?.object(forKey: VISIT_PATH)) as! NSArray)
                    let record:NSArray? = preDic?.object(forKey: RECORD_STATUS) as? NSArray
                    
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
                    
                    index += 1
                    
                    arr?.add(process)
                    let recordStatusArr = operation(process: process, record:record!)
                    let item:NSMutableDictionary = NSMutableDictionary.init(objects: [arr as Any, recordStatusArr],
                                                                            forKeys: [VISIT_PATH, RECORD_STATUS])
                    
                    let tempDic = NSDictionary.init(objects: [index, item as Any],
                                                    forKeys: [PRE_NUMBER, PRE_VALUE])
                    
                    preArray.add(tempDic)
                    
                    start(sort: index)
                }
            }
            
            break
        }
    }
    
    private func initialStatus() -> NSMutableDictionary
    {
        let recordStatusArr:NSArray = initialRecordStatus()
        let item:NSMutableDictionary = NSMutableDictionary.init(objects: [NSArray.init(), recordStatusArr],
                                                      forKeys: [VISIT_PATH, RECORD_STATUS])
        
        return item
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
    
    private func isFinished(index:Int) -> Bool
    {
        var preDic:NSMutableDictionary? = nil
        
        for i in 0..<preArray.count {
            let item:NSDictionary = preArray.object(at: i) as! NSDictionary
            
            let number = item.object(forKey: PRE_NUMBER)
            if number as! Int == index {
                preDic = NSMutableDictionary.init(dictionary: item.object(forKey: PRE_VALUE) as! NSDictionary)
            }
        }
        
        if nil == preDic {
            return false
        }
        
        let recordStatusArr:NSArray = preDic!.object(forKey: RECORD_STATUS) as! NSArray
        
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
                if sheep.sitStatus == .THERE
                    && vegetable.sitStatus == .THERE
                {
                    return false
                }
                
                if wolf.sitStatus == .THERE
                    && sheep.sitStatus == .THERE
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
    
    private func operation(process: ProcessHereToThere, record:NSArray) -> NSArray
    {
        let farmer:Farmer = record.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = record.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = record.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = record.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        let farmerNew:Farmer = Farmer();
        farmerNew.sitStatus = farmer.sitStatus;
        
        let wolfNew:Wolf = Wolf();
        wolfNew.sitStatus = wolf.sitStatus;
        
        let sheepNew:Sheep = Sheep()
        sheepNew.sitStatus = sheep.sitStatus;
        
        let vegetableNew:Vegetable = Vegetable()
        vegetableNew.sitStatus = vegetable.sitStatus;
        
        
        
        switch process {
        case .FarmerFromHereToThere:
            farmerNew.sitStatus = .THERE
            
        case .FarmerWithWolfFromHereToThere:
            wolfNew.sitStatus = .THERE
            farmerNew.sitStatus = .THERE
            
        case .FarmerWithSheepFromHereToThere:
            sheepNew.sitStatus = .THERE
            farmerNew.sitStatus = .THERE
            
        case .FarmerWithVegetableFromHereToThere:
            vegetableNew.sitStatus = .THERE
            farmerNew.sitStatus = .THERE
        }
        
        return NSArray.init(objects: farmerNew, wolfNew, sheepNew, vegetableNew)
    }
    
    private func operation(process: ProcessTHereToHere, record:NSArray) -> NSArray
    {
        let farmer:Farmer = record.object(at: SortWhole.FarmerSort.rawValue) as! Farmer
        let wolf:Wolf = record.object(at: SortWhole.WolfSort.rawValue) as! Wolf
        let sheep:Sheep = record.object(at: SortWhole.SheepSort.rawValue) as! Sheep
        let vegetable:Vegetable = record.object(at: SortWhole.VegetableSort.rawValue) as! Vegetable
        
        let farmerNew:Farmer = Farmer();
        farmerNew.sitStatus = farmer.sitStatus;
        
        let wolfNew:Wolf = Wolf();
        wolfNew.sitStatus = wolf.sitStatus;
        
        let sheepNew:Sheep = Sheep()
        sheepNew.sitStatus = sheep.sitStatus;
        
        let vegetableNew:Vegetable = Vegetable()
        vegetableNew.sitStatus = vegetable.sitStatus;
        
        switch process {
        case .FarmerFromThereToHere:
            farmerNew.sitStatus = .HERE
            
        case .FarmerWithWolfFromThereToHere:
            wolfNew.sitStatus = .HERE
            farmerNew.sitStatus = .HERE
            
        case .FarmerWithSheepFromThereToHere:
            sheepNew.sitStatus = .HERE
            farmerNew.sitStatus = .HERE
            
        case .FarmerWithVegetableFromThereToHere:
            vegetableNew.sitStatus = .HERE
            farmerNew.sitStatus = .HERE
        }
        
        return NSArray.init(objects: farmerNew, wolfNew, sheepNew, vegetableNew)
    }
    
    private func printResult(index: Int)
    {
        let result:NSMutableArray? = recordPathsAtIndex(index: index)
        
        if (result?.count)! < bestWaySteps {
            bestWaySteps = (result?.count)!
        }
        
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
    
    private func recordPathsAtIndex(index:Int) -> NSMutableArray
    {
        var preDic:NSMutableDictionary? = nil
        
        for i in 0..<preArray.count
        {
            let item:NSDictionary = preArray.object(at: i) as! NSDictionary
            
            let number = item.object(forKey: PRE_NUMBER)
            if number as! Int == index {
                preDic = NSMutableDictionary.init(dictionary: item.object(forKey: PRE_VALUE) as! NSDictionary)
            }
        }
        
        if nil == preDic {
            return NSMutableArray.init()
        }
        
        let result:NSMutableArray? = NSMutableArray.init(array:(preDic?.object(forKey: VISIT_PATH)) as! NSArray)
        
        return result!
    }
}
