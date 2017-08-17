//
//  LzsOtherViewController.m
//  SmallPig
//
//  Created by 李智帅 on 2017/6/21.
//  Copyright © 2017年 李智帅. All rights reserved.
//

#import "LzsOtherViewController.h"

@interface LzsOtherViewController ()

@end

@implementation LzsOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MAINCOLOR;
    [self createUI];
    // Do any additional setup after loading the view.
}
#pragma mark - createUI
- (void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_W, 44)];
    topView.backgroundColor = MAINCOLOR;
    [self.view addSubview:topView];
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    returnBtn.frame = CGRectMake(10, 5, 30, 30);
    [returnBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:returnBtn];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W/2-40, 7, 80, 30)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"设置";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:titleLabel];
    
    if ([self.titleStr isEqualToString:@"关于我们"]) {
        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10,74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
        textView.text =@"        唐山公路港致力于整合\"物流服务、物流载体和物流需求\"三大资源，为众多物流企业提供\"信息交易、商务配套和物业\"等系统服务，是\"物流平台整合运营商和综合服务提供商\"。\n        唐山公路港项目选址于北方现代物流城,G102（112）国道和丰津公路交叉口，规划占地747亩，规划建筑面积25万平方米。\n        其地理位置优越，交通便利，是连接东北、华北的重要通道。地处京、津、唐、秦腹地，西距北京120公里，西南距天津130公里，东距秦皇岛120公里，南距唐山中心区22.5公里，公路四通八达，G102、G112两条国道、丰津一级公路和京沈高速公路、津唐高速公路、唐山东外环高速公路、西外环高速公路在境内连接；铁路纵横交错，京秦、京山、唐遵三条铁路横跨城区，境内设有二级铁路货运编组站和三级铁路客运站；水路运输便利，距京唐港130公里，空运还可以对接境内的唐山机场，\"唐山公路港\"依托丰润的区位优势，建设成服务唐山、辐射京津冀区域物流的重大节点以及城市配送的综合枢纽。";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.textAlignment = NSTextAlignmentNatural;
        [self.view addSubview:textView];
    }else if ([self.titleStr isEqualToString:@"帮助中心"]){
        
        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
        textView.text =@"名称：唐山公路港物流有限公司\n邮编：064000\n联系电话：0315-5013061\n地址：河北省唐山市丰润区102国道与丰津公路交叉口西南角";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.textAlignment = NSTextAlignmentNatural;
        [self.view addSubview:textView];
    }else if ([self.titleStr isEqualToString:@"意见反馈"]){
        
        UITextView * textView = [[UITextView alloc]initWithFrame:CGRectMake(10, 74, SCREEN_W-20, SCREEN_H-60) textContainer:nil];
        textView.text =@"第1条 本平台服务条款的确认和接纳\n1.1本平台的各项电子服务的所有权和运作权归唐山公路港所有。用户同意所有注册协议条款并完成注册程序，才能成为本平台的正式用户。用户确认：本协议条款是处理双方权利义务的契约，始终有效，法律另有强制性规定或双方另有特别约定的，依其规定。\n1.2用户点击同意本协议的，即视为用户确认自己具有享受本平台服务、下单托运、下单承运等相应的权利能力和行为能力，能够独立承担法律责任。\n1.3如果用户在18周岁以下，用户只能在父母或监护人的监护参与下才能使用本平台。\n1.4根据中国法律、法规、行政规章成立并合法存在的机关、企事业单位、社团组织和其他组织，可以注册为用户。\n1.5唐山公路港保留在中华人民共和国大陆地区法施行之法律允许的范围内独自决定拒绝服务、关闭用户账户、清除或编辑内容或取消运单的权利。\n第2条 本平台服务\n2.1唐山公路港通过互联网依法为用户提供互联网信息等服务，用户在完全同意本协议及本平台规定的情况下，方有权使用本平台的相关服务。\n2.2用户必须自行准备如下设备和承担如下开支：\n（1）上网设备，包括并不限于电脑或者其他上网终端、调制解调器及其他必备的上网装置；\n（2）上网开支，包括并不限于网络接入费、上网设备租用费、手机流量费等。\n2.3本《协议》项下本公司对于用户所有的通知均可通过网页公告、电子邮件、手机短信或常规的信件传送等方式进行；该等通知于发送之日视为已送达收件人。\n2.4用户对于本公司的通知应当通过本公司对外正式公布的通信地址、传真号码、电子邮件地址等联系信息进行送达。该等通知以本公司实际收到日为送达日。\n2.5用户理解并同意，对于平台向用户提供的下列产品或者服务的质量缺陷本身及其引发的任何损失，平台无需承担任何责任：\n（1）本公司向用户免费提供的各项网络服务；\n（2）本公司向用户赠送的任何产品或者服务；\n（3）本公司向收费网络服务用户附赠的各种产品或者服务。\n2.6用户（特别是实际承运用户）理解安全驾驶的重要性，且保证在任何可能引起安全隐患的情况下均不得使用本平台，并同意一切因使用平台服务而导致的安全隐患和因此产生的纠纷和交通事故，平台概不负责赔偿。如有举证需要，平台可以向有关部门提供相关数据作为证据。\n第3条 用户信息\n3.1用户应自行诚信向本平台提供注册资料，不得以虚假、冒用的居民身份信息、企业注册信息、组织机构代码信息等进行注册。用户同意其提供的注册资料真实、准确、完整、合法有效，用户注册资料如有变动的，应及时更新其注册资料。如果用户提供的注册资料不合法、不真实、不准确、不详尽的，用户需承担因此引起的相应责任及后果，并且唐山公路港保留终止用户使用平台各项服务的权利。\n3.2用户在本平台进行浏览、下单托运、下单承运等活动时，涉及用户真实姓名/名称、通信地址、联系电话、电子邮箱等隐私信息的，本平台将予以严格保密，除非得到用户的授权或法律另有规定，本平台不会向外界披露用户隐私信息。\n3.3用户注册成功后，将产生用户名和密码等账户信息，用户可以根据本平台规定改变用户的密码。用户应谨慎合理的保存、使用其用户名和密码。用户若发现任何非法使用用户账号或存在安全漏洞的情况，请立即通知本平台并向公安机关报案。\n3.4用户同意，唐山公路港拥有通过邮件、短信电话等形式，向在本平台注册、托运用户、承运用户、收货人发送运单信息、促销活动等告知信息的权利。\n3.5用户不得将在本平台注册获得的账户借给他人使用，否则用户应承担由此产生的全部责任，并与实际使用人承担连带责任。\n3.6用户同意，唐山公路港有权使用用户的注册信息、用户名、密码等信息，登录进入用户的注册账户，进行证据保全，包括但不限于公证、见证等。\n3.7用户在使用平台时，应保证信息真实，诚信为本，禁止爽约、虚假单子、恶意抢单等行为，一经发现，平台有权停止用户账号，并可视情节严重性，追究其法律责任。\n3.8如用户注册的免费网络服务的账号在任何连续90日内未实际使用，或者用户注册的收费网络服务的账号在其订购的收费网络服务的服务期满之后连续180日内未实际使用，则本公司有权删除该账号并停止为该用户提供相关的网络服务。在执行账号删除之前，本公司会向该用户发送通知。\n第4条 用户依法言行义务\n本协议依据国家相关法律法规规章制定，用户同意严格遵守以下义务：\n（1）不得传输或发表：煽动抗拒、破坏宪法和法律、行政法规实施的言论，煽动颠覆国家政权，推翻社会主义制度的言论，煽动分裂国家、破坏国家统一的的言论，煽动民族仇恨、民族歧视、破坏民族团结的言论；\n（2）从中国大陆向境外传输资料信息时必须符合中国有关法规；\n（3）不得利用本平台从事洗钱、窃取商业秘密、窃取个人信息等违法犯罪活动；\n（4）不得干扰本平台的正常运转，不得侵入本平台及国家计算机信息系统；\n（5）不得传输或发表任何违法犯罪的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、伤害性的、庸俗的，淫秽的、不文明的等信息资料；\n（6）不得传输或发表损害国家社会公共利益和涉及国家安全的信息资料或言论；\n（7）不得教唆他人从事本条所禁止的行为；\n（8）不得利用在本平台注册的账户进行牟利性经营活动；\n（9）不得发布任何侵犯他人著作权、商标权等知识产权或合法权利的内容；用户应不时关注并遵守本平台不时公布或修改的各类合法规则规定。\n本平台保有删除平台内各类不符合法律政策或不真实的信息内容而无须通知用户的权利。\n若用户未遵守以上规定的，本平台有权作出独立判断并采取暂停或关闭用户账号等措施。用户须对自己在网上的言论和行为承担法律责任。\n第5条 下单托运\n5.1用户注册成为发货公司、配货站和个体车主时有权下单托运，作为托运人。\n5.2用户托运的货物必须是自有物品或有合法来源。倘若托运的货物名称、数量、性质与实际委托托运的货物名称、数量、性质不符，或属禁运物品的，导致在运输过程中发生被执法部门查扣、罚款等情形的，其法律责任由用户自负。由于在货物中夹带、匿报危险货物，而招致货物破损、爆炸，造成人身伤亡的，用户应承担由此造成的一切责任；\n5.3用户托运的货物按国家或者地方法律法规规定需要包装的，应当按规定的标准包装。没有统一包装标准的，应根据保证货物运输安全和有利于实现合同目的的原则进行包装。否则，因此造成的经济损失由用户自负。由于货物包装缺陷产生破损，致使其他货物或运输工具、机械设备被污染腐蚀、损坏，造成人身伤亡的，用户应承担赔偿责任；\n5.4请用户在托运询价时，正确选择和输入所需要托运的货物名称、规格型号、品牌/厂家、运输数量、产品数量、包装数量、计量单位、发货地点及详细地址、发货人联系人及联系方式、收货地点及详细地址、收货人联系人及联系方式等信息。系统依据用户选择和输入的信息生成托运询价单。系统生成的托运询价单，仅是用户向平台发出的交易诉求。收货人联系人与用户本人不一致的，收货人联系人的行为和意思表示视为用户的行为和意思表示，用户应对收货人联系人的行为及意思表示的法律后果承担连带责任。\n5.5平台接到用户的托运询价单后，为用户报价。当用户接受报价后，系统依据托运询价单信息和接受报价的询价生成托运运单。在托运运单生成后，平台将为用户派车，系统依据托运运单和平台派车信息生成发货单中的派车信息。系统生成的托运运单、发货单中的派车信息，仅是用户与平台确认的交易意向。\n5.6除法律另有强制性规定外，双方约定只有在平台派遣车辆从用户的指定地点提货后，方视为用户与平台之间就实际向用户提供的运输服务建立了交易关系，建立交易关系的运输服务仅限于平台实际向用户提供的运输服务货物和数量；如果平台实际向用户提供的运输服务货物和/或数量多于或少于用户托运的货物和/或数量，用户与平台之间仅就平台实际向用户提供的运输服务货物和数量建立了交易关系。用户可以随时登录用户在本平台注册的账户，查询用户自己的运单状态。\n5.7由于市场变化及各种以合理商业努力难以控制的因素的影响，本平台无法保证用户与平台在托运运单中的运价能够一直维持不变，如果平台需要调价，用户有权同意或拒绝，在用户同意后平台按照新的运价执行运单，否则用户有权通知平台停止该运单后续运输服务，但不能免除用户对实际提供运输服务货物和数量的结算义务和其他约定义务。\n5.8平台将会派车前往用户指定的提货地点提货，并运输到用户指定的收货地点。用户应仔细核对提货交货车辆的车牌号码、司机的姓名和身份证号码与派车车辆信息是否一致。因用户误认车辆导致错装的，平台免责并不承担损失。\n5.9所有在本平台上列出的派车时间是平台通知实际承运车主根据用户的提货时间要求估计得出的；所有在本平台上列出的发货时间、交货时间是平台通知实际承运车主根据用户及用户指定的业务联系单位开具单据的时间而得出的；在用户及用户指定的业务联系单位没有开具单据时，对应运单在本平台上列出的发货时间、交货时间时实际承运车主根据实际发生时间估算得出的。\n5.10完成装卸货后，用户有义务为实际承运车辆开具具有法律效力且注明所承运货物详细清单的出入库或货物交接凭证。\n5.11平台在力所能及的范围内为用户提供服务，减少用户的经济损失。如因以下情况引起用户损失，用户应当面要求承运车辆签字确认并及时告知平台工作人员，平台将与用户协商并协调赔付事宜：\n（1）因实际承运人及其实际承运车辆原因造成的财产损失；\n（2）因实际承运人及其实际承运车辆原因造成的货物损失；\n（3）因实际承运人及其实际承运车辆原因在用户及其指定单位发生的人员伤亡；\n（4）因实际承运人及其实际承运车辆因违反相关法律法规造成交货不及时。\n5.12因下列原因造成的损失，平台不承担赔偿责任：\n（1）属于政府征用或罚没的；\n（2）不可抗力；\n（3）货物本身的性质所引起的变质、减量、破坏或毁灭；\n（4）用户负责包装，但包装方式或容器不良造成的损失；\n（5）包装完整、标志无异状，而内件短少；\n（6）货物的合理损耗；\n（7）用户及用户指定收货单位/人的过错。\n5.13因如下情况造成平台无法提货、交货等，平台不承担延迟提货、交货的责任，同时用户应赔偿实际承运车辆的损失并承担相应的违约金和责任。\n（1）用户提供的信息错误、地址不详细或改变提货地点、交货地点等原因导致的；\n（2）平台指定运输车辆到达后，用户拒绝为其提货或收货及/或无人协调提货或收货，导致无法履行或延迟履行运输服务的。\n（3）约定由用户装卸货物时，用户及其代表野蛮装卸经承运车辆指出，用户及其代表未及时更改造成损失的。\n第6条 下单承运\n6.1用户注册成为车主账户时有权下单托运，作为实际承运人。\n6.2用户拥有道路运输经营许可证，用户承运车辆拥有车辆营运证并通过相关各类审核和授权，用户指派的驾驶员拥有合规有效的驾驶证且不违反相关法律法规。若用户及其投入的承运车辆、承运司机在运输过程中发生被执法部门查扣、罚款等情形的，其法律责任由用户自负。\n6.3要求用户提供货物包装的，应根据保证货物运输安全和有利于实现合同目的的原则进行包装。否则，因此造成的经济损失由用户自负。由于货物包装缺陷产生破损，致使其他货物或运输工具、机械设备被污染腐蚀、损坏，造成人身伤亡的，用户应承担赔偿责任；\n6.4请用户在承运报价时，正确选择在线货源和输入用户的运价报价等信息。系统依据用户选择和输入的信息生成承运报价单。系统生成的承运报价单，仅是用户向平台发出的交易诉求。\n6.5平台接到用户的报价单后，决定是否接受用户的报价。当平台接受用户的报价后，系统依据在线货源信息和接受报价的运价生成承运运单。在承运运单生成后，平台将通知用户派车，用户具体创建发货单并填写派车信息。系统生成的承运运单、发货单中的派车信息，仅是用户与平台确认的交易意向。\n6.6除法律另有强制性规定、用户与平台签订合同另外约定外，双方约定只有用户的派遣车辆从平台指定地点提货完毕后，方视为用户与平台之间就建立了交易关系，建立交易关系的运输服务仅限于用户实际向平台提供的运输服务货物和数量；如果用户实际向平台提供的运输服务货物和/或数量多于或少于平台托运的货物和/或数量，用户与平台之间仅就用户实际向平台提供的运输服务货物和数量建立了交易关系。用户可以随时登录用户在本平台注册的账户，查询用户的运单状态。\n6.7由于市场变化及各种以合理商业努力难以控制的因素的影响，本平台无法保证用户与平台在承运运单中的运价能够一直维持不变，如果平台需要调价，用户有权同意或拒绝，在用户同意后平台按照新的运价执行运单，否则用户有权通知平台停止该运单后续运输服务。\n6.8接到平台通知后，用户实际派车前往平台指定的提货地点提货，并运输到平台指定的收货地点。所有在本平台上列出的要求提货时间、要求派车时间、要求交货时间是平台根据实际货主托运要求估计得出的；所有在本平台上列出的发货时间、交货时间是用户根据实际货主及其指定的业务联系单位或个人开具单据的时间而输入的；在实际货主及其指定的业务联系单位或个人没有开具单据时，你在对应运单的发货时间和数量、交货时间和数量等项目应输入实际发生时间和数量等信息，并得到实际货主及其指定的业务联系单位或个人的同意。\n6.9完成装卸货后，用户有义务向实际托运货主索要具有法律效力且注明所托运货物详细清单的出入库或货物交接凭证。\n6.10平台在力所能及的范围内为用户提供服务，减少用户的经济损失。如因以下情况引起用户损失，用户应当面要求实际托运货主签字确认并及时告知平台工作人员，平台将与用户协商并协调赔付事宜：\n（1）因实际托运货主原因导致平台提供的信息错误、地址不详细或改变提货地点、交货地点等原因导致的；\n（2）因实际托运货主原因导致用户的运输车辆到达后，实际货主拒绝为其提货或收货及/或无人协调提货或收货，导致无法履行或延迟履行运输服务的。\n（3）约定由实际托运货主装卸货物时，实际托运货主及其代表野蛮装卸经用户指出，用户及其代表未及时更改造成损失的。6.11因下列原因造成的损失，平台不承担赔偿责任，由用户自行承担：\n（1）不可抗力导致损失；\n（2）实际承运人及其实际承运车辆的过错及其造成的损失\n（3）实际承运人及其实际承运车辆的交通事故、交通违章。\n第7条 所有权及知识产权条款\n7.1用户一旦接受本协议，即表明该用户主动将其在任何时间段在本平台发表的任何形式的信息内容（包括但不限于客户评价、客户咨询、各类话题文章等信息内容）的财产性权利等任何可转让的权利，如著作权财产权（包括并不限于：复制权、发行权、出租权、展览权、表演权、放映权、广播权、信息网络传播权、摄制权、改编权、翻译权、汇编权以及应当由著作权人享有的其他可转让权利），全部独家且不可撤销地转让给唐山公路港所有，用户同意唐山公路港有权就任何主体侵权而单独提起诉讼。\n7.2本协议已经构成《中华人民共和国著作权法》第二十五条（条文序号依照2011年版著作权法确定）及相关法律规定的著作财产权等权利转让书面协议，其效力及于用户在平台上发布的任何受著作权法保护的作品内容，无论该等内容形成于本协议订立前还是本协议订立后。\n7.3用户同意并已充分了解本协议的条款，承诺不将已发表于本平台的信息，以任何形式发布或授权其它主体以任何方式使用（包括但不限于在各类网平台、媒体上使用）。\n7.4唐山公路港是本平台的制作者,拥有本平台内容及资源的著作权等合法权利,受国家法律保护,有权不时地对本协议及本平台的内容进行修改，并在本平台张贴，无须另行通知用户。在法律允许的最大限度范围内，唐山公路港对本协议及本平台内容拥有解释权。\n7.5除法律另有强制性规定外，未经唐山公路港明确的特别书面许可,任何单位或个人不得以任何方式非法地全部或部分复制、转载、引用、链接、抓取或以其他方式使用本平台的信息内容，否则，唐山公路港有权追究其法律责任。\n7.6本平台所刊登的资料信息（诸如文字、图表、标识、按钮图标、图像、声音文件片段、数字下载、数据编辑和软件），均是唐山公路港或其内容提供者的财产，受中国和国际版权法的保护。本平台上所有内容的汇编是唐山公路港的排他财产，受中国和国际版权法的保护。本平台上所有软件都是唐山公路港或其关联公司或其软件供应商的财产，受中国和国际版权法的保护。\n第8条 责任限制及不承诺担保\n8.1除非另有明确的书面说明,本平台及其所包含的或以其它方式通过本平台提供给用户的全部信息、内容、材料、产品（包括软件）和服务，均是在“按现状”和“按现有”的基础上提供的。\n8.2除非另有明确的书面说明,唐山公路港不对本平台的运营及其包含在本网平台上的信息、内容、材料、产品（包括软件）或服务作任何形式的、明示或默示的声明或担保（根据中华人民共和国法律另有规定的以外）。\n8.3唐山公路港不担保本平台所包含的或以其它方式通过本平台提供给用户的全部信息、内容、材料、产品（包括软件）和服务、其服务器或从本平台发出的电子信件、信息没有病毒或其他有害成分。\n8.4如因不可抗力或其它本平台无法控制的原因使本平台系统崩溃或无法正常使用导致网上交易无法完成或丢失有关的信息、记录等，唐山公路港会合理地尽力协助处理善后事宜。\n第9条 协议更新及用户关注义务\n9.1根据国家法律法规变化及网平台运营需要，唐山公路港有权对本协议条款不时地进行修改，修改后的协议一旦被张贴在本平台上即生效，并代替原来的协议。用户可随时登录查阅最新协议；用户有义务不时关注并阅读最新版的协议及网平台公告。如用户不同意更新后的协议，可以且应立即停止接受平台依据本协议提供的服务；如用户继续使用本网平台提供的服务的，即视为同意更新后的协议。唐山公路港建议用户在使用本平台之前阅读本协议及本平台的公告。 如果本协议中任何一条被视为废止、无效或因任何理由不可执行，该条应视为可分的且并不影响任何其余条款的有效性和可执行性。\n第10条 法律管辖和适用\n10.1本协议的订立、执行和解释及争议的解决均应适用在中华人民共和国大陆地区适用之有效法律（但不包括其冲突法规则）。 如发生本协议与适用之法律相抵触时，则这些条款将完全按法律规定重新解释，而其它有效条款继续有效。 如缔约方就本协议内容或其执行发生任何争议，双方应尽力友好协商解决；协商不成时，任何一方均可向中华人民共和国河北省唐山市丰南区法院提起诉讼。\n第11条 其他\n11.1平台所有者是唐山公路港，指在政府部门依法许可或备案的平台经营主体。\n11.2唐山公路港尊重用户和消费者的合法权利，本协议及本网平台上发布的各类规则、声明等其他内容，均是为了更好的、更加便利的为用户和消费者提供服务。本平台欢迎用户和社会各界提出意见和建议，唐山公路港将虚心接受并适时修改本协议及本平台上的各类规则。\n11.3本协议构成双方对本协议之约定事项及其他有关事宜的完整协议，除本协议规定的之外，未赋予本协议各方其他权利。\n11.4如本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，本协议的其余条款仍应有效并且有约束力。\n11.5用户选择本协议下方的“同意”按钮即视为用户完全接受本协议，在点击之前请用户再次确认已知悉并完全理解本协议的全部内容。\n";
        textView.textColor = [UIColor blackColor];
        textView.font = [UIFont systemFontOfSize:15];
        textView.textAlignment = NSTextAlignmentNatural;
        [self.view addSubview:textView];
    }
    
    
}
- (void)returnClick{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end