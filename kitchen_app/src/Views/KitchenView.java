/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Views;

import Constains.CColor;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;

/**
 *
 * @author thienlan
 */
public class KitchenView extends JFrame{
    
    private JPanel panel;
    private JPanel panelYetPrint;
    private JPanel panelPrint;
    
    public KitchenView()
    {
        initComponent();
    }
    
    
    private void initComponent() {
        // Jframe
        this.setTitle("Cafe Management || Kitchen App");
        this.setSize(new Dimension(1000, 700));
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        this.setLocationRelativeTo(null);
        //this.setB//ackground(CColor.yellow);
        
        // panel top
        panel = new JPanel();
        panel.setLayout(new BoxLayout(panel, BoxLayout.X_AXIS));
        panel.setBackground(CColor.greenLigth);
        
        // panel left
        JPanel panelLeft = new JPanel();
        panelLeft.setBackground(CColor.red);
        
        // panel right
        JPanel panelRight = new JPanel();
        panelRight.setBackground(CColor.green);
        
        //add panel to frame
        this.add(panel, BorderLayout.CENTER);
        this.add(panelLeft, BorderLayout.LINE_END);
        this.add(panelRight, BorderLayout.LINE_START);
        
        // panel left inside main panel
        panelYetPrint = new JPanel();
        panelYetPrint.setBackground(Color.pink);
        
        //panel right inside main panel
        panelPrint = new JPanel();
        
        // main panel add panel
        panel.add(panelYetPrint);
        panel.add(panelPrint);
    }
    
    public static void main(String[] args)
    {
        new KitchenView().setVisible(true);
    }
}
