//
//  AI.m
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import "AI.h"
#import "Board.h"

@interface AI ()

@property (nonatomic, strong) Board *board;

@property (nonatomic) char aiCharacter;
@property (nonatomic) char humanCharacter;

@property (nonatomic) int bestMove;

@end

@implementation AI

- (instancetype)initWithBoard:(Board *)board aiCharacter:(char)aiCharacter humanCharacter:(char)humanCharacter {
    self = [super init];
    if (self) {
        _board = board;
        
        _aiCharacter = aiCharacter;
        _humanCharacter = humanCharacter;
    }
    
    return self;
}

- (int)nextMove {
    if ([[self.board emptyIndexes] count] == self.board.size) {
        return arc4random_uniform(self.board.size);
    }
    [self miniMaxForBoard:self.board character:self.aiCharacter withDepth:0];
    return self.bestMove;
}

- (int)miniMaxForBoard:(Board *)board character:(char)character withDepth:(int)depth {
    int score = [self getScoreForBoard:board withDepth:depth];
    if (score != 0) {
        return score;
    }
    
    depth++;
    
    NSMutableArray *scores = [[NSMutableArray alloc] init];
    NSMutableArray *moves = [[NSMutableArray alloc] init];
    
    NSArray *emptyIndexes = [board emptyIndexes];
    if ([emptyIndexes count] == 0) {
        return 0;
    }
    
    char opponentCharacter = (character == self.aiCharacter) ? self.humanCharacter : self.aiCharacter;
    
    for (NSNumber *indexNumber in emptyIndexes) {
        Board *newBoard = [board copy];
        int emptyIndex = [indexNumber intValue];
        [newBoard setCharacter:character atIndex:emptyIndex];
        [scores addObject:@([self miniMaxForBoard:newBoard character:opponentCharacter withDepth:depth])];
        [moves addObject:@(emptyIndex)];
    }
    
    int maxIndex = 0, minIndex = 0;
    int maxScore = INT_MIN, minScore = INT_MAX;
    
    if (character == self.aiCharacter) {
        for (int i = 0; i < [scores count]; i++) {
            int score = [[scores objectAtIndex:i] intValue];
            if (score > maxScore) {
                maxIndex = i;
                maxScore = score;
            }
        }
        
        int bestMove = [[moves objectAtIndex:maxIndex] intValue];
        int bestScore = [[scores objectAtIndex:maxIndex] intValue];
        self.bestMove = bestMove;
        
        return bestScore;
    } else {
        for (int i = 0; i < [scores count]; i++) {
            int score = [[scores objectAtIndex:i] intValue];
            if (score < minScore) {
                minIndex = i;
                minScore = score;
            }
        }
        
        int bestScore = [[scores objectAtIndex:minIndex] intValue];
        return bestScore;
    }
    
    return 0;
}

- (int)getScoreForBoard:(Board *)board withDepth:(int)depth {
    if ([board isLineWithCharacter:self.humanCharacter]) {
        return depth - 10;
    } else if ([board isLineWithCharacter:self.aiCharacter]) {
        return 10 - depth;
    }
    return 0;
}

@end
