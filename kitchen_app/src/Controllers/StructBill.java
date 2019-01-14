/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

import Models.BillModel.Bill;
import Models.BillModel.BillInfo;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author thienlan
 */
public class StructBill {
    private final Bill bill;
    private List<BillInfo> billsInfo = new ArrayList<>();
    private List<BillInfo> billsInfoSwap = new ArrayList<>();//for swap
    public StructBill(Bill bill)
    {
        this.bill = bill;
    }

    public Bill getBill() {
        return bill;
    }

    public List<BillInfo> getBillsInfo() {
        return billsInfo;
    }
    
    public int getIDBill() {
        return bill.id;
    }
    
    public void addBillInfo(BillInfo billInfo) {
        //System.out.println("ID BILL INFO = " + billInfo.idFood + " database = " + billInfo.quantityDatabase + " now = " + billInfo.quantityNow);
        BillInfo exists = billsInfo.stream().filter(item -> item.idFood == billInfo.idFood).findFirst().orElse(null);
        if(exists == null) // don't exists
        {
            billsInfo.add(billInfo);
            billsInfoSwap.add(billInfo);
        }
        else // exists
        {
            if(exists.quantityDatabase != billInfo.quantityDatabase){
                exists.quantityNow = billInfo.quantityDatabase - exists.totalDone;
                exists.quantityDatabase = billInfo.quantityDatabase;
                if(exists.quantityNow < 0) {
                    exists.totalDone = 0;
                    exists.quantityNow = billInfo.quantityDatabase;
                }
            }
            billsInfoSwap.add(exists);
        }
    }
    /*
    clear bill info don't exists
    */
    public void cleanBillInfo(){
        billsInfo = billsInfoSwap;
        billsInfoSwap = new ArrayList<>();
    }
    
    public boolean isDone() {
        BillInfo billInfo = billsInfo.stream().filter(item -> item.getDone() == false).findFirst().orElse(null);//find item has value false
        return billInfo == null;// no false => return true;
    }
}
