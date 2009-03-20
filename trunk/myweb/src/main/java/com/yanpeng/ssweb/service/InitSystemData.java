package com.yanpeng.ssweb.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.ssweb.entity.Permissions;
import com.yanpeng.ssweb.service.permission.PermissionManager;
import com.yanpeng.ssweb.service.security.resource.SecurityResourceCache;
import com.yanpeng.ssweb.service.user.UserManager;


@SuppressWarnings("unused")
public class InitSystemData {


	@Autowired
	private PermissionManager permissionManager;
	
	private boolean isRun;

	public void init() throws Exception {
		if (isRun) {//每次启动内存库为true
//			initResource();
//			initRole();
//			initUser();
//			initNews();
		}else{//如果是普通数据库，需要初始化资源缓存
			initCache();
		}
	}
	
	public void initCache(){
		List<Permissions> pers=permissionManager.getAllPermissions();
		for(Permissions r:pers){
			SecurityResourceCache.putCache(r);
		}
	}

//	public void initUser() throws Exception {
//		List<Role> roles = new ArrayList<Role>();
//		Role role=new Role();
//		role.setId(new Long(1));
//		roles.add(role);
//		role=new Role();
//		role.setId(new Long(2));
//		roles.add(role);
//		User user = new User();
//		// =====1===============
//		user.setUsername("admin");
//		user.setCnname("超级管理员");
//		user.setEmail("caoyangx@126.com");
//		user.setPassword("admin");
//		user.setRoles(roles);
//		userService.saveUser(user);
//		// =====2===============
//		user = new User();
//		user.setUsername("user");
//		user.setCnname("用户");
//		user.setEmail("caoyangx@126.com");
//		user.setPassword("user");
//		roles.clear();
//		role=new Role();
//		role.setId(new Long(2));
//		roles.add(role);
//		user.setRoles(roles);
//		userService.saveUser(user);
//	}
//
//	public void initRole() throws Exception {
//		List<Resource> aus = new ArrayList<Resource>();
//		Role role = new Role();
//		role.setName("ADMIN");
//		role.setCnname("管理员");
//		Resource au=new Resource();
//		au.setId(new Long(1));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(2));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(3));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(4));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(5));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(6));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(7));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(8));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(9));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(10));
//		aus.add(au);
//		role.setResources(aus);
//		userService.saveRole(role);
//		// ======1==============
//		role = new Role();
//		role.setName("USER");
//		role.setCnname("普通用户");
//		aus.clear();
//		au=new Resource();
//		au.setId(new Long(3));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(6));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(7));
//		aus.add(au);
//		au=new Resource();
//		au.setId(new Long(10));
//		aus.add(au);
//		role.setResources(aus);
//		userService.saveRole(role);
//		// =====2==============
//	}
//
//	public void initResource() throws Exception {
//		Resource r=new Resource();
//		r.setPath("/system/user!save.action*");
//		r.setName("RES_SAVE_USER");
//		r.setCnname("保存用户");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/user!delete.action*");
//		r.setName("RES_REMOVE_USER");
//		r.setCnname("删除用户");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/user.action*");
//		r.setName("RES_VIEW_USER");
//		r.setCnname("查看用户");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/role!save.action*");
//		r.setName("RES_SAVE_ROLE");
//		r.setCnname("保存角色");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/role!delete.action*");
//		r.setName("RES_REMOVE_ROLE");
//		r.setCnname("删除角色");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/role.action*");
//		r.setName("RES_VIEW_ROLE");
//		r.setCnname("查看角色");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/resource.action*");
//		r.setName("RES_VIEW_RESOURCE");
//		r.setCnname("查看资源");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/resource!save.action*");
//		r.setName("RES_SAVE_RESOURCE");
//		r.setCnname("保存资源");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/system/resource!delete.action*");
//		r.setName("RES_REMOVE_RESOURCE");
//		r.setCnname("删除资源");
//		userService.saveResource(r);
//		//=================================
//		r=new Resource();
//		r.setPath("/demo/**");
//		r.setName("RES_ALL_DEMO");
//		r.setCnname("演示功能");
//		userService.saveResource(r);
//		//=================================
//	}
//
//	public void initNews() throws Exception {
//		News news=new News();
//		news.setTitle("两人恋情让人看花眼");
//		news.setAuth("abc");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setPicture("demo.gif");
//		news.setContent("正当有关倪震、周慧敏和张茆三人的新闻看花眼的时候，倪震和周慧敏的恋情又千回百转柳暗花明。倪震向传媒发出电邮，电子邮件以“囍final”为文件名称发出声明，证实与周慧敏的婚事，倪震向香港媒体发表声明表示，经历“偷欢门”想明白，将跟周慧敏结婚，宣布已与周慧敏申请注册结婚。");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("奥巴马在战争态度上继承布什");
//		news.setContent("奥巴马开始了他的第一个工作日，中东问题是他的当天工作核心。全世界都在等着奥巴马有所改变。在战争态度上，很遗憾，反对伊拉克战争的奥巴马是布什的继承人。这位新总统打着电话的工作照毫无新意，这样的照片遍布全世界，他的战争态度更为沉旧。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("元宵节花卉价格回落一成半");
//		news.setContent("元宵节是春节后第一个比较大的节日，记者获悉，元宵节前花卉市场又迎来了一个销售小高峰，虽然比春节前逊色不少，但花卉批发市场一个摊位一天也能卖出300棵左右的鲜花。但受成本、运输、气温等因素影响，元宵节前本市花卉批发价格普遍下调15%左右。 在本市最大的鲜花集散地花乡，记者走访了几家大型花卉批发市场。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("支持多一点民俗的节日");
//		news.setContent("核心提示：“多一点民俗的节日。”市人大代表薄海豹对于元宵节放假持赞同态度。他认为，元宵节是农历新年后的第一个月圆时，人们团圆欢庆，民俗活动众多。薄海豹代表介绍说，他在英国留学时就发现英国当地的民俗节日可以用繁多来形容。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("美国经济刺激计划10日在参议院过会");
//		news.setContent("当地时间10日,美国参议院将就“参院版”经济刺激计划进行投票。上周五,参院民主、共和两党关键议员就奥巴马的经济刺激方案达成临时协议,将该计划的规模定为7800亿美元,削减了民主党人支持的教育和医疗项目救助。 ");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("取消文理分科不宜操之过急");
//		news.setContent("2月8日报道，《国家中长期教育改革和发展规划纲要》就20个教育问题征集意见，其中包括高中取消文理分科的必要性和可能性，引起舆论广泛关注。 其实，文理分科不仅普通民众关注，高度重视教育的温总理也不断投来关注的目光。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("部分地区粮食价格上涨");
//		news.setContent("新华网北京２月８日电（记者王晓玲）据新华社全国农副产品和农资价格行情系统监测，与前一日相比（下同），２月８日，受国内农作物大面积受旱影响，部分地区粮食价格上涨；猪肉价格继续下降，牛肉价格企稳；蔬菜和食用油价格以降为主；禽蛋、水产品、水果和奶类价格稳定。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("2009，社保改革能走多远");
//		news.setContent("郑秉文：此次金融危机引发的全球经济衰退不单是挑战，对于中国社保制度来讲，也充满了机遇。社保制度分为“缴费型的社会保险”和“非缴费型的社会保障”制度，前者的融资方式主要是由参保人的缴费形成，后者主要是来自一般税收的各级财政转移支付。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("美国女子花25天游泳横渡大西洋");
//		news.setContent("东方网2月9日消息：据英国广播公司8日报道，美国56岁妇女詹妮弗·菲格从上世纪60年代起，就梦想将来有一天通过游泳横渡大西洋。日前，詹妮弗终于实现了自己的梦想——她花25天时间游过了700英里远的距离，于今年2月5日成功游过大西洋。詹妮弗也一举打破世界纪录，成为人类有史以来第一个游过大西洋的女性。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("瑞士公投赞成与欧盟成员国实行人员自由流动");
//		news.setContent("新华网日内瓦２月８日电（记者杨伶）瑞士８日就欧盟成员国人员在瑞士“自由流动政策”举行全民公投。投票结果显示，５９．６％的选民赞成继续实施这一政策并将其扩大到新入盟的罗马尼亚和保加利亚。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("美国称不会在南亚建立军事基地");
//		news.setContent("美国负责南亚事务的助理国务卿鲍彻８日在孟加拉国首都达卡举行的记者招待会上表示，美国没有在孟加拉国以及南亚地区建立军事基地的打算，但愿意帮助孟维护其海域安全。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("卡巴斯基网站数据库遭黑客攻入");
//		news.setContent("这个黑客在星期六（2月7日）发表的博客中称，一个简单的SQL注入攻击就能够访问卡巴斯基的包含用户、激活代码、安全漏洞列表、管理员和购买等信息的数据库。这个黑客称，对一个URL地址进行简单地修改就能够访问这个网站的整个数据库。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("埃因霍温高层透周海滨仅签半年");
//		news.setContent("已经人在荷兰，但是关于他的合同依然是一个疑问，之前媒体爆出的有多种版本，包括1+2模式和1+2.5模式。但是根据今天出版的《体坛周报》的报道， 球队经理范登霍伊弗表示俱乐部与周海滨只签了半年合同。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("麦蒂与阿泰互喷口水");
//		news.setContent("北京时间2月9日据《休斯顿纪事报》报道，火箭在主场赢下森林狼，球队内部却传来不和谐声音。阿泰斯特与麦蒂就球队防守问题打起了嘴仗。 尽管两人号称难兄难弟，在1月份一起因伤缺席了火箭的多数比赛，但复出后两人的关系却没有并没有因此和谐融洽。早先在接受采访时口直心快的阿泰表示，火箭防守必须从麦蒂做起。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//		news=new News();
//		news.setAuth("caoyang");
//		news.setDate(DateUtils.getCurrentDateTime());
//		news.setTitle("小灵通退市谁说了算");
//		news.setContent("对于钟爱小灵通的用户来说，这绝对算不上一个好消息：中国移动日前透露，政府主管部门已明确要求所有 1900-1920MHz频段无线接入系统应在2011年底前完成清频退网工作，以确保不对1880-1900MHz频段TD-SCDMA系统产生有害干扰。 1900-1920MHz正是当初划给小灵通使用的频段。这也意味着，小灵通将在3年内彻底退网。");
//		news.setPicture("demo.gif");
//		newsService.saveOrUpdateNews(news);
//	}


	public boolean isRun() {
		return isRun;
	}

	public void setRun(boolean isRun) {
		this.isRun = isRun;
	}

}
