//
//  Board.m
//  TicTacToe
//
//  Created by Vitaly Dyachkov on 06.08.15.
//  Copyright (c) 2015 Vitaly Dyachkov. All rights reserved.
//

#import "Board.h"

@interface Board () <NSCopying>

@property (nonatomic) int sideLength;
@property (nonatomic) char *matrix;

@end

@implementation Board

- (instancetype)initWithSideLength:(int)sideLength {
    self = [super init];
    if (self) {
        _sideLength = sideLength;
        _matrix = malloc(sizeof(char) * sideLength * sideLength);
        memset(_matrix, ' ', sizeof(char) * sideLength * sideLength);
    }
    return self;
}

- (void)dealloc {
    free(_matrix);
}

- (int)size {
    return self.sideLength * self.sideLength;
}

- (void)clearBoard {
    memset(self.matrix, ' ', sizeof(char) * self.size);
}

- (void)setCharacter:(char)character atIndex:(int)index {
    self.matrix[index] = character;
}

- (char)characterAtIndex:(int)index {
    return self.matrix[index];
}

- (NSArray *)emptyIndexes {
    NSMutableArray *emptyIndexes = [[NSMutableArray alloc] initWithCapacity:self.size];
    for (int i = 0; i < self.size; i++) {
        if (self.matrix[i] == ' ') {
            [emptyIndexes addObject:@(i)];
        }
    }
    return [emptyIndexes copy];
}

- (BOOL)isHorizontalWinWithCharacter:(char)character {
    int sum = 0;
    
    for (int i = 0; i < self.sideLength; i++) {
        for (int j = 0; j < self.sideLength; j++) {
            if (self.matrix[i * self.sideLength + j] == character) sum++;
        }
        if (sum == self.sideLength) return YES;
        sum = 0;
    }
    
    return NO;
}

- (BOOL)isVerticalWinWithCharacter:(char)character {
    int sum = 0;
    
    for (int i = 0; i < self.sideLength; i++) {
        for (int j = 0; j < self.sideLength; j++) {
            if (self.matrix[j * self.sideLength + i] == character) sum++;
        }
        if (sum == self.sideLength) return YES;
        sum = 0;
    }
    
    return NO;
}

- (BOOL)isDiagonalWinWithCharacter:(char)character {
    int sum = 0;
    for (int i = 0; i < self.sideLength; i++) {
        if (self.matrix[i * self.sideLength + i] == character) sum++;
    }
    if (sum == self.sideLength) return YES;
    
    sum = 0;
    for (int i = 0; i < self.sideLength; i++) {
        if (self.matrix[i * self.sideLength + (self.sideLength - 1) - i] == character) sum++;
    }
    if (sum == self.sideLength) return YES;
    
    return NO;
}

- (BOOL)isLineWithCharacter:(char)character {
    return [self isHorizontalWinWithCharacter:character] ||
    [self isVerticalWinWithCharacter:character] ||
    [self isDiagonalWinWithCharacter:character];
}

- (NSString *)description
{
    NSMutableString *matrixString = [[NSMutableString alloc] initWithString:@"\n"];
    for (int i = 0; i < self.sideLength; i++) {
        NSData *matrixData = [NSData dataWithBytes:self.matrix + i * self.sideLength length:sizeof(char) * self.sideLength];
        [matrixString appendString:[NSString stringWithFormat:@"%@\n", [[NSString alloc] initWithData:matrixData encoding:NSUTF8StringEncoding]]];
    }
    
    return [NSString stringWithFormat:@"<%@: %p,%@>",
            NSStringFromClass([self class]), self, matrixString];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    Board *copy = [[[self class] alloc] initWithSideLength:self.sideLength];
    
    if (copy) {
        memcpy(copy.matrix, self.matrix, sizeof(char) * self.size);
    }
    
    return copy;
}

@end
