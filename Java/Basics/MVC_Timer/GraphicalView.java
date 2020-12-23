import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class GraphicalView extends JFrame implements View {
	private JLabel input;
	private Timer model;
	public GraphicalView (Timer model, Controller controller) {
		setLayout (new GridLayout(2, 3));
		this.model = model;
		
		JButton incH, incM, incS;
		JButton decH, decM, decS;

		incH = new JButton("IncrementHours");
		incM = new JButton("IncrementMinutes");
		incS = new JButton("IncrementSeconds");

		decH = new JButton("DecrementHours");
		decM = new JButton("DecrementMinutes");
		decS = new JButton("DecrementSeconds");

		incH.addActionListener(controller);
		incM.addActionListener(controller);
		incS.addActionListener(controller);

		decH.addActionListener(controller);
		decM.addActionListener(controller);
		decS.addActionListener(controller);

		add(incH);
		add(incM);
		add(incS);

		input = new JLabel();
		add(input);

		add(decH);
		add(decM);
		add(decS);

		

		//setup
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setSize(700, 100);

		//display the window
		setVisible(true);
	}
	public void update () {
		input.setText(model.toString());
	}
	
}