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
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.event.TableModelEvent;
import javax.swing.event.TableModelListener;
import javax.swing.table.DefaultTableModel;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableModel;
import Controllers.BillController;
import Controllers.StructBill;
import Models.BillModel;
/**
 *
 * @author Thang Le
 */
public class KitchenView {
   
    public JTable table;
    public JTable donetable;
    
    public JTable food;
    public JTable combine;
    private JLabel dashboardTitle;
    private JLabel helpTitle;
    private JFrame jf;
    private JTextField timeText;
    private JRadioButton check;
    private Timer timer;
    private Timer wait;

    private JLabel waiting;
    private JLabel done;
    public JLabel detailfood;
    private JLabel combinefood;
    private boolean flag = false;
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
        jf=new JFrame("Store Pattern \u2022 Kitchen App");
        jf.setSize(new Dimension(1600, 800));
        jf.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        jf.setLocationRelativeTo(null);
        
         /* HEADER */
        header = new JPanel();
        
        
        /* MAIN TABLE */
        main = new JPanel();
        main.setBackground(new Color(228,249,245));
       
        /* FOOTER */
        footer = new JPanel();
        footer.setBackground(new Color(228,249,245));
        
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
         header.setBackground(new Color(209, 228, 252));
         
          /* BRAND */
        JPanel brandSection = new JPanel();
        brandSection.setBackground(new Color(209, 228, 252));

        
        JLabel brandImage = new JLabel();
        URL imgURL = getClass().getResource("../image/logo.png");
        brandImage.setIcon(new ImageIcon(imgURL));
        
        JLabel brandText = new JLabel("Store Pattern - The prototype for management applications");
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

        dashboard.setBackground(new Color(209, 228, 252));
        
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
                 dashboardTitle.setForeground(new Color(228,249,245));
                 controller.loadFull();
                 Wait(2); // wait 2 seconds to set forecolor
             }
            
});
        /*END DASHBOARD OPTIONS*/
        
        /*DASHBOARD*/
        JPanel help = new JPanel();
        help.setLayout(new BoxLayout(help, BoxLayout.Y_AXIS));

        help.setBackground(new Color(209, 228, 252));
        
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
                 helpTitle.setForeground(new Color(228,249,245));
                //JOptionPane.showMessageDialog(null, "Bạn có thể chọn auto, để app có thể tự động reload sau thời gian quy định!");
                 //setForeColor();
             }
            
});
        /*END DASHBOARD OPTIONS*/
        
        /*OPTIONS*/
        JPanel options = new JPanel();
        options.setBackground(new Color(209, 228, 252));

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
        left.setBackground(new Color(228,249,245));
        left.setLayout(new BoxLayout(left, BoxLayout.Y_AXIS));
        left.setPreferredSize(new Dimension(500, main.getHeight()));
        
        /*waiting*/
        JPanel lefttop=new JPanel();
        lefttop.setBackground(new Color(209,228,252));
        lefttop.setLayout(new BoxLayout(lefttop, BoxLayout.Y_AXIS));
        
        waiting=new JLabel("WAITING");
        waiting.setForeground(new Color(0,107,68));
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
        table.getTableHeader().setFont(new java.awt.Font(table.getFont().toString(), Font.TRUETYPE_FONT, 19));
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
        leftbottom.setBackground(new Color(209,228,252));
        leftbottom.setLayout(new BoxLayout(leftbottom, BoxLayout.Y_AXIS));
        
        done=new JLabel("DONE");
        done.setForeground(new Color(0,107,68));
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
        donetable.getTableHeader().setFont(new java.awt.Font(donetable.getFont().toString(), Font.TRUETYPE_FONT, 19));
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
        right.setBackground(new Color(228,249,245));
        right.setLayout(new BoxLayout(right, BoxLayout.X_AXIS));
        
        
        JPanel righttop=new JPanel();
        righttop.setBackground(new Color(209,228,252));
        righttop.setLayout(new BoxLayout(righttop, BoxLayout.Y_AXIS));
        
        detailfood=new JLabel("DETAIL OF");
        detailfood.setFont(new java.awt.Font(detailfood.getFont().toString(), Font.BOLD, 25));
        detailfood.setForeground(new Color(0,107,68));
        detailfood.setAlignmentX(Component.CENTER_ALIGNMENT);
        String []title2=new String[]{"Name","Quantity","Done", ""};
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
            @Override
        public Component prepareRenderer(TableCellRenderer renderer,int row,int column)
        {
            int index=row;
           Component comp=super.prepareRenderer(renderer,row, column);
           int modelRow=convertRowIndexToModel(row);
           if((Boolean)getValueAt(row,2))
           {
               comp.setBackground(Constants.CColor.defcolor);
               food.setSelectionBackground(Constants.CColor.defcolor);
           } 
           else
           {
               comp.setBackground(Color.WHITE);
               food.setSelectionBackground(Color.WHITE);
               

           }
           return comp;
        }
        };
        food.getTableHeader().setFont(new java.awt.Font(food.getFont().toString(), Font.TRUETYPE_FONT, 19));
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
        rightbottom.setBackground(new Color(209,228,252));
        rightbottom.setLayout(new BoxLayout(rightbottom, BoxLayout.Y_AXIS));
        
        combinefood=new JLabel("COMBINED FOOD");
        combinefood.setForeground(new Color(0,107,68));
        combinefood.setFont(new java.awt.Font(combinefood.getFont().toString(), Font.BOLD, 25));
        combinefood.setAlignmentX(Component.CENTER_ALIGNMENT);
        String []title3=new String[]{"Name","Quantity","Action", ""};
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
                        return int.class;
                    case 2:
                        return String.class;
                    case 1:
                        return int.class;//so luong
                    default:
                        return String.class;//name
                }
            }
        };
        combine.getTableHeader().setFont(new java.awt.Font(combine.getFont().toString(), Font.TRUETYPE_FONT, 19));
        combine.getTableHeader().setReorderingAllowed(false); // khong cho di chuyen thu tu cac column
        combine.setFont(new java.awt.Font(combine.getFont().toString(), Font.PLAIN, 18));
        combine.setModel(model4);
        combine.setSelectionMode(0);
        combine.setRowHeight(80); // chỉnh độ cao của hàng
         //SET CUSTOM RENDERER TO TEAMS COLUMN
        combine.getColumnModel().getColumn(2).setCellRenderer(new ButtonRenderer());
        combine.removeColumn(combine.getColumnModel().getColumn(3));

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
        btn.setBackground(new Color(228,249,245));


        btn.add(Box.createRigidArea(new Dimension(5, 0)));
        
        /*Auto Refresh*/
        JPanel auto= new JPanel();
        auto.setLayout(new BoxLayout(auto, BoxLayout.X_AXIS));
        auto.setMaximumSize(new Dimension(300, 50));
        auto.setBackground(new Color(228,249,245));
        
        JLabel timeTitle = new JLabel("Refresh After");
        timeTitle.setForeground(new Color(41,55,72));
        timeTitle.setAlignmentX(Component.CENTER_ALIGNMENT);
        
        timeText=new JTextField();
        timeText.setText("30");
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
        check.setBackground(new Color(228,249,245));
        
        auto.add(timeTitle);
        auto.add(Box.createRigidArea(new Dimension(5, 0)));
        auto.add(timeText);
        auto.add(Box.createRigidArea(new Dimension(5, 0)));
        auto.add(check);
        
        
        footer.add(btn);
        footer.add(Box.createRigidArea(new Dimension(25, 0)));
        footer.add(auto);
        footer.add(Box.createRigidArea(new Dimension(25, 0)));
        
        
        check.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                if(check.isSelected()==true)
                {
                    setForeColor();
                    timeText.setEditable(false);
                    dashboardTitle.setForeground(new Color(228,249,245));
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
                billInfo.setDone(checked);
                model.setValueAt(billInfo.quantityNow, row, 1);   
                controller.loadCombine();

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
            int result = JOptionPane.showConfirmDialog(null, "Are you sure?", "Warning", JOptionPane.YES_NO_OPTION);
            if(result == JOptionPane.YES_OPTION){
                int id = (int)combine.getModel().getValueAt(combine.getSelectedRow(), 3);
                controller.doneBills(id);
            }
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


public static void main(String[] args)
    {
        KitchenView app=new KitchenView();
    }
}
