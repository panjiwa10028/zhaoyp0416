package ivr;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.JFrame;

/**
 *
 * @author Allen
 * 
 */
public class MainFrame extends JFrame {

	private String title;
	private int width;
	private int height;
	
	Container contentPane;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getWidth() {
		return width;
	}
	public void setWidth(int width) {
		this.width = width;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	
	public MainFrame() {
		contentPane = getContentPane();
	    contentPane.setLayout(new BorderLayout());
	   
	}
	public Container getPane() {
		return contentPane;
	}
	
	
}
