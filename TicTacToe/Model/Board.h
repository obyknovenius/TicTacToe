//
//  Board.h
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject

@property (nonatomic, readonly) int size;

- (instancetype)initWithSideLength:(int)sideLength;

- (void)clearBoard;

- (void)setCharacter:(char)character atIndex:(int)index;
- (char)characterAtIndex:(int)index;

- (NSArray *)emptyIndexes;

- (BOOL)isLineWithCharacter:(char)character;
    
@end
