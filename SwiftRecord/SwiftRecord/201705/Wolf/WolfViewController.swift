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
        
        start(index: 0);
    }
    
    private func start(index:Int)
    {
        print("start index is \(index)")
        
        printResult(index: index);
        
        if isFinished() {
            printResult(index: index);
            
            return;
        }
        
        var arr:NSMutableArray?
        
        if index >= sortArray.count {
            if 0 <= index - 1
            {
                let arrPre:NSArray? = sortArray.object(at: index - 1) as? NSArray;
                
                arr = NSMutableArray.init(array: arrPre!);
            } else {
                arr = NSMutableArray.init();
            }
            
            sortArray.add(arr as Any)
        } else {
           arr = sortArray.object(at: index) as? NSMutableArray;
        }
        
        switch farmer.sitStatus {
        case .HERE:
            for i in 0..<hereToThereArr.count
            {
                print("hereToThereArr i is \(i)")
                
                let process = hereToThereArr[i]
                
                if isValid(process: process)
                {
                    if (0 < (arr?.count)!)
                        && (arr?.lastObject is ProcessHereToThere)
                        && (process == arr?.lastObject as! ProcessHereToThere)
                    {
                        continue;
                    }
                    
                    arr?.add(process)
                    
                    if 0 == i {
                        start(index: index)
                    } else {
                        start(index: index + 1)
                    }
                }
            }
            
            break
            
        case .THERE:
            for i in 0..<thereToHereArr.count
            {
                print("thereToHereArr i is \(i)")
                
                let process = thereToHereArr[i]
                
                if isValid(process: process)
                {
                    if (0 < (arr?.count)!)
                        && (arr?.lastObject is ProcessTHereToHere)
                        && process == arr?.lastObject as! ProcessTHereToHere
                    {
                        continue;
                    }
                    
                    arr?.add(process)
                    
                    if 0 == i {
                        start(index: index)
                    } else {
                        start(index: index + 1)
                    }
                }
            }
            
            break
        }
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
        let thereArr:NSMutableArray = NSMutableArray.init(array: stayTHERE());
        
        switch process {
        case .FarmerFromHereToThere:
            
            print("FarmerFromHereToThere")
            
            if hereArr.contains(farmer)
            {
                hereArr.remove(farmer)
                thereArr.add(farmer)
                
                farmer.sitStatus = .THERE
                
                return true
            } else {
                return false
            }
            
        case .FarmerWithWolfFromHereToThere:
            print("FarmerWithWolfFromHereToThere")
            
            if hereArr.contains(wolf)
            {
                hereArr.remove(wolf)
                thereArr.add(wolf)
                
                wolf.sitStatus = .THERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
            
        case .FarmerWithSheepFromHereToThere:
            print("FarmerWithSheepFromHereToThere")
            
            if hereArr.contains(sheep)
            {
                hereArr.remove(sheep)
                thereArr.add(sheep)
                
                sheep.sitStatus = .THERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
            
        case .FarmerWithVegetableFromHereToThere:
            print("FarmerWithVegetableFromHereToThere")
            
            if hereArr.contains(vegetable)
            {
                hereArr.remove(vegetable)
                thereArr.add(vegetable)
                
                vegetable.sitStatus = .THERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
        }
        
    }
    
    private func isValid(process:ProcessTHereToHere) -> Bool
    {
        print("isValid ProcessTHereToHere")
        
        let hereArr:NSMutableArray = NSMutableArray.init(array: stayHERE());
        let thereArr:NSMutableArray = NSMutableArray.init(array: stayTHERE());
        
        switch process {
        case .FarmerFromThereToHere:
            
            print("FarmerFromThereToHere")
            
            if thereArr.contains(farmer)
            {
                thereArr.remove(farmer)
                hereArr.add(farmer)
                
                farmer.sitStatus = .HERE
                
                return true
            } else {
                return false
            }
            
        case .FarmerWithWolfFromThereToHere:
            print("FarmerWithWolfFromThereToHere")
            
            if thereArr.contains(wolf)
            {
                thereArr.remove(wolf)
                hereArr.add(wolf)
                
                wolf.sitStatus = .HERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
            
        case .FarmerWithSheepFromThereToHere:
            print("FarmerWithSheepFromThereToHere")
            
            if thereArr.contains(sheep)
            {
                thereArr.remove(sheep)
                hereArr.add(sheep)
                
                sheep.sitStatus = .HERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
            
        case .FarmerWithVegetableFromThereToHere:
            print("FarmerWithVegetableFromThereToHere")
            
            if thereArr.contains(vegetable)
            {
                thereArr.remove(vegetable)
                hereArr.add(vegetable)
                
                vegetable.sitStatus = .HERE
                
                return isValid(hereArr: hereArr, thereArr: thereArr)
            } else {
                return false
            }
        }
        
    }
    
    private func isValid(hereArr:NSArray, thereArr:NSArray) -> Bool
    {
        print("isValid")
        
        if (hereArr.contains(wolf)
            && hereArr.contains(sheep))
        {
            return false;
        }
        
        if (hereArr.contains(sheep)
            && hereArr.contains(vegetable))
        {
            return false;
        }
        
        if (thereArr.contains(wolf)
            && thereArr.contains(sheep))
        {
            return false;
        }
        
        if (thereArr.contains(sheep)
            && thereArr.contains(vegetable))
        {
            return false;
        }
        
        return true;
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
