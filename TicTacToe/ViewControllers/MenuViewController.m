//
//  MenuViewController.m
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 08.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import "MenuViewController.h"
#import "GameViewController.h"

@implementation MenuViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameViewController *gameViewController = (GameViewController *)segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"HvsH"]) {
        // Do nothing. This is default option.
    } else if ([segue.identifier isEqualToString:@"HvsC"]) {
        gameViewController.computerPlay = YES;
    } else if ([segue.identifier isEqualToString:@"CvsH"]) {
        gameViewController.computerPlay = YES;
        gameViewController.computerFirst = YES;
    }
}

@end
