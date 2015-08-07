//
//  GameViewController.m
//  
//
//  Created by Vitaly Dyachkov on 04/08/15.
//
//

#import "GameViewController.h"

#import "Game.h"
#import "AI.h"

@interface GameViewController ()

@property (strong, nonatomic) Game *game;
@property (strong, nonatomic) AI *ai;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[Game alloc] initWithBoardSideLength:3];
    
    if (self.isComputerPlay) {
        char aiCharacter, humanCharacter;
        if (self.isComputerFirst) {
            aiCharacter = self.game.player1Character;
            humanCharacter = self.game.player2Character;
        } else {
            humanCharacter = self.game.player1Character;
            aiCharacter = self.game.player2Character;
        }
        self.ai = [[AI alloc] initWithBoard:self.game.board
                                aiCharacter:aiCharacter
                             humanCharacter:humanCharacter];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self startNewGame];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.isComputerPlay && self.isComputerFirst) {
        [self makeAIMove];
    }
}

- (void)startNewGame {
    for (UIButton *button in self.buttons) {
        [button setTitle:@"" forState:UIControlStateNormal];
        button.enabled = YES;
    }
    [self.game restartGame];
}

- (IBAction)buttonTapped:(UIButton *)sender {
    int senderIndex = (int)sender.tag - 1;
    
    char character = [self.game makeMoveToIndex:senderIndex];
    [self updateButtonAtIndex:senderIndex character:character];
    
    if (![self isGameOver]) {
        if (self.isComputerPlay) [self makeAIMove];
    } else {
        for (UIButton *button in self.buttons) {
            button.enabled = NO;
        }
    }
}

- (void)makeAIMove {
    int aiMove = [self.ai nextMove];
    char character = [self.game makeMoveToIndex:aiMove];
    [self updateButtonAtIndex:aiMove character:character];
    
    if ([self isGameOver]) {
        for (UIButton *button in self.buttons) {
            button.enabled = NO;
        }
    }
}

- (void)updateButtonAtIndex:(int)index character:(char)character {
    UIButton *button = (UIButton *)[self.view viewWithTag:index + 1];
    
    if (character == self.game.player1Character) {
        [button setTitle:@"👿" forState:UIControlStateNormal];
    } else if (character == self.game.player2Character) {
        [button setTitle:@"😇" forState:UIControlStateNormal];
    }
}

- (BOOL)isGameOver {
    GameResult result = [self.game gameResult];
    if (result == GameResultNone) {
        return NO;
    }
    
    [self performSelector:@selector(showGameOverAlertMessage:) withObject:@(result) afterDelay:0.5];
    
    return YES;
}

- (void)showGameOverAlertMessage:(NSNumber *)result {
    GameResult uwrappedResult = [result unsignedIntegerValue];
    
    NSString *message = nil;
    if (uwrappedResult == GameResultPlayer1Win) {
        message = (self.isComputerPlay && self.isComputerFirst) ? @"Computer Win" : @"Player 1 Win";
    } else if (uwrappedResult == GameResultPlayer2Win) {
        message = (self.isComputerPlay && !self.isComputerFirst) ? @"Computer Win" : @"Player 2 Win" ;
    } else {
        message = @"It's a tie!";
    }
    
    UIAlertController *alertConroller = [UIAlertController alertControllerWithTitle:@"Game over" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Restart" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startNewGame];
        
        if (self.isComputerPlay && self.isComputerFirst) {
            [self makeAIMove];
        }
    }];
    [alertConroller addAction:restartAction];
    
    [self presentViewController:alertConroller animated:YES completion:nil];
}

@end
