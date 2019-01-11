/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Views;

import Constants.CColor;
import Controllers.BillController;
import Models.BillModel;
import Models.BillModel.Bill;
import Models.BillModel.BillInfo;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyAdapter;
import java.awt.event.KeyEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author thienlan
 */
public class KitchenView extends View {
    private JTextField idText; //ID text
    private JTextField idtableText; //IDtable text
    private JTextField dateinText; //DateCheckIn text
    private JTextField dateoutText; //DateCheckout text
    private JTextField discountText; //Discount text
    private JTextField totalText; //Total text
    private JTable table;
    private JTable detailtable;
    private JLabel dashboardTitle;
    private JLabel helpTitle;
    private JFrame jf;
    private JDialog jd;
    private JPanel panelYetPrint;
    private JPanel panelPrint;
    private JTextField timeText;
    private JRadioButton check;
    private Timer timer;
    private JTextArea txtbill;
    JPanel header;
    JPanel main;
    JPanel info;
    JPanel footer;
    Boolean flag=false; //flag to recognize timer is running
    BillController controller;
    public KitchenView()
    {
        controller=BillController.getInstance(this);
        initComponent();
    }
    
     //---------------------------------------------------------------------------------------------------------
    @Override
    public void insert(Object objects){
    }
    
    @Override
    public void delete(int row){
        ((DefaultTableModel)table.getModel()).removeRow(row);
    }
    
    @Override
    public void update(int row, Object objects){
        
    }
    
    @Override
    public void loadView(Object objects){
        List<Bill> bills = (java.util.List<BillModel.Bill>)(Object)objects;
        
        DefaultTableModel model = (DefaultTableModel)table.getModel();
        model.setRowCount(0);
        bills.forEach((item) -> {
            model.addRow(new Object[] { item.id,  item.idtable,item.checkin,item.checkout,item.discount,item.price,item.username});
        });
        
        table.setModel(model);

    }
    
    public void LoadInfo(Object objects)
    {
        List<BillInfo> categories = (List<BillInfo>)(Object)objects;
        
        DefaultTableModel model = (DefaultTableModel)detailtable.getModel();
        model.setRowCount(0);
        categories.forEach((item) -> {
            model.addRow(new Object[] { item.name,this.getImage(item.getImage()),item.quantity,item.price});
        });
        
        detailtable.setModel(model);
    }
    //----------------------------------------------------------------------------------------------------------
    
    private void initBillHeader()
    {
        txtbill.setText("Starbucks – The Best Coffee and Espresso Drinks"+"\n"
        +"Contact 0123xxxxxx"+"\n"
        +"Adress - mPlaza Saigon, 39 Lê Duẩn, Quận 1, TP.HCM"+"\n"
        +"******************************"+"\n");
    
    }
    private void initComponent() {
        // Jframe
        jf=new JFrame("Cafe Management || Kitchen App");
        jf.setSize(new Dimension(1600, 800));
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setLocationRelativeTo(null);
        //this.setB//ackground(CColor.yellow);
        
         /* HEADER */
        header = new JPanel();
        
        
        /* MAIN TABLE */
        main = new JPanel();
        main.setBackground(Color.green);
       
        
        /* INFO */
        info = new JPanel();
        info.setBackground(Color.yellow);
        
         /* FOOTER */
        footer = new JPanel();
        footer.setBackground(Color.cyan);
        
        createHeader(header);
        createMain(main);
        createInfo(info);
        createFooter(footer);
        jf.add(header, BorderLayout.PAGE_START);
        jf.add(main, BorderLayout.CENTER);
        jf.add(info, BorderLayout.LINE_END);
        jf.add(footer, BorderLayout.PAGE_END);
        jf.setVisible(true);
    }
    
    private void createHeader(JPanel header)
    {
         header.setLayout(new BoxLayout(header, BoxLayout.X_AXIS));
         header.setBackground(new Color(228,249,245));
         
          /* BRAND */
        JPanel brandSection = new JPanel();
        brandSection.setBackground(new Color(228,249,245));
        
        JLabel brandImage = new JLabel();
        URL imgURL = getClass().getResource("../image/logo.png");
        brandImage.setIcon(new ImageIcon(imgURL));
        
        JLabel brandText = new JLabel("Starbucks – The Best Coffee and Espresso Drinks");
        brandText.setForeground(new Color(0,107,68));
        brandText.setBackground(new Color(228,249,245));
        brandText.setFont(new Font("SansSerif", Font.PLAIN, 20));
        
        brandSection.add(Box.createRigidArea(new Dimension(5, 0)));
        brandSection.add(brandImage);
        brandSection.add(Box.createRigidArea(new Dimension(15, 0)));
        brandSection.add(brandText);
        brandSection.add(Box.createRigidArea(new Dimension(10, 0)));
        /* END BRAND*/
        /*DASHBOARD*/
        JPanel dashboard = new JPanel();
        dashboard.setLayout(new BoxLayout(dashboard, BoxLayout.Y_AXIS));
        dashboard.setBackground(new Color(228,249,245));
        
        dashboardTitle = new JLabel("Refesh");
        dashboardTitle.setForeground(new Color(41,55,72));
        dashboardTitle.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        URL dashboardURL = getClass().getResource("../image/refresh.png");
        JLabel dashboardIcon = new JLabel(new ImageIcon(dashboardURL));
        dashboardIcon.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        dashboard.add(dashboardTitle);
        dashboard.add(Box.createRigidArea(new Dimension(0, 6)));
        dashboard.add(dashboardIcon);
        
        dashboard.addMouseListener(new MouseAdapter() {
             @Override
             public void mouseClicked(MouseEvent e) {
                 super.mouseClicked(e); //To change body of generated methods, choose Tools | Templates.
                 //JOptionPane.showMessageDialog(null, "Load Database");
                 setForeColor();
                 dashboardTitle.setForeground(Color.red);
                 table.clearSelection();
                 DefaultTableModel model=(DefaultTableModel)detailtable.getModel();
                 model.setRowCount(0);
                 if(check.isSelected()==false)
                 {
                     if(flag==true) timer.cancel(); // if timer is running then stop
                     timeText.setEditable(true);
                    controller.loadFull();
                    flag=false; // reset flag
                 }
                 else
                 {
                     if(flag==true) timer.cancel();
                     timeText.setEditable(false);
                     Auto();
                 }
                     
             }
            
});
        /*END DASHBOARD OPTIONS*/
        
        /*DASHBOARD*/
        JPanel help = new JPanel();
        help.setLayout(new BoxLayout(help, BoxLayout.Y_AXIS));
        help.setBackground(new Color(228,249,245));
        
        helpTitle = new JLabel("Help");
        helpTitle.setForeground(new Color(41,55,72));
        helpTitle.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        URL helpURL = getClass().getResource("../image/info.png");
        JLabel helpIcon = new JLabel(new ImageIcon(helpURL));
        helpIcon.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        help.add(helpTitle);
        help.add(Box.createRigidArea(new Dimension(0, 6)));
        help.add(helpIcon);
        
        help.addMouseListener(new MouseAdapter() {
             @Override
             public void mouseClicked(MouseEvent e) {
                 super.mouseClicked(e); //To change body of generated methods, choose Tools | Templates.
                 setForeColor();
                 helpTitle.setForeground(Color.red);
                JOptionPane.showMessageDialog(null, "Bạn có thể chọn auto, sau đó click refresh để app có thể tự động reload sau thời gian quy định!");
                 setForeColor();
             }
            
});
        /*END DASHBOARD OPTIONS*/
        
        /*OPTIONS*/
        JPanel options = new JPanel();
        options.setBackground(new Color(228,249,245));
        options.setLayout(new BoxLayout(options, BoxLayout.X_AXIS));
        
        options.add(Box.createRigidArea(new Dimension(30, 0)));
        options.add(dashboard);
        options.add(Box.createRigidArea(new Dimension(30, 0)));
        options.add(help);
        options.add(Box.createRigidArea(new Dimension(30, 0)));
         /*END OPTIONS*/
        header.add(brandSection);
        header.add(options);
    }
    
    private void createInfo(JPanel info)
    {
        info.setLayout(new BoxLayout(info,BoxLayout.Y_AXIS));
        info.setPreferredSize(new Dimension(500,info.getHeight()));
        
        
        /*LOAD TABLE*/
         //Table
        String []title=new String[]{"Name","Image","Quantity","Price"};
        DefaultTableModel model= new DefaultTableModel(null,title){
            @Override
            public boolean isCellEditable(int row, int column) {
            return false;
            }
        };
        detailtable = new JTable() {
            @Override
            public Class getColumnClass(int column) {
                switch (column) {
                    case 1:
                        return ImageIcon.class;
                    case 2:
                        return Integer.class;
                    case 3:
                        return Double.class;
                    default:
                        return String.class;
                }
            }
        };
        detailtable.getTableHeader().setFont(new java.awt.Font(table.getFont().toString(), Font.BOLD, 22));
        detailtable.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        detailtable.setFont(new java.awt.Font(table.getFont().toString(), Font.PLAIN, 18));
        detailtable.setModel(model);
        detailtable.setSelectionMode(0);
        detailtable.setRowHeight(80); // chỉnh độ cao của hàng
        
        //controller.loadFull();
        JScrollPane jsp=new JScrollPane(detailtable);
        
        /*Sự kiện click ở table*/
        detailtable.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    
            }    
});
         /*End click table event*/
         
         
        /*END*/
        info.add(Box.createRigidArea(new Dimension(5,0)));
        info.add(jsp);
        info.add(Box.createRigidArea(new Dimension(5,0)));
        
        
    }
    
    private void createMain(JPanel main)
    {
        main.setLayout(new BoxLayout(main, BoxLayout.X_AXIS));
        
        /*LOAD TABLE*/
         //Table
        String []title=new String[]{"ID","IDTable","CheckIn","Checkout","Discount","Total Price","Username"};
        DefaultTableModel model= new DefaultTableModel(null,title){
            @Override
            public boolean isCellEditable(int row, int column) {
            return false;
            }
        };
        table=new JTable();
        table.getTableHeader().setFont(new java.awt.Font(table.getFont().toString(), Font.BOLD, 22));
        table.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        table.setFont(new java.awt.Font(table.getFont().toString(), Font.PLAIN, 18));
        table.setModel(model);
        table.setSelectionMode(0);
        table.setRowHeight(80); // chỉnh độ cao của hàng
        
        //controller.loadFull();
        JScrollPane jsp=new JScrollPane(table);
        
        /*Sự kiện click ở table*/
        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    //goi detail
                int index=table.getSelectedRow();
                if(index>=0)
                {
                    String idbill=table.getModel().getValueAt(index, 0).toString();
                    int id=Integer.parseInt(idbill);
                    //JOptionPane.showMessageDialog(null, "Load info food trong bill");
                    controller.LoadInfo(id);
                    
                }
                
                    
            }    
});
         /*End click table event*/
         
         
        /*END*/
        main.add(Box.createRigidArea(new Dimension(5,0)));
        main.add(jsp);
        main.add(Box.createRigidArea(new Dimension(5,0)));

    }
    
    private void createFooter(JPanel footer)
    {
        footer.setLayout(new BoxLayout(footer, BoxLayout.X_AXIS));
        footer.setPreferredSize(new Dimension(footer.getWidth(), 50));
        JPanel btn = new JPanel();
        btn.setLayout(new BoxLayout(btn, BoxLayout.X_AXIS));
        btn.setBackground(Color.cyan);

        JButton btnAdd = new JButton("Print");
        btn.add(Box.createRigidArea(new Dimension(5, 0)));
        btn.add(btnAdd);
        
        /*Auto Refresh*/
        JPanel auto= new JPanel();
        auto.setLayout(new BoxLayout(auto, BoxLayout.X_AXIS));
        auto.setMaximumSize(new Dimension(300, 50));
        auto.setBackground(Color.cyan);
        
        JLabel timeTitle = new JLabel("Refresh After");
        timeTitle.setForeground(new Color(41,55,72));
        timeTitle.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        timeText=new JTextField();
        timeText.setText("10");
        timeText.setMaximumSize(new Dimension(100, 40));
        
        //numeric
        timeText.addKeyListener(new KeyAdapter() {
            public void keyTyped(KeyEvent e) {
                    char c = e.getKeyChar();
                    if (!((c >= '0') && (c <= '9') ||
                    (c == KeyEvent.VK_BACK_SPACE) ||
                    (c == KeyEvent.VK_DELETE))) 
                    {
                        e.consume();
                    }
            }
});
        check=new JRadioButton("Auto");
        //check.setMaximumSize(new Dimension(40, 40
        check.setBackground(Color.cyan);
        
        auto.add(timeTitle);
        auto.add(Box.createRigidArea(new Dimension(5, 0)));
        auto.add(timeText);
        auto.add(Box.createRigidArea(new Dimension(5, 0)));
        auto.add(check);
        
        
        footer.add(btn);
        footer.add(Box.createRigidArea(new Dimension(25, 0)));
        footer.add(auto);
        footer.add(Box.createRigidArea(new Dimension(25, 0)));
        
        /*Sự kiện print*/
        btnAdd.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                //String timeStamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime());
                //JOptionPane.showMessageDialog(null, timeStamp);
                //JOptionPane.showMessageDialog(null, "Reload database ");
               int index=table.getSelectedRow();
               if(index>=0)
               {
                   LoadBill(index);
                   
                   if(Print()==true)
                   {
                       int id=Integer.parseInt(table.getValueAt(index, 0).toString());
                       controller.delete(id);
                       delete(index);
                   }
               }
               else
                    JOptionPane.showMessageDialog(null, "Bạn chưa chọn hóa đơn nào để in");
                
            }
        });
       
    }
    
    private void Auto()
    {
            
            long timewait=Long.parseLong(timeText.getText()); // convert string to long
            timer=new Timer();
            flag=true; //set flag to recognize timer is started
            TimerTask task=new TimerTask() {
                long second=0;
                @Override
                public void run() {               
                    //JOptionPane.showMessageDialog(null, "Refresh!");
                    second=second+1;
                    System.out.println(second);
                    if(second==Integer.parseInt(timeText.getText()))
                    {
                        controller.loadFull();
                        second=0;
                    }
                }      
            };
           timer.scheduleAtFixedRate(task, 1000, timewait*1000);
    }
    
    private void setForeColor()
    {
        Color defColor=new Color(41,55,72);
        dashboardTitle.setForeground(defColor);
        helpTitle.setForeground(defColor);
    }
    
    private void LoadBill(int index)
    {
        jd=new JDialog(jf,"Bill");
        jd.setModal(true);
        jd.setSize(450, 600);
        jd.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);  // đóng frame hiện hành
        jd.setResizable(false);

        jd.setLocationRelativeTo(null);
        
        /*info detail*/
        JPanel detail=new JPanel();
        detail.setLayout(new BoxLayout(detail,BoxLayout.Y_AXIS));
        detail.setBackground(Color.yellow);
        detail.setPreferredSize(new Dimension(jd.getWidth(),jd.getHeight()));
        
         txtbill=new JTextArea();
         txtbill.setEditable(false);
         txtbill.setFont(new Font("Arial", Font.PLAIN, 17));
         txtbill.setColumns(20);
         txtbill.setRows(5);
         if(detailtable.getRowCount()>0)
         {
             initBillHeader();
             initBill(index);
         }
         
         JScrollPane jsp=new JScrollPane();
         jsp.setViewportView(txtbill);
         
        detail.add(Box.createRigidArea(new Dimension(0,5)));
        detail.add(jsp);
        detail.add(Box.createRigidArea(new Dimension(0,5)));
         
        jd.getContentPane().add(detail,BorderLayout.CENTER);
        jd.setVisible(true);
    }
    
    private boolean Print()
    {
        boolean flag=false;
        try {
            flag=txtbill.print();
            return flag;
        } catch (Exception e) {
        }
        return false;
    }
    
    private void initBill(int index)
    {
        txtbill.setText(txtbill.getText()+"BILL : "+table.getValueAt(index, 0).toString()+"\n");
        txtbill.setText(txtbill.getText()+"Date Checkin : "+table.getValueAt(index, 2).toString()+"\n");
        txtbill.setText(txtbill.getText()+"Table : "+table.getValueAt(index, 1).toString()+"\n"+"******************************"+"\n");
        txtbill.setText(txtbill.getText()+"Detail Bill \n");     
        for(int i=0;i<detailtable.getRowCount();i++)
        {
            txtbill.setText(txtbill.getText()+detailtable.getValueAt(i, 0)+" - Quantity : "+detailtable.getValueAt(i, 2)+" - Price : "+detailtable.getValueAt(i, 3)+"\n");
        }
        txtbill.setText(txtbill.getText()+"Discount : "+table.getValueAt(index, 4).toString()+"\n");
        txtbill.setText(txtbill.getText()+"Total Price : "+table.getValueAt(index, 5)+"\n");
        txtbill.setText(txtbill.getText()+"******************************"+"\n");
        txtbill.setText(txtbill.getText()+"Signature : "+table.getValueAt(index, 6).toString()+"\n");
    }
    
     private ImageIcon getImage(byte[] data) {
        return new ImageIcon(new ImageIcon(data).getImage().getScaledInstance(80, 80, java.awt.Image.SCALE_SMOOTH));
    }
     
     
    public static void main(String[] args)
    {
        KitchenView app=new KitchenView();
    }
}
