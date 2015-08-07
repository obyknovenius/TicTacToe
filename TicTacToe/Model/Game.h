//
//  Game.h
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    GameResultNone,
    GameResultPlayer1Win,
    GameResultPlayer2Win,
    GameResultTie,
} GameResult;

@class Board;

@interface Game : NSObject

@property (nonatomic, readonly) Board *board;

@property (nonatomic, readonly) char player1Character;
@property (nonatomic, readonly) char player2Character;

- (instancetype)initWithBoardSideLength:(int)sideLength;

- (void)restartGame;
- (char)makeMoveToIndex:(int)index;

- (GameResult)gameResult;

@end