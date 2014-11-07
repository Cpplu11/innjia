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
       
        
        
        
    }
   
}
-(void)viewDidAppear:(BOOL)animated
{
   
    if(self.navigationController)
        self.navigationController.navigationItem.title = self.title;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
