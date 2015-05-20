//
//  ViewController.m
//  PWInfiniteScrollView
//
//  Created by Tony_Zhao on 5/2/15.
//  Copyright (c) 2015 TonyZPW. All rights reserved.
//

#import "ViewController.h"
#import "PWInfiniteScrollView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        NSArray *dataSource = @[
                                [UIImage imageNamed:@"00.jpg"],
                                [UIImage imageNamed:@"01.jpg"],
                                [UIImage imageNamed:@"02.jpg"],
                                [UIImage imageNamed:@"03.jpg"]
                                ];
       
    
    PWInfiniteScrollView *infiniteScrollView = [[PWInfiniteScrollView alloc] initWithFrame:self.view.bounds Images:dataSource itemSize:CGSizeMake(100, 100) linespacing:0 Auto:NO];
    
    [self.view addSubview:infiniteScrollView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
