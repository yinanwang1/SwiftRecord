//
//  WolfViewController.swift
//  SwiftRecord
//
//  Created by ArthurWang on 2017/5/10.
//  Copyright © 2017年 wang. All rights reserved.
//

import UIKit

class WolfViewController: UIViewController {
    
    enum ProcessHereToThere {
        case FarmerFromHereToThere
        case FarmerWithWolfFromHereToThere
        case FarmerWithSheepFromHereToThere
        case FarmerWithVegetableFromHereToThere
    }
    
    enum ProcessTHereToHere {
        case FarmerFromThereToHere
        case FarmerWithWolfFromThereToHere
        case FarmerWithSheepFromThereToHere
        case FarmerWithVegetableFromThereToHere
    }
    
    
    private var farmer:Farmer = Farmer();
    private var wolf:Wolf = Wolf();
    private var sheep:Sheep = Sheep();
    private var vegetable:Vegetable = Vegetable();
    
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
        
        print("start index is \(index)")
        
        if isFinished() {
            printResult(index: index);
            
            return;
        }
        
        
        switch farmer.sitStatus {
        case .HERE:
            for i in 0..<hereToThereArr.count
            {
                print("hereToThereArr i is \(i)")
                
                let process:ProcessHereToThere = hereToThereArr[i]
                let prePreocess:ProcessTHereToHere = thereToHereArr[i]
                
                if isValid(process: process)
                {
                   print("\(process) is valid");
                    
                    let arr:NSMutableArray? = fetchArr(index: index, original: sort)
                    
                    if (0 < (arr?.count)!)
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
                    }
                    
                    arr?.add(process)
                    operation(process: process)
                    
                    sortArray.replaceObject(at: index, with: arr as Any)
                    
                    start(sort: index)
                    
                    index += 1
                }
                else
                {
                    print("\(process) is valid");
                }
            }
            
            break
            
        case .THERE:
            for i in 0..<thereToHereArr.count
            {
                print("thereToHereArr i is \(i)")
                
                let process = thereToHereArr[i]
                let prePreocess = hereToThereArr[i]
                
                if isValid(process: process)
                {
                    print("\(process) is valid");
                    
                    let arr:NSMutableArray? = fetchArr(index: index, original: sort)
                    
                    if (0 < (arr?.count)!)
                    {
                        if arr?.lastObject is ProcessTHereToHere {
                            continue
                        }
                        
                        let tempProcess = arr?.lastObject as! ProcessHereToThere
                        
                        if prePreocess == tempProcess
                        {
                            continue
                        }
                    }
                    
                    arr?.add(process)
                    operation(process: process)
                    
                    sortArray.replaceObject(at: index, with: arr as Any)
                    
                    start(sort: index)
                    
                    index += 1
                }
                else
                {
                    print("\(process) is invalid");
                }
            }
            
            break
        }
    }
    
    private func fetchArr(index:Int, original:Int) -> NSMutableArray
    {
        var arr:NSMutableArray?
        
        if index >= sortArray.count {
            if original == 0
            {
                arr = NSMutableArray.init();
            } else {
                arr = sortArray.object(at: original) as? NSMutableArray;
            }
            
            sortArray.add(arr as Any)
            
        } else {
            arr = sortArray.object(at: index) as? NSMutableArray;
        }
        
        return arr!
    }
    
    private func isFinished() -> Bool
    {
        print("isFinished")
        
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
    
    private func stayHERE() -> NSMutableArray
    {
        print("stayHERE")
        
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
    
    private func stayTHERE() -> NSMutableArray
    {
        print("stayTHERE")
        
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
    
    
    private func isValid(process:ProcessHereToThere) -> Bool
    {
        print("isValid ProcessHereToThere")
        
        let hereArr:NSMutableArray = NSMutableArray.init(array: stayHERE());
        
        switch process {
        case .FarmerFromHereToThere:
            
            print("FarmerFromHereToThere")
            
            return true
            
        case .FarmerWithWolfFromHereToThere:
            print("FarmerWithWolfFromHereToThere")
            
            if hereArr.contains(wolf) {
                if hereArr.contains(sheep)
                    && hereArr.contains(vegetable)
                {
                    return true
                }
                else
                {
                    return false
                }
            } else {
                return false
            }
            
            
        case .FarmerWithSheepFromHereToThere:
            print("FarmerWithSheepFromHereToThere")
            
            if hereArr.contains(sheep) {
                return true
            } else {
                return false
            }
            
        case .FarmerWithVegetableFromHereToThere:
            print("FarmerWithVegetableFromHereToThere")
            
            if hereArr.contains(vegetable) {
                if hereArr.contains(wolf)
                    && hereArr.contains(sheep){
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
    
    private func isValid(process:ProcessTHereToHere) -> Bool
    {
        print("isValid ProcessTHereToHere")

        let thereArr:NSMutableArray = NSMutableArray.init(array: stayTHERE());
        
        switch process {
        case .FarmerFromThereToHere:
            
            print("FarmerFromThereToHere")
            
            return true
            
        case .FarmerWithWolfFromThereToHere:
            print("FarmerWithWolfFromThereToHere")
            
            if thereArr.contains(wolf)
            {
                if thereArr.contains(sheep)
                    && thereArr.contains(vegetable)
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
            print("FarmerWithSheepFromThereToHere")
            
            if thereArr.contains(sheep) {
                return true
            } else {
                return false
            }
            
        case .FarmerWithVegetableFromThereToHere:
            print("FarmerWithVegetableFromThereToHere")
            
            if thereArr.contains(vegetable) {
                if thereArr.contains(sheep)
                    && thereArr.contains(vegetable)
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
    
    private func operation(process: ProcessHereToThere)
    {
        print("operation ProcessHereToThere")
        
        
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
    
    private func operation(process: ProcessTHereToHere)
    {
        print("operation ProcessTHereToHere")
        
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
        print("printResult")
        
        if index >= sortArray.count
        {
            return
        }
        
        let result:NSMutableArray? = sortArray.object(at: index) as? NSMutableArray;
        
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
