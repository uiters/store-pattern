/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.BillModel;
import Models.BillModel.Bill;
import Models.BillModel.BillInfo;
import Views.KitchenView;
import java.awt.Rectangle;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

/**
 *
 * @author Thang Le
 */
public class BillController {
    private static BillController _instance = null;
    
    public static BillController getInstance(KitchenView view) {
        if(_instance == null)
            _instance = new BillController(view);
        return _instance;
    }
    
    private final KitchenView view;
    private final BillModel model;
    private boolean lock = false;
    private List<StructBill> structWrie = new ArrayList<>();
     private List<StructBill> structWrieSwap = new ArrayList<>();
    private List<StructBill> structBills = new ArrayList<>();
    private List<StructBill> structBillsSwap = new ArrayList<>();
    private final DefaultTableModel table;
    private final DefaultTableModel doneTable;
    private final DefaultTableModel detail;
    private int countTable = 0;
    private Date time;
    DateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    private BillController(KitchenView view) {
        this.view = view;
        this.model = BillModel.getInstance();
        this.table = ((DefaultTableModel) view.table.getModel());
        this.doneTable = ((DefaultTableModel) view.donetable.getModel());
        this.detail = ((DefaultTableModel) view.food.getModel());
    }
      
    public void loadFull()
    {
        if(lock) return;
        lock = true;
        CompletableFuture<List<Bill>>  future;                
        future = CompletableFuture.supplyAsync(() -> {//open thread
            try 
            {
                return model.getOrder();
            } catch (IOException ex) {
                Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            }
        });
        future.thenAccept(listBills -> {
            if(listBills == null)
                return;
            int row = view.table.getSelectedRow();
            int idSelected1 = -1;
            int idSelected2 = -1;
            if(row >= 0)
                idSelected1 = (int)table.getValueAt(row, 0);
            else {
                row = view.donetable.getSelectedRow();
                if(row >= 0)
                idSelected2 = (int)doneTable.getValueAt(row, 0);
            }
            
            listBills.stream().forEach(item -> {
                System.out.println("get food id = " + item.id);
                StructBill structBill = getBillInfo(item);
                }
            );
            cleanBill();//clean bill don't exists

                
            countTable = 0;
            table.setRowCount(0);
            doneTable.setRowCount(0);
            structBills.stream().forEach(item -> {
                if(item.isDone())
                    addViewDone(item);
                else {
                    addViewWaiting(item);  
                }
            });
            if(structBills.size() == 0)
            {
                detail.setRowCount(0);
                view.detailfood.setText("Detail of");
            }else
            {
                final int idselect = idSelected1 >= 0 ? idSelected1 : idSelected2;
                StructBill bill = structBills.stream().filter(item ->item.getBill().id == idselect).findFirst().orElse(null);
                if(bill == null)
                    detail.setRowCount(0);
                else
                {
                    if(idSelected1 >= 0){
                        selectedRow(idSelected1, table, view.table);
                        selectedRow(idSelected1, doneTable, view.donetable);
                    }else
                        selectedRow(idSelected2, doneTable, view.donetable);
                }
            }

            loadCombine();
            System.out.println("done");
            lock = false;
       });
    }
    
    private void selectedRow(int id, DefaultTableModel tableModel, JTable table) {
        if(id >= 0) {
            int index = find(id, tableModel, 0);
            if(index == -1) return;
            try {
                table.setRowSelectionInterval(index, index);
                table.scrollRectToVisible(new Rectangle(table.getCellRect(index, 0, true)));
                StructBill structBill = (StructBill)tableModel.getValueAt(index, 4);
                addViewDetail(structBill);
            }catch (Exception e)
            {
                
            }
        }
    }
    
    private StructBill getBillInfo(Bill bill)
    {
        StructBill exists = structBills.stream().filter(structBill -> structBill.getBill().id == bill.id).findFirst().orElse(null);
        
        if(exists == null)
        {
            exists = new StructBill(bill);
            structBills.add(exists);
            
        }
        final StructBill structBill = exists;
        
        structBillsSwap.add(exists);
        
        try
        {
            List<BillInfo> billsInfo = model.getBillInfo(bill.id);
            billsInfo.stream().forEach(item -> { 
                item.quantityNow = item.quantityDatabase;
                structBill.addBillInfo(item);
                }
            );
            structBill.cleanBillInfo();//clean billInfo don't exists
        }
        catch (IOException ex) 
        {
            ex.printStackTrace();
        }
        return structBill;
    }
    
    private void addViewWaiting(StructBill structBill){
        Bill bill = structBill.getBill();
        table.addRow(new Object[] {
            bill.id, bill.table, bill.checkin, bill.username, structBill
        });
    }
        
    private void addViewDone(StructBill structBill){
        Bill bill = structBill.getBill();
        doneTable.addRow(new Object[] {
            bill.id, bill.table, bill.checkin, bill.username, structBill
        });
    }
    /*
    clean bill don't exists
    */
    private void cleanBill() {
        structBills.removeAll(structBillsSwap);
        structBills.stream().forEach(item -> {
            try {
                writeText(item.getBill().id, item.toString());
            } catch (IOException ex) {
                Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
        
        structBills = structBillsSwap;
        structBillsSwap = new ArrayList<>();
    }
    
    public void writeBill(){
        if(structWrie == null) return;

        structWrie = null;
    }
    
    private int find(int id, DefaultTableModel table, int col){
        for (int row = 0; row < table.getRowCount(); ++row) {
            if((int)table.getValueAt(row, col) == id)
                return row;
        }
        return -1;
    }
    
    public void addViewDetail(StructBill structBill){
        view.detailfood.setText("Detail of " + structBill.getIDBill());
        detail.setRowCount(0);
        structBill.getBillsInfo().forEach(item -> detail.addRow(new Object[] {
            item.name, item.quantityNow, item.getDone(), item
        }));
    }

    public void loadCombine()
    {
        DefaultTableModel model = (DefaultTableModel)view.combine.getModel();
        model.setRowCount(0);
        countTable = 0;
        structBills.stream().forEach(item -> {
            if(!item.isDone()){
                if(countTable == 0)
                try 
                {
                    time = format.parse(item.getBill().checkin);

                } catch (ParseException ex) 
                {
                    ex.printStackTrace();
                }
                if(countTable < 3)
                    addViewCombine(item);
                ++countTable;
            }
        });
    }
    
    private void addViewCombine(StructBill item) {
        try {
            Date timeEnd = format.parse(item.getBill().checkin);
            long diff = time.getTime() - timeEnd.getTime();
            long minutes = diff / (60 * 1000) % 60;
            if(minutes > 5) return;
            
            DefaultTableModel model = (DefaultTableModel)view.combine.getModel();
            item.getBillsInfo().stream().forEach(billInfo -> {
                
                if(billInfo.getDone()) return;
                
                int row = find(billInfo.idFood, model, 3);
                if(row >= 0)
                {
                    int num = Integer.parseInt(model.getValueAt(row, 1).toString());
                    num += billInfo.quantityNow;
                    model.setValueAt(num, row, 1);
                }else
                {
                    model.addRow(new Object[] {
                        billInfo.name, billInfo.quantityNow, "Done", billInfo.idFood
                    });
                }
            });
        } catch (ParseException ex) {
            Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void doneBills(int id) {
        countTable = 0;
        structBills.stream().forEach(item -> {
            if(countTable < 3)
                item.getBillsInfo().stream().forEach(billInfo -> {
                    if(!billInfo.getDone() && billInfo.idFood == id)
                        billInfo.setDone(true);
                });
            ++countTable;
        });
        int row = view.table.getSelectedRow();
        int idSelected1 = -1;
        int idSelected2 = -1;
        
        if(row >= 0)
            idSelected1 = (int)table.getValueAt(row, 0);
        else {
            row = view.donetable.getSelectedRow();
            if(row >= 0)
            idSelected2 = (int)doneTable.getValueAt(row, 0);
        }
        if(idSelected1 >= 0){
            selectedRow(idSelected1, table, view.table);
            selectedRow(idSelected1, doneTable, view.donetable);
        }else
            selectedRow(idSelected2, doneTable, view.donetable);
        loadCombine();
    }
     private String initBillHeader()
    {
        String txb = 
        "Starbucks – The Best Coffee and Espresso Drinks"+"\n"
        + "Contact 0123xxxxxx" + "\n"
        + "Adress - mPlaza Saigon, 39 Lê Duẩn, Quận 1, TP.HCM"+ "\n"
        + "******************************" + "\n";
        return txb;
    }

    private void writeText(int id, String text) throws IOException {
        System.out.println(text);
        BufferedWriter output = null;

        File file = new File(id + ".txt");
        try {
            output = new BufferedWriter(new FileWriter(file));
            output.write(text);
        } catch (IOException ex) {
            Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
        }
        finally {
          if ( output != null ) {
            output.close();
          }
        }
    }
}
