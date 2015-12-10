//
//  ViewController.m
//  ToDo
//
//  Created by Mac on 03/12/15.
//  Copyright © 2015 mobileacademy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableArray* _data;
}

@end

@implementation ViewController

#pragma mark - UIViewController

- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    
    if( self ){
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _data = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"data"] mutableCopy];//[NSMutableArray arrayWithObjects:@"task1", @"task2", @"task3", @"task4", @"task5", nil];
        
        if( _data == nil ){
            _data = [NSMutableArray new];
        }
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

//selector definit in UITableViewDataSource
//este apelat de catre un table view iar selectorul este responsabil sa
//returneze cate randuri sunt intr-o sectiune data
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}

//selector definit in UITableViewDataSource
//este apelat pentru fiecare rand definiti conform tableView:numberOfRowsInSection
//cellIdentifier este folosit ca sa putem refolosi view-uri deja create
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellIdentifier = @"to-do-cell-index";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if( cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _data[ indexPath.row ];
    
    if( [[NSUserDefaults standardUserDefaults] boolForKey:_data[indexPath.row]] ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

//selector definit de protocolul UITableViewDelegate
//este apelat de catre un tableView in momentul in care se da tap pe unul dintre randurile sale
- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if( cell.accessoryType == UITableViewCellAccessoryCheckmark ){
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:_data[indexPath.row]];
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:_data[indexPath.row]];
    }
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - UITextFieldDelegate

//selector definit de protocolul UITextFiledDelegate
//apelat de catre un textField cand se apasa tasta enter
//este responsabilitate delegatului sa ascunda tastatura
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)buttonClicked:(UIButton *)sender {
    [self.textField resignFirstResponder];
    
    if( [self.textField.text  isEqual: @""] || self.textField.text == nil){
        return;
    }
    
    [_data addObject:self.textField.text];
    
    [[NSUserDefaults standardUserDefaults] setObject:_data forKey:@"data"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}

@end
