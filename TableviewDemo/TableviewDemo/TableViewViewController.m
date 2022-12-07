//
//  TableViewViewController.m
//  TableviewDemo
//
//  Created by DeerClass on 2022/9/8.
//  https://juejin.cn/post/6844904177382981640

#import "TableViewViewController.h"
#import "TableViewHeaderFooterView.h"
#import "TableViewCell2.h"

@interface TableViewViewController () <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 所有分类的数组
@property (strong,nonatomic) NSArray *_sectionTitles;
// 内容数组
@property (strong,nonatomic) NSArray<NSArray *> *contentArray;



@end

@implementation TableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    // Do any additional setup after loading the view from its nib.
    
    self._sectionTitles  = [[NSArray alloc] initWithObjects:
                                @"A",@"C",@"F",@"G",@"H",@"M",@"S",@"T",@"X",@"Z", nil];
        //    初始化具体内容的数据
        self.contentArray  = [[NSArray alloc] initWithObjects:
                              @[@"阿伟",@"阿姨",@"阿三"],
                              @[@"蔡芯",@"成龙",@"陈鑫",@"陈丹",@"成名"],
                              @[@"芳仔",@"房祖名",@"方大同",@"芳芳",@"范伟"],
                              @[@"郭靖",@"郭美美",@"过儿",@"过山车"],
                              @[@"何仙姑",@"和珅",@"郝歌",@"好人"],
                              @[@"妈妈",@"毛不易"],
                              @[@"孙周",@"沈冰",@"婶婶"],
                              @[@"涛涛",@"淘宝",@"套娃"],
                              @[@"小二",@"夏紫薇",@"许巍",@"许晴"],
                             @[@"周扒皮",@"周杰伦",@"张柏芝",@"张大仙"],nil];
    

    
//    //headerview
    UILabel *lbl = [[UILabel alloc] init];
    lbl.font = [UIFont systemFontOfSize:25.0];
    lbl.text = @"tableview头部视图";
    [lbl sizeToFit];
    _tableView.tableHeaderView =lbl;
//
//    //footerview
    lbl = [[UILabel alloc] init];
    lbl.font = [UIFont systemFontOfSize:25.0];
    lbl.text = @"tableview底部视图";
    [lbl sizeToFit];
    _tableView.tableFooterView =lbl;
    
    ///1、设置数据源代理
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    ///2、给tableview注册cell类（cell里包含可视编辑xib）
    [_tableView registerNib: [UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    
    ///给tableview注册cell类（cell是全代码实现方式）
    //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    
    
    ///给tableview注册HeaderFooterView的类
//    [_tableView registerClass:TableViewHeaderFooterView.class forHeaderFooterViewReuseIdentifier:@"headerFooterId"];
    
    
}

// 设置列表一共有多少个分组（可以不用实现这个代理，默认是1组）
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self._sectionTitles.count;
}
// 设置每一个分组对应有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contentArray[section].count;
}
// 返回每一行的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"需要展示%ld组----第%ld个数据",indexPath.section,indexPath.row);
    ///通过Identifier获取缓存池里的cell，如果缓存池里没有则会创建新的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text=[NSString stringWithFormat:@"%@         第%d第%d个数据",self.contentArray[indexPath.section][indexPath.row],indexPath.section,indexPath.row];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *view = [UILabel new];
    view.text =self._sectionTitles[section];
    view.backgroundColor = UIColor.redColor;
    view.textColor = UIColor.whiteColor;
//    TableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerFooterId"];
//    view.lbl.text = self._sectionTitles[section];
//    [view.lbl sizeToFit];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}


//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
////    UILabel *view = [UILabel new];
////    view.text = @"我是section尾巴";
////    view.backgroundColor = UIColor.blueColor;
//
//    TableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerFooterId"];
//    view.lbl.text = @"我是section尾巴";
//    [view.lbl sizeToFit];
//
//    return view;
//}

//// 返回每一个分类的具体内容
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return  self._sectionTitles[section];
//}
//
/////点击cell回调
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"点击里第几行:%ld",indexPath.row);
//}






@end
