package com.yanpeng.website.service;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.List;
import java.util.Vector;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.jdom.output.XMLOutputter;

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		Test test = new Test();
		try {
			// String path = application.getRealPath
			String myPath = System.getProperty("user.dir");
			System.out.println(myPath);
			test.LoadXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml");
			System.out.println("---------------------------------------");
			test.AddXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml");
			System.out.println("---------------------------------------");
			test.EditXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml", 4);
			System.out.println("---------------------------------------");
			test.LoadXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml");
			System.out.println("---------------------------------------");
			test.DelXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml", 4);
			System.out.println("---------------------------------------");
			test.LoadXML(myPath + "\\src\\test\\java\\com\\yanpeng\\website\\service\\test.xml");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * 读取XML文件所有信息
	 */
	public Vector LoadXML(String path) throws Exception {
		Vector xmlVector = null;
		FileInputStream fi = null;
		try {
			fi = new FileInputStream(path);
			xmlVector = new Vector();
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(fi);
			Element root = doc.getRootElement(); // 得到根元素
			List books = root.getChildren(); // 得到根元素所有子元素的集合
			Element book = null;
			// XmlBean xml =null;
			for (int i = 0; i < books.size(); i++) {
				// xml = new XmlBean();
				book = (Element) books.get(i); // 得到第一本书元素
				System.out.println(book.getChild("书名").getText());
				System.out.println(book.getChild("作者").getText());
				System.out.println(book.getChild("出版社").getText());
				System.out.println(book.getChild("价格").getText());
				System.out.println(book.getChild("出版日期").getText());
				// xmlVector.add(xml);
			}
		} catch (Exception e) {
			System.err.println(e + "error");
		} finally {
			try {
				fi.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return xmlVector;
	}

	/**
	 * 删除XML文件指定信息
	 */
	public static void DelXML(String path, int id) throws Exception {
		FileInputStream fi = null;
		FileOutputStream fo = null;
		try {
//			String path = request.getParameter("path");
			int xmlid = id;
			fi = new FileInputStream(path);
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(fi);
			Element root = doc.getRootElement(); // 得到根元素
			List books = root.getChildren(); // 得到根元素所有子元素的集合
			books.remove(xmlid);// 删除指定位置的子元素
			String indent = " ";
			boolean newLines = true;
			XMLOutputter outp = new XMLOutputter();
			fo = new FileOutputStream(path);
			outp.output(doc, fo);
		} catch (Exception e) {
			System.err.println(e + "error");
		} finally {
			try {
				fi.close();
				fo.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 添加XML文件指定信息
	 */
	public static void AddXML(String path) throws Exception {
		FileInputStream fi = null;
		FileOutputStream fo = null;
		try {
//			String path = request.getParameter("path");
			fi = new FileInputStream(path);
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(fi);
			Element root = doc.getRootElement(); // 得到根元素
			List books = root.getChildren(); // 得到根元素所有子元素的集合
			String bookname = "bookname";
			String author = "author";
			String price = "price";
			String pub = "pub";
			String pubdate = "pubdate";
//			Text newtext;
			Element newbook = new Element("书");
			Element newname = new Element("书名");
			newname.setText(bookname);
			newbook.addContent(newname);
			Element newauthor = new Element("作者");
			newauthor.setText(author);
			newbook.addContent(newauthor);
			Element newpub = new Element("出版社");
			newpub.setText(pub);
			newbook.addContent(newpub);
			Element newprice = new Element("价格");
			newprice.setText(price);
			newbook.addContent(newprice);
			Element newdate = new Element("出版日期");
			newdate.setText(pubdate);
			newbook.addContent(newdate);
			books.add(newbook);// 增加子元素
			String indent = " ";
			boolean newLines = true;
			XMLOutputter outp = new XMLOutputter();
			fo = new FileOutputStream(path);
			outp.output(doc, fo);
		} catch (Exception e) {
			System.err.println(e + "error");
		} finally {
			try {
				fi.close();
				fo.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 修改XML文件指定信息
	 */
	public static void EditXML(String path, int id) throws Exception {
		FileInputStream fi = null;
		FileOutputStream fo = null;
		try {
//			String path = request.getParameter("path");
			int xmlid = id;
			fi = new FileInputStream(path);
			SAXBuilder sb = new SAXBuilder();
			Document doc = sb.build(fi);
			Element root = doc.getRootElement(); // 得到根元素
			List books = root.getChildren(); // 得到根元素所有子元素的集合
			Element book = (Element) books.get(xmlid);
			String bookname = "bookname1";
			String author = "author1";
			String price = "price1";
			String pub = "pub1";
			String pubdate = "pubdate1";
//			Text newtext;
			Element newname = book.getChild("书名");
			newname.setText(bookname);// 修改书名为新的书名
			Element newauthor = book.getChild("作者");
			newauthor.setText(author);
			Element newpub = book.getChild("出版社");
			newpub.setText(pub);
			Element newprice = book.getChild("价格");
			newprice.setText(price);
			Element newdate = book.getChild("出版日期");
			newdate.setText(pubdate);
			// books.set(xmlid,book);//修改子元素
			String indent = " ";
			boolean newLines = true;
			XMLOutputter outp = new XMLOutputter();
			fo = new FileOutputStream(path);
			outp.output(doc, fo);
		} catch (Exception e) {
			System.err.println(e + "error");
		} finally {
			try {
				fi.close();
				fo.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
