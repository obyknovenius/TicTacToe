//
//  AI.h
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Board;

@interface AI : NSObject

- (instancetype)initWithBoard:(Board *)board aiCharacter:(char)aiCharacter humanCharacter:(char)humanCharacter;

- (int)nextMove;

@end
