package ivr;

import java.applet.Applet;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

/**
 *
 * @author Allen
 * 
 */
public class IvrApp extends Applet{

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		final IvrApp app = new IvrApp();
		final MainFrame mainFrame = new MainFrame();
		Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
		mainFrame.setBounds(0, 0, screensize.width, screensize.height);
		mainFrame.addWindowListener(new WindowAdapter(){
			public void windowClosing(WindowEvent event) {
		          Object object = event.getSource();
		          if (object == mainFrame) {
		        	  app.exit();
		          }
		        }
		});
		mainFrame.setVisible(true);
		mainFrame.getPane().add(app, BorderLayout.CENTER);
		mainFrame.getPane().validate();
		
	}
	
	public void exit()
	  {
//	    destroy();
	    System.exit(0);
	  }

}
