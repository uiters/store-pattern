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
import java.io.IOException;
import java.util.ArrayList;
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
    
    private List<StructBill> structBills = new ArrayList<>();
    private List<StructBill> structBillsSwap = new ArrayList<>();
    private final DefaultTableModel table;
    private final DefaultTableModel doneTable;
    private final DefaultTableModel detail;
    
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
            
            table.setRowCount(0);
            doneTable.setRowCount(0);
            structBills.stream().forEach(item -> {
                if(item.isDone())
                    addViewDone(item);
                else
                    addViewWaiting(item);  
            });
            if(idSelected1 >= 0){
                selectedRow(idSelected1, table, view.table);
                selectedRow(idSelected1, doneTable, view.donetable);
            }else
                selectedRow(idSelected2, doneTable, view.donetable);
            System.out.println("done");
            lock = false;
       });
    }
    
    private void selectedRow(int id, DefaultTableModel tableModel, JTable table) {
        if(id >= 0) {
            int index = find(id, tableModel, 0);
            if(index == -1) return;
            table.setRowSelectionInterval(index, index);
            table.scrollRectToVisible(new Rectangle(table.getCellRect(index, 0, true)));
            StructBill structBill = (StructBill)tableModel.getValueAt(index, 4);
            addViewDetail(structBill);
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
        structBills = structBillsSwap;
        structBillsSwap = new ArrayList<>();
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
}
