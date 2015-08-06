//
//  Game.m
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import "Game.h"

#define BOARD_SIZE 9

@interface Game ()

@property (nonatomic) char *board;
@property (nonatomic) char currentPlayer;

@end

@implementation Game

- (instancetype)init {
    self = [super init];
    if (self) {
        _board = malloc(sizeof(char) * BOARD_SIZE);
    }
    return self;
}

- (void)dealloc {
    free(_board);
}

- (void)restartGame {
    memset(self.board, ' ', sizeof(char) * BOARD_SIZE);
    self.currentPlayer = 'x';
}

- (char)makeMoveToIndex:(int)index {
    if (self.board[index] == ' ') {
        char currentPlayer = self.currentPlayer;
        self.board[index] = currentPlayer;
        
        if (currentPlayer == 'x')
            self.currentPlayer = 'o';
        else if (currentPlayer == 'o')
            self.currentPlayer = 'x';
        
        [self performSelector:@selector(checkGameResult) withObject:nil afterDelay:0.5f];
        
        return currentPlayer;
    }
    return ' ';
}

- (void)checkGameResult {
    GameResult result;
    if ([self has3InLine:'x']) {
        result = GameResultPlayer1Win;
    } else if ([self has3InLine:'o']) {
        result = GameResultPlayer2Win;
    } else {
        for (int i = 0; i < BOARD_SIZE; i++) {
            if (self.board[i] == ' ') {
                return;
            }
        }
        
        result = GameResultTie;
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(game:DidFinishWithResult:)]) {
        [self.delegate game:self DidFinishWithResult:result];
    }
}

- (BOOL)has3InLine:(char)value {
    return (self.board[0] == value && self.board[1] == value && self.board[2] == value)
    || (self.board[3] == value && self.board[4] == value && self.board[5] == value)
    || (self.board[6] == value && self.board[7] == value && self.board[8] == value)
    || (self.board[0] == value && self.board[3] == value && self.board[6] == value)
    || (self.board[1] == value && self.board[4] == value && self.board[7] == value)
    || (self.board[2] == value && self.board[5] == value && self.board[8] == value)
    || (self.board[0] == value && self.board[4] == value && self.board[8] == value)
    || (self.board[2] == value && self.board[4] == value && self.board[6] == value);
}

@end
