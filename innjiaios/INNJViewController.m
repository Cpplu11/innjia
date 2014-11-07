//
//  INNJViewController.m
//  innjiaios
//
//  Created by wl on 14-11-5.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJViewController.h"

@interface INNJViewController ()

@end

@implementation INNJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(self.navigationController)
    {
        //9c,c8,36
        [self.navigationController navigationBar].tintColor = [UIColor colorWithRed:156/255.0 green:200/255.0 blue:54/255.0 alpha:1.0];
       [self.navigationController navigationBar].backgroundColor = [UIColor colorWithRed:156/255.0 green:200/255.0 blue:54/255.0 alpha:1.0];
     
        
    }
   
}
-(void)viewDidAppear:(BOOL)animated
{
    if(self.navigationController)
        self.navigationController.title = self.title;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
