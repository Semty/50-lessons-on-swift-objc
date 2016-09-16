//
//  AppDelegate.swift
//  HW5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        // Level:                                       ***LEARNER***
        let human = Human(name: "Zahar", height: 174.5, weight: 66.5, gender: "Male")
        let cyclist = Cyclist(name: "Ruslan", height: 182, weight: 61.5, gender: "Male")
        let runner = Runner(name: "Eduard", height: 178.3, weight: 66.2, gender: "Male")
        let swimmer = Swimmer(name: "Galya", height: 164.6, weight: 52.1, gender: "Female")
        /*
        let people = [human, cyclist, runner, swimmer];
        for man in people {
            print(" Name: \(man.name)\n",
                  "Height: \(man.height)\n",
                  "Weight: \(man.weight)\n",
                  "Gender: \(man.gender)")
            man.movement()
            print("")
        }*/
        // Level:                                       ***STUDENT***
        let boxer = Boxer(skinColor: "White", nationality: "Tajik", name: "Akram",
                          height: 174.5, weight: 64.7, gender: "Male")
        /*
        let people = [human, cyclist, runner, swimmer, boxer]
        for man in people.reverse() {
            print(" Name: \(man.name)\n",
                "Height: \(man.height)\n",
                "Weight: \(man.weight)\n",
                "Gender: \(man.gender)")
            if let boxerMan = man as? Boxer {
                print(" Skin color: \(boxerMan.skinColor)\n",
                      "Nationality: \(boxerMan.nationality)")
                boxerMan.movement()
                print("")
            } else {
                man.movement()
                print("")
            }
        }*/
        // Level:                                       ***MASTER***
        let animal = Animal(species: "Some Animal", name: "Default name", age: 5)
        let dog = Dog(species: "Dog", name: "Sharik", age: 10)
        let cat = Cat(species: "Cat", name: "Tosya", age: 2)
        /*
        let peopleAndAnimal: [AnyObject] = [human, cyclist, runner, swimmer, boxer, animal, dog, cat]
        
        for object in peopleAndAnimal {
            if let human = object as? Human {
                print(" ***HUMAN***\nName: \(human.name)\n",
                    "Height: \(human.height)\n",
                    "Weight: \(human.weight)\n",
                    "Gender: \(human.gender)")
                if let boxerMan = human as? Boxer {
                    print(" Skin color: \(boxerMan.skinColor)\n",
                        "Nationality: \(boxerMan.nationality)")
                    boxerMan.movement()
                    print("")
                } else {
                    human.movement()
                    print("")
                }
            } else if let animal = object as? Animal {
                print(" ***ANIMAL***\nSpecies: \(animal.species)\n",
                      "Name: \(animal.name)\n",
                      "Age: \(animal.age)")
                animal.movement()
                print("")
            }
        }*/
        // Level:                                       ***STAR***
        /*
        let people = [human, cyclist, runner, swimmer, boxer]
        let animals = [animal, dog, cat]
        
        for i in 0..<max(people.count, animals.count) {
            if i < people.count {
                let human = people[i]
                print(" ***HUMAN***\nName: \(human.name)\n",
                    "Height: \(human.height)\n",
                    "Weight: \(human.weight)\n",
                    "Gender: \(human.gender)")
                if let boxerMan = human as? Boxer {
                    print(" Skin color: \(boxerMan.skinColor)\n",
                        "Nationality: \(boxerMan.nationality)")
                    boxerMan.movement()
                    print("")
                } else {
                    human.movement()
                    print("")
                }
            }
            if i < animals.count {
                let animal = animals[i]
                print(" ***ANIMAL***\nSpecies: \(animal.species)\n",
                    "Name: \(animal.name)\n",
                    "Age: \(animal.age)")
                animal.movement()
                print("")
            }
        }*/
        // Level:                                       ***SUPERMAN***
        var peopleAndAnimal: [AnyObject] = [human, animal, runner, cat, boxer, cyclist, dog, swimmer]
        
        peopleAndAnimal = peopleAndAnimal.sort { obj1, obj2 in
            if let human1 = obj1 as? Human {
                if let human2 = obj2 as? Human {
                    return human1.name < human2.name
                }
            }
            
            if let animal1 = obj1 as? Animal {
                if let animal2 = obj2 as? Animal {
                    return animal1.name < animal2.name
                }
            }
            
            if obj1 is Human {
                return true
            } else {
                return false
            }
        }
        
        for object in peopleAndAnimal {
            if let human = object as? Human {
                print(" ***HUMAN***\nName: \(human.name)\n",
                    "Height: \(human.height)\n",
                    "Weight: \(human.weight)\n",
                    "Gender: \(human.gender)")
                if let boxerMan = human as? Boxer {
                    print(" Skin color: \(boxerMan.skinColor)\n",
                        "Nationality: \(boxerMan.nationality)")
                    boxerMan.movement()
                    print("")
                } else {
                    human.movement()
                    print("")
                }
            } else if let animal = object as? Animal {
                print(" ***ANIMAL***\nSpecies: \(animal.species)\n",
                    "Name: \(animal.name)\n",
                    "Age: \(animal.age)")
                animal.movement()
                print("")
            }
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

