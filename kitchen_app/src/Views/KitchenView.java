/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Views;

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
import java.util.Timer;
import java.util.TimerTask;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.DefaultCellEditor;
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
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import Controllers.BillController;
import Controllers.StructBill;
import Models.BillModel;
import java.util.Date;
/**
 *
 * @author Thang Le
 */
public class KitchenView {
     private JTextField idText; //ID text
    private JTextField idtableText; //IDtable text
    private JTextField dateinText; //DateCheckIn text
    private JTextField dateoutText; //DateCheckout text
    private JTextField discountText; //Discount text
    private JTextField totalText; //Total text
    public JTable table;
    public JTable donetable;
    
    public JTable food;
    private JTable combine;
    private JLabel dashboardTitle;
    private JLabel helpTitle;
    private JFrame jf;
    private JDialog jd;
    private JPanel panelYetPrint;
    private JPanel panelPrint;
    private JTextField timeText;
    private JRadioButton check;
    private Timer timer;
    private Timer wait;
    private JTextArea txtbill;
    private JLabel waiting;
    private JLabel done;
    public JLabel detailfood;
    private JLabel combinefood;
    private boolean flag=false;
    JPanel header;
    JPanel main;
    JPanel info;
    JPanel footer;
    BillController controller;
    
    public KitchenView()
    {
        initComponent();
        controller = BillController.getInstance(this);
        controller.loadFull();
    }
    
    public void initComponent()
    {
        jf=new JFrame("Cafe Management \u2022 Kitchen App");
        jf.setSize(new Dimension(1600, 800));
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setLocationRelativeTo(null);
        
         /* HEADER */
        header = new JPanel();
        
        
        /* MAIN TABLE */
        main = new JPanel();
        main.setBackground(Color.green);
       
        /* FOOTER */
        footer = new JPanel();
        footer.setBackground(Color.cyan);
        
        createHeader(header);
        createMain(main);
        //createInfo(info);
        createFooter(footer);
        jf.add(header, BorderLayout.PAGE_START);
        jf.add(main, BorderLayout.CENTER);
        //jf.add(info, BorderLayout.LINE_END);
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
                 controller.loadFull();
                 Wait(2); // wait 2 seconds to set forecolor
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
                 //setForeColor();
                 helpTitle.setForeground(Color.red);
                //JOptionPane.showMessageDialog(null, "Bạn có thể chọn auto, để app có thể tự động reload sau thời gian quy định!");
                 //setForeColor();
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
    
    
    private void createMain(JPanel main)
    {
        main.setLayout(new BoxLayout(main, BoxLayout.X_AXIS));
        
        /*LEFT*/
        JPanel left=new JPanel();
        left.setBackground(Color.red);
        left.setLayout(new BoxLayout(left, BoxLayout.Y_AXIS));
        left.setPreferredSize(new Dimension(500, main.getHeight()));
        
        /*waiting*/
        JPanel lefttop=new JPanel();
        lefttop.setBackground(Color.gray);
        lefttop.setLayout(new BoxLayout(lefttop, BoxLayout.Y_AXIS));
        
        waiting=new JLabel("WAITING");
        waiting.setFont(new java.awt.Font(waiting.getFont().toString(), Font.BOLD, 25));
        waiting.setAlignmentX(Component.CENTER_ALIGNMENT);
         //Table
        String []title=new String[]{"ID","Table","CheckIn","Username", ""};
        DefaultTableModel model= new DefaultTableModel(null,title){
            @Override
            public boolean isCellEditable(int row, int column) {
            return false;
            }
        };
        table = new JTable() {
            @Override
            public Class getColumnClass(int column) {
                switch (column) {
                    case 0:
                        return int.class;
                    case 1:
                        return String.class;
                    case 2:
                        return String.class;
                    case 4:
                        return StructBill.class;
                    default:
                        return String.class;
                }
            }
        };
        table.getTableHeader().setFont(new java.awt.Font(table.getFont().toString(), Font.BOLD, 22));
        table.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        table.setFont(new java.awt.Font(table.getFont().toString(), Font.PLAIN, 18));
        table.setModel(model);
        table.setSelectionMode(0);
        table.setRowHeight(80); // chỉnh độ cao của hàng
        table.removeColumn(table.getColumnModel().getColumn(4));
        //controller.loadFull();
        JScrollPane jsp=new JScrollPane(table);
        
        /*Sự kiện click ở table*/
        table.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    //goi detail
                int index=table.getSelectedRow();
                if(index >= 0)
                {
                    StructBill structBill = (StructBill)table.getModel().getValueAt(index, 4);
                    controller.addViewDetail(structBill);
                }
            }    
        });
         /*End click table event*/
        lefttop.add(waiting);
        lefttop.add(Box.createRigidArea(new Dimension(0,5)));
        lefttop.add(jsp);
        /*done*/
        JPanel leftbottom=new JPanel();
        leftbottom.setBackground(Color.yellow);
        leftbottom.setLayout(new BoxLayout(leftbottom, BoxLayout.Y_AXIS));
        
        done=new JLabel("DONE");
        done.setFont(new java.awt.Font(done.getFont().toString(), Font.BOLD, 25));
        done.setAlignmentX(Component.CENTER_ALIGNMENT);
         //Table
         DefaultTableModel model2= new DefaultTableModel(null,title){
            @Override
            public boolean isCellEditable(int row, int column) {
                return false;
            }
        };
        donetable=new JTable(){
                        @Override
            public Class getColumnClass(int column) {
                switch (column) {
                    case 0:
                        return int.class;
                    case 1:
                        return String.class;
                    case 2:
                        return String.class;
                    case 4:
                        return StructBill.class;
                    default:
                        return String.class;
                }
            }
        };
        donetable.getTableHeader().setFont(new java.awt.Font(donetable.getFont().toString(), Font.BOLD, 22));
        donetable.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        donetable.setFont(new java.awt.Font(table.getFont().toString(), Font.PLAIN, 18));
        donetable.setModel(model2);
        donetable.setSelectionMode(0);
        donetable.setRowHeight(80); // chỉnh độ cao của hàng
        donetable.removeColumn(donetable.getColumnModel().getColumn(4));
        //controller.loadFull();
        JScrollPane jsp2=new JScrollPane(donetable);
        
        /*Sự kiện click ở table*/
        donetable.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    //goi detail
                int index=donetable.getSelectedRow();
                if(index>=0)
                {
                    StructBill structBill = (StructBill)donetable.getModel().getValueAt(index, 4);
                    controller.addViewDetail(structBill);
                } 
            }    
        });
         /*End click table event*/
        leftbottom.add(done);
        leftbottom.add(Box.createRigidArea(new Dimension(0,5)));
        leftbottom.add(jsp2);
      
        /*END LEFT*/
        
         /*RIGHT*/
        JPanel right=new JPanel();
        right.setBackground(Color.green);
        right.setLayout(new BoxLayout(right, BoxLayout.X_AXIS));
        
        
        JPanel righttop=new JPanel();
        righttop.setBackground(Color.gray);
        righttop.setLayout(new BoxLayout(righttop, BoxLayout.Y_AXIS));
        
        detailfood=new JLabel("Detail of");
        detailfood.setFont(new java.awt.Font(detailfood.getFont().toString(), Font.BOLD, 25));
        detailfood.setAlignmentX(Component.CENTER_ALIGNMENT);
        String []title2=new String[]{"Name","Quantity","Status", ""};
        DefaultTableModel model3= new DefaultTableModel(null,title2){
            @Override
            public boolean isCellEditable(int row, int column) {
            if(column == 2) return true;
                return false;
            }
        };
        
         food = new JTable() {
            @Override
            public Class getColumnClass(int column) {
                switch (column) {
                    case 3:
                        return BillModel.BillInfo.class;
                    case 2:
                        return Boolean.class;
                    case 1:
                        return Double.class;
                    default:
                        return String.class;
                }
            }
        };
        food.getTableHeader().setFont(new java.awt.Font(food.getFont().toString(), Font.BOLD, 22));
        food.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        food.setFont(new java.awt.Font(food.getFont().toString(), Font.PLAIN, 18));
        food.setModel(model3);
        food.setSelectionMode(0);
        food.setRowHeight(80); // chỉnh độ cao của hàng
        food.removeColumn(food.getColumnModel().getColumn(3));

        //controller.loadFull();
        JScrollPane jsp3 = new JScrollPane(food);
        
        /*Sự kiện click ở table*/
        food.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    //goi detail
                int index=food.getSelectedRow();
                if(index>=0)
                {

                    
                }   
            }    
        });
        
        food.getModel().addTableModelListener(new CheckBoxModelListener());
         /*End click table event*/
        righttop.add(detailfood);
        righttop.add(Box.createRigidArea(new Dimension(0,5)));
        righttop.add(jsp3);
         
        JPanel rightbottom=new JPanel();
        rightbottom.setBackground(Color.yellow);
        rightbottom.setLayout(new BoxLayout(rightbottom, BoxLayout.Y_AXIS));
        
        combinefood=new JLabel("Combined food");
        combinefood.setFont(new java.awt.Font(combinefood.getFont().toString(), Font.BOLD, 25));
        combinefood.setAlignmentX(Component.CENTER_ALIGNMENT);
        String []title3=new String[]{"Name","Quantity","Action"};
        DefaultTableModel model4= new DefaultTableModel(null,title3){
            @Override
            public boolean isCellEditable(int row, int column) {
            if(column == 2) return true;
                return false;
            }
        };
        
         combine = new JTable() {
            @Override
            public Class getColumnClass(int column) {
                switch (column) {
                    case 3:
                        return BillModel.BillInfo.class;
                    case 2:
                        return JButton.class;
                    case 1:
                        return Double.class;
                    default:
                        return String.class;
                }
            }
        };
        combine.getTableHeader().setFont(new java.awt.Font(combine.getFont().toString(), Font.BOLD, 22));
        combine.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        combine.setFont(new java.awt.Font(combine.getFont().toString(), Font.PLAIN, 18));
        combine.setModel(model4);
        combine.setSelectionMode(0);
        combine.setRowHeight(80); // chỉnh độ cao của hàng
         //SET CUSTOM RENDERER TO TEAMS COLUMN
        combine.getColumnModel().getColumn(2).setCellRenderer(new ButtonRenderer());;

        //SET CUSTOM EDITOR TO TEAMS COLUMN
        combine.getColumnModel().getColumn(2).setCellEditor(new ButtonEditor(new JTextField()));
        //controller.loadFull();
        JScrollPane jsp4=new JScrollPane(combine);
        
        /*Sự kiện click ở table*/
        combine.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseClicked(MouseEvent arg0)
            {
                    //goi detail
                int index=combine.getSelectedRow();
                if(index>=0)
                {

                    
                }  
            }    
        });
         /*End click table event*/
        rightbottom.add(combinefood);
        rightbottom.add(Box.createRigidArea(new Dimension(0,5)));
        rightbottom.add(jsp4);
        
        /*END RIGHT*/
        
        /*ADD COMPONENT TO LEFT*/
        left.add(lefttop);
        left.add(Box.createRigidArea(new Dimension(0,5)));
        left.add(leftbottom);
        
        /*ADD COMPONENT TO RIGHT*/
        right.add(righttop);
        right.add(Box.createRigidArea(new Dimension(5,0)));
        right.add(rightbottom);
        
        main.add(left);
        main.add(Box.createRigidArea(new Dimension(5,0)));
        main.add(right);
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
                       //controller.delete(id);
                       //delete(index);
                   }
               }
               else
                    JOptionPane.showMessageDialog(null, "Bạn chưa chọn hóa đơn nào để in");
                
            }
        });
        
        check.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if(check.isSelected()==true)
                {
                    setForeColor();
                    timeText.setEditable(false);
                    dashboardTitle.setForeground(Color.red);
                    Auto();
                }
                else
                {
                    timeText.setEditable(true);
                    setForeColor();
                    timer.cancel();
                }
                
            }
        });
       
    }
    
    //AUTO LOAD
    private void Auto()
    {
        long timewait = Long.parseLong(timeText.getText()); // convert string to long
        timer = new Timer();
        flag = true; //set flag to recognize timer is started
        TimerTask task = new TimerTask() {
            long second = 0;
            @Override
            public void run() {               
                controller.loadFull();
            }      
        };
       timer.scheduleAtFixedRate(task, 1000, timewait * 1000);
    }
    
     private void setForeColor()
    {
        Color defColor=new Color(41,55,72);
        dashboardTitle.setForeground(defColor);
        helpTitle.setForeground(defColor);
    }
     
     private void Wait(int x)
    {
            //long timewait=Long.parseLong(timeText.getText()); // convert string to long
            wait=new Timer();
            //flag=true; //set flag to recognize timer is started
            TimerTask task=new TimerTask() {
                long second=0;
                @Override
                public void run() {               
                    second=0;
                    setForeColor();
                    wait.cancel();
                    wait.purge();
                }      
            };
           wait.scheduleAtFixedRate(task, 1000, x*1000);
    }
     
     /*CHECKBOX IN JTABLE CELL*/
    public class CheckBoxModelListener implements TableModelListener {

        public void tableChanged(TableModelEvent e) {
            int row = e.getFirstRow();
            int column = e.getColumn();
            if (column == 2) {
                TableModel model = (TableModel) e.getSource();
                Boolean checked = (Boolean) model.getValueAt(row, column);
                BillModel.BillInfo billInfo = (BillModel.BillInfo)model.getValueAt(row, 3);
                //System.out.println("done: " + billInfo.totalDone + " now:" + billInfo.quantityNow);
                billInfo.setDone(checked);
                //System.out.println("done: " + billInfo.totalDone + " now:" + billInfo.quantityNow);
            }
        }
    }
    
    
    //BUTTON RENDERER CLASS
class ButtonRenderer extends JButton implements  TableCellRenderer
{

  //CONSTRUCTOR
  public ButtonRenderer() {
    //SET BUTTON PROPERTIES
    setOpaque(true);
  }
  @Override
  public Component getTableCellRendererComponent(JTable table, Object obj,
      boolean selected, boolean focused, int row, int col) {

    //SET PASSED OBJECT AS BUTTON TEXT
      setText((obj==null) ? "":obj.toString());

    return this;
  }

}

//BUTTON EDITOR CLASS
class ButtonEditor extends DefaultCellEditor
{
  protected JButton btn;
   private String lbl;
   private Boolean clicked;

   public ButtonEditor(JTextField txt) {
    super(txt);

    btn=new JButton();
    btn.setOpaque(true);

    //WHEN BUTTON IS CLICKED
    btn.addActionListener(new ActionListener() {
        @Override
        public void actionPerformed(ActionEvent e) {
            JOptionPane.showMessageDialog(null, "Clicked "+combine.getSelectedRow());
        }
        });
   }


   //OVERRIDE A COUPLE OF METHODS
        @Override
        public Component getTableCellEditorComponent(JTable table, Object obj,
      boolean selected, int row, int col) {

      //SET TEXT TO BUTTON,SET CLICKED TO TRUE,THEN RETURN THE BTN OBJECT
     lbl=(obj==null) ? "":obj.toString();
     btn.setText(lbl);
     clicked=true;
    return btn;
  }

  //IF BUTTON CELL VALUE CHNAGES,IF CLICKED THAT IS
   @Override
  public Object getCellEditorValue() {

     if(clicked)
      {
      //SHOW US SOME MESSAGE
        JOptionPane.showMessageDialog(btn, lbl+" Clicked");
      }
    //SET IT TO FALSE NOW THAT ITS CLICKED
    clicked=false;
    return new String(lbl);
  }

   @Override
  public boolean stopCellEditing() {

         //SET CLICKED TO FALSE FIRST
      clicked=false;
    return super.stopCellEditing();
  }

   @Override
  protected void fireEditingStopped() {
    // TODO Auto-generated method stub
    super.fireEditingStopped();
  }
}

/*IN BILL*/
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
         if(table.getRowCount()>0)
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

 private void initBillHeader()
    {
        txtbill.setText("Starbucks – The Best Coffee and Espresso Drinks"+"\n"
        +"Contact 0123xxxxxx"+"\n"
        +"Adress - mPlaza Saigon, 39 Lê Duẩn, Quận 1, TP.HCM"+"\n"
        +"******************************"+"\n");
    
    }
 
 private void initBill(int index)
    {
        txtbill.setText(txtbill.getText()+"BILL : "+table.getValueAt(index, 0).toString()+"\n");
        txtbill.setText(txtbill.getText()+"Date Checkin : "+table.getValueAt(index, 2).toString()+"\n");
        txtbill.setText(txtbill.getText()+"Table : "+table.getValueAt(index, 1).toString()+"\n"+"******************************"+"\n");
        txtbill.setText(txtbill.getText()+"Detail Bill \n");     
        //xu ly bill food detail
        //txtbill.setText(txtbill.getText()+"Discount : "+table.getValueAt(index, 4).toString()+"\n");
        //txtbill.setText(txtbill.getText()+"Total Price : "+table.getValueAt(index, 5)+"\n");
        txtbill.setText(txtbill.getText()+"******************************"+"\n");
        txtbill.setText(txtbill.getText()+"Signature : "+table.getValueAt(index, 3).toString()+"\n");
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

public static void main(String[] args)
    {
        KitchenView app=new KitchenView();
    }
}
