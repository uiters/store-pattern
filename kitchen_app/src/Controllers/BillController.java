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
import java.io.IOException;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Thang Le
 */
public class BillController extends Controller {
     private static BillController _instance = null;
    
    public static BillController getInstance(KitchenView view) {
        if(_instance == null)
            _instance = new BillController(view);
        return _instance;
    }
    
    private final KitchenView view;
    private final BillModel model;
    private List<BillModel.Bill> bills = null;//save
    private List<BillInfo> billinfo=null;
    
    private BillController(KitchenView view) {
        this.view = view;
        this.model = BillModel.getInstance();
    }
    
    @Override
    public void insert(Object object){
        
    }
    @Override
    public void delete(Object object){
      int id = (int)object;
        _remove(id);
        CompletableFuture.runAsync(() -> { //runAsync no return value
            try
            {
                   // update
                model.Print(id);
            }catch (IOException ex) {
                Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
            }
        });
    }
    @Override
    public void update(Object object){
        
       
    }
    
    @Override
    public void loadFull()
    {
        CompletableFuture<List<Bill>>  future;                
        future = CompletableFuture.supplyAsync(() -> {//open thread
            try {
                    bills = model.getOrder();
                return bills;
            } catch (IOException ex) {
                Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            }
        });
        //future.thenAccept(listBills -> view.loadView(listBills));
    }
    
    public void LoadInfo(Object object)
    {
        int index=(int)object;
        CompletableFuture<List<BillInfo>>  future;                
        future = CompletableFuture.supplyAsync(() -> {//open thread
            try {
                    billinfo = model.getBillInfo(index);
                return billinfo;
            } catch (IOException ex) {
                Logger.getLogger(BillController.class.getName()).log(Level.SEVERE, null, ex);
                return null;
            }
        });
        //future.thenAccept(listBills -> view.LoadInfo(listBills));
    }
    
 
    private void _remove(int item)
    {
        for(Bill category : bills){
            if (category.id == item){
                bills.remove(category);
                break;
            }
        }
    }
        
    
    
}
