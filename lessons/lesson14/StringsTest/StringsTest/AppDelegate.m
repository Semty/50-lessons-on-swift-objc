//
//  AppDelegate.m
//  StringsTest
//
//  Created by Руслан on 02.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
    NSString *string1 = @"String 1";
    NSString *string2 = @"String 2";
    
    NSArray *array = @[ string1, string2 ];
    
    for (NSString *string in array) {
        if ([@"String 2" isEqualToString:string]) {
            NSLog(@"\n\n\nindex = %d\n\n\n", [array indexOfObject:string]);
        }
    }
    */
    /*
    NSString *string = @"Hello, World!";
    
    NSLog(@"\n\n\n%@\n\n\n", string);
    
    NSRange range = [string rangeOfString:@"wOrLD!" options:NSCaseInsensitiveSearch | NSBackwardsSearch];
    
    if (range.location != NSNotFound) {
        NSLog(@"Our string from the range = %@\n\n\n", NSStringFromRange(range));
    } else {
        NSLog(@"Not found\n\n\n");
    }*/
    /*
    NSString *text = @"Swift is a new programming language for iOS, macOS, watchOS, and tvOS apps that builds on the best of C and Objective-C, without the constraints of C compatibility. Swift adopts safe programming patterns and adds modern features to make programming easier, more flexible, and more fun. Swift’s clean slate, backed by the mature and much-loved Cocoa and Cocoa Touch frameworks, is an opportunity to reimagine how software development works. Swift has been years in the making. Apple laid the foundation for Swift by advancing our existing compiler, debugger, and framework infrastructure. We simplified memory management with Automatic Reference Counting (ARC). Our framework stack, built on the solid base of Foundation and Cocoa, has been modernized and standardized throughout. Objective-C itself has evolved to support blocks, collection literals, and modules, enabling framework adoption of modern language technologies without disruption. Thanks to this groundwork, we can now introduce a new language for the future of Apple software development. Swift feels familiar to Objective-C developers. It adopts the readability of Objective-C’s named parameters and the power of Objective-C’s dynamic object model. It provides seamless access to existing Cocoa frameworks and mix-and-match interoperability with Objective-C code. Building from this common ground, Swift introduces many new features and unifies the procedural and object-oriented portions of the language. Swift is friendly to new programmers. It is the first industrial-quality systems programming language that is as expressive and enjoyable as a scripting language. It supports playgrounds, an innovative feature that allows programmers to experiment with Swift code and see the results immediately, without the overhead of building and running an app.";
    */
    //text = [text substringToIndex:5];
    
    //text = [text substringWithRange:NSMakeRange(15, 20)];
    /*
    NSRange range = [text rangeOfString:@"Swift adopts safe programming"];
    
    if (range.location != NSNotFound) {
        text = [text substringToIndex:range.location];
    }
    
    NSLog(@"%@", text);
    */
    /*
    NSRange search = NSMakeRange(0, [text length]);
    NSInteger count = 0;
    
    while (YES) {
        
        NSRange range = [text rangeOfString:@"Swift" options:0 range:search];
        
        if (range.location != NSNotFound) {
            NSInteger indexOfStart = range.location + range.length;
            count += 1;
            search = NSMakeRange(indexOfStart, [text length] - (indexOfStart));
        } else {
            break;
        }
    }
    
    NSLog(@"Swift - %d", count);
    */
    
    //text = [text stringByReplacingOccurrencesOfString:@"Swift" withString:@"*GOD'S LANGUAGE*"];
    //text = [text uppercaseString];
    
    //NSLog(@"\n\n\n\n %@ \n\n\n\n", text);
    
    //NSLog(@"%d", [@"512" intValue]);
    /*
    text = [text stringByReplacingOccurrencesOfString:@"." withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    NSArray *array = [text componentsSeparatedByString:@" "];
    
    for (NSString *word in array) {
        NSLog(@"%@", word);
    }
    NSLog(@"\n\n\n\n");
    
    text = [array componentsJoinedByString:@"_"];
    
    NSLog(@"%@", text);
    */
    
    NSString *s1 = @"Hello, ";
    NSString *s2 = @"World!";
    
    NSString *s3 = [s1 stringByAppendingString:s2];
    
    NSLog(@"%@", s3);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
