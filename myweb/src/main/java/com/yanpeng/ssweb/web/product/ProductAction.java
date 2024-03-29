package com.yanpeng.ssweb.web.product;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;
import org.aspectj.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;

import com.yanpeng.core.orm.PropertyFilter;
import com.yanpeng.core.orm.hibernate.HibernateWebUtils;
import com.yanpeng.core.utils.DateUtils;
import com.yanpeng.core.web.struts2.CRUDActionSupport;
import com.yanpeng.core.web.struts2.Struts2Utils;
import com.yanpeng.ssweb.entity.News;
import com.yanpeng.ssweb.entity.Product;
import com.yanpeng.ssweb.entity.ProductCategory;
import com.yanpeng.ssweb.interceptor.annotations.Token;
import com.yanpeng.ssweb.service.product.ProductManager;
import com.yanpeng.ssweb.service.productcategory.ProductCategoryManager;
import com.yanpeng.ssweb.util.HtmlGenerator;
import com.yanpeng.ssweb.web.CURDBaseAction;

/**
 * 新闻管理Action.
 * 
 * 使用Struts2 convention-plugin annotation定义Action参数.
 * 
 * @author Allen
 */
@SuppressWarnings("serial")
@Results( { @Result(name = CRUDActionSupport.RELOAD, location = "product.action?page.pageRequest=${page.pageRequest}", type = "redirect") })
public class ProductAction extends CURDBaseAction<Product> {

	@Autowired
	private ProductManager productManager;

	@Autowired
	private ProductCategoryManager productCategoryManager;

	private File upload;
	private String uploadFileName;

	private List<ProductCategory> allProductCategory;
	private String selectedIds;
	
	private String filter_EQ_categoryId;
	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if (id != null) {
			entity = productManager.getProductById(id);
		} else {
			entity = new Product();
		}
		allProductCategory = productCategoryManager.getAllProductCategory();
	}

	@Override
	public String list() throws Exception {
		List<PropertyFilter> filters = HibernateWebUtils.buildPropertyFilters(Struts2Utils.getRequest(), new Product());
		page.setOrder("desc");
		page.setOrderBy("updateTime");
		page = productManager.search(page, filters);
		allProductCategory = productCategoryManager.getAllProductCategory();
		return SUCCESS;
	}

	@Override
	public String input() throws Exception {

		return INPUT;
	}

	@Override
	public String delete() throws Exception {
		try {
			String[] ids = selectedIds.split(",");
			List<String> list = Arrays.asList(ids);
			productManager.deleteProducts(list);
			addActionMessage("删除成功!");

		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("删除失败!");
		}
		return RELOAD;
	}

	@Override
	@Token
	public String save() throws Exception {
		try {
//			if (entity != null && entity.getId().equals("")) {
//				entity.setId(null);
//			}

			entity.setUserId(getLoginUser().getId());
			HtmlGenerator htmlGenerator = new HtmlGenerator();
			//			取服务器路径
			String path = Struts2Utils.getRequest().getRealPath("");
			//			生成随机的字符串
			String rnadomString = RandomStringUtils.randomAlphabetic(10).toLowerCase();
			if(entity.getHtmlName() != null && !"".equals(entity.getHtmlName())) {
				String tempHtmlName = entity.getHtmlName();
				if(tempHtmlName.indexOf(".") != -1) {
					rnadomString = tempHtmlName.substring(0, tempHtmlName.indexOf("."));
				}
			}
			Date date = new Date();
			//			取当前日期
			String dateString = DateUtils.convertDateToString(date, "yyyy-MM-dd");
			if (upload != null) {
				//				删除旧的上传文件
				String oldPic = path + entity.getPicPath() + File.separator + entity.getPicName();
				FileUtil.deleteContents(new File(oldPic));

				String newPicName = rnadomString;
				if (uploadFileName.indexOf(".") != -1) {
					newPicName += uploadFileName.substring(uploadFileName.lastIndexOf("."));
				}

				String picPath = config.getProdcutPicPath() + File.separator + dateString;
				//				创建日期文件夹
				htmlGenerator.creatDirs(path, picPath);

				entity.setPicPath(picPath);
				entity.setPicName(newPicName);
				//				上传
				copy(upload, path + picPath, newPicName);
			}

			//			删除旧的生成文件
			String oldHtml = path + entity.getHtmlPath() + File.separator + entity.getHtmlName();
			FileUtil.deleteContents(new File(oldHtml));

			htmlGenerator.setEncode("utf-8");
			htmlGenerator.setTemplateDir("/htmlskin/");
			htmlGenerator.setTemplateFile(config.getProductHtmlTemplate());
			htmlGenerator.setRootDir(path);

			String htmlPath = config.getProductHtmlPath() + File.separator + dateString;
			entity.setHtmlPath(htmlPath);
			entity.setHtmlName(rnadomString + ".shtml");

			htmlGenerator.setPreviewHtmlFileDir(htmlPath);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("product", entity);
			String returnValue = htmlGenerator.preview(map, entity.getHtmlName());
			if (returnValue == null) {
				addActionError("保存失败!");
				return INPUT;
			}

			productManager.saveProduct(entity);
			addActionMessage("保存成功!");
			return RELOAD;
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			addActionError("保存失败!");
			return INPUT;
		} finally {
			//			return RELOAD;
		}
	}

	/**
	 * 拷贝文件
	 * @param upload 文件流
	 * @param filePath 新文件路径
	 * @param fileName 文件名
	 * @throws Exception
	 */
	private void copy(File upload, String filePath, String fileName) throws Exception {
		FileOutputStream fos = new FileOutputStream(filePath + File.separator + fileName);
		FileInputStream fis = new FileInputStream(upload);
		byte[] buffer = new byte[1024];
		int len = 0;
		while ((len = fis.read(buffer)) > 0) {
			fos.write(buffer, 0, len);
		}
		fos.close();
		fis.close();
	}

	// ==================================================

	public File getUpload() {
		return upload;
	}

	public void setUpload(File upload) {
		this.upload = upload;
	}

	public String getUploadFileName() {
		return uploadFileName;
	}

	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}

	public List<ProductCategory> getAllProductCategory() {
		return allProductCategory;
	}

	public void setAllProductCategory(List<ProductCategory> allProductCategory) {
		this.allProductCategory = allProductCategory;
	}
	public String getSelectedIds() {
		return selectedIds;
	}

	public void setSelectedIds(String selectedIds) {
		this.selectedIds = selectedIds;
	}
	
	public String getFilter_EQ_categoryId() {
		return filter_EQ_categoryId;
	}

	public void setFilter_EQ_categoryId(String filterEQCategoryId) {
		filter_EQ_categoryId = filterEQCategoryId;
	}
}
