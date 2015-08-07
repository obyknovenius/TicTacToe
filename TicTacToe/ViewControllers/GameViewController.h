//
//  GameViewController.h
//  
//
//  Created by Vitaly Dyachkov on 04/08/15.
//
//

#import <UIKit/UIKit.h>

@interface GameViewController : UIViewController

@property (nonatomic, getter=isComputerPlay) BOOL computerPlay;
@property (nonatomic, getter=isComputerFirst) BOOL computerFirst;

@end
