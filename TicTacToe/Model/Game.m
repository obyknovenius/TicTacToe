//
//  Game.m
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import "Game.h"
#import "Board.h"

@interface Game ()

@property (nonatomic, strong) Board *board;

@property (nonatomic) char player1Character;
@property (nonatomic) char player2Character;

@property (nonatomic) char currentPlayerCharacter;

@end

@implementation Game

- (instancetype)initWithBoardSideLength:(int)sideLength {
    self = [super init];
    if (self) {
        _board = [[Board alloc] initWithSideLength:sideLength];
        
        _player1Character = 'x';
        _player2Character = 'o';
    }
    return self;
}

- (void)restartGame {
    [self.board clearBoard];
    self.currentPlayerCharacter = self.player1Character;
}

- (char)makeMoveToIndex:(int)index {
    if ([self.board characterAtIndex:index] == ' ') {
        char currentPlayerCharacter = self.currentPlayerCharacter;
        [self.board setCharacter:currentPlayerCharacter atIndex:index];
        
        if (currentPlayerCharacter == self.player1Character)
            self.currentPlayerCharacter = self.player2Character;
        else if (currentPlayerCharacter == self.player2Character)
            self.currentPlayerCharacter = self.player1Character;
        
        return currentPlayerCharacter;
    }
    return ' ';
}

- (GameResult)gameResult {
    GameResult result;
    
    if ([self.board isLineWithCharacter:self.player1Character]) {
        result = GameResultPlayer1Win;
    } else if ([self.board isLineWithCharacter:self.player2Character]) {
        result = GameResultPlayer2Win;
    } else {
        for (int i = 0; i < self.board.size; i++) {
            if ([self.board characterAtIndex:i] == ' ') {
                return GameResultNone;
            }
        }
        
        result = GameResultTie;
    }
    
    return result;
}



@end
