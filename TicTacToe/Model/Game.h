//
//  Game.h
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GameResultPlayer1Win,
    GameResultPlayer2Win,
    GameResultTie,
} GameResult;

@protocol GameResult;

@interface Game : NSObject

- (instancetype)init;
- (void)restartGame;
- (char)makeMoveToIndex:(int)index;

@property (nonatomic, weak) id<GameResult> delegate;

@end

@protocol GameResult <NSObject>

- (void)game:(Game *)game DidFinishWithResult:(GameResult)result;

@end