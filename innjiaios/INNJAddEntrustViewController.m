//
//  INNJAddEntrustViewController.m
//  innjiaios
//
//  Created by wl on 14-11-14.
//  Copyright (c) 2014年 wl. All rights reserved.
//

#import "INNJAddEntrustViewController.h"
#import "INNJEntrustView.h"
@interface INNJAddEntrustViewController ()
@property (nonatomic,strong) UIScrollView *scrollview;
@property (nonatomic,strong) INNJEntrustView *entrustview ;
@end

@implementation INNJAddEntrustViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.topoffset, self.view.width, self.view.height - self.topoffset-self.bottomoffset)];
    [self.view addSubview:_scrollview];
    self.entrustview = [INNJEntrustView getView];
    [_scrollview addSubview:self.entrustview];
    _scrollview.contentSize = CGSizeMake(self.entrustview.width, self.entrustview.height);
    self.navigationItem.title = @"委托找房";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
