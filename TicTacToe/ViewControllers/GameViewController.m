//
//  GameViewController.m
//  
//
//  Created by Vitaly Dyachkov on 04/08/15.
//
//

#import "GameViewController.h"

#import "Game.h"

@interface GameViewController () <GameResult>

@property (strong, nonatomic) Game *game;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;

@end

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.game = [[Game alloc] init];
    self.game.delegate = self;
    
    [self startNewGame];
}

- (void)startNewGame {
    for (UIButton *button in self.buttons) {
        [button setTitle:@"" forState:UIControlStateNormal];
    }
    [self.game restartGame];
}

- (IBAction)buttonTapped:(UIButton *)sender {
    char result = [self.game makeMoveToIndex:(int)sender.tag - 1];
    if (result == 'x') {
        [sender setTitle:@"👿" forState:UIControlStateNormal];
    } else if (result == 'o') {
        [sender setTitle:@"😇" forState:UIControlStateNormal];
    }
}

- (void)game:(Game *)game DidFinishWithResult:(GameResult)result {
    NSString *message = nil;
    if (result == GameResultPlayer1Win) {
        message = @"Player 1 Win";
    } else if (result == GameResultPlayer2Win) {
        message = @"Player 2 Win";
    } else {
        message = @"Tie";
    }
    
    UIAlertController *alertConroller = [UIAlertController alertControllerWithTitle:@"Game over" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Restart" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self startNewGame];
    }];
    [alertConroller addAction:restartAction];
    
    [self presentViewController:alertConroller animated:YES completion:nil];
}

@end
