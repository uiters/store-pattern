/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Constants.Query;
import com.google.gson.Gson;
import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Base64;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.swing.JOptionPane;

/**
 *
 * @author Thang Le
 */
public class BillModel {
     private static BillModel _instance = null;
    
    public static BillModel getInstance() {
        if(_instance == null)
            _instance = new BillModel();
        return _instance;
    }
    
    private final Gson json;//convert json
    private final MySqlConnection mySqlConnection;
    
    private BillModel() {
        json = new Gson();
        mySqlConnection = MySqlConnection.getInstance();
    }
    
     public List<Bill> getOrder() throws IOException
    {
        String rawJson=mySqlConnection.executeQuery(Query.getOrder, null);
        if(rawJson==null)
            return null;
        Bill[] bills=json.fromJson(rawJson, Bill[].class); // convert json to foodcategory[]
        List<Bill> listBill = new LinkedList<>(Arrays.asList(bills));
        return listBill;
        
    }
     
    public List<BillInfo> getBillInfo(int id) throws IOException
    {
        String rawJson=mySqlConnection.executeQuery(Query.getBillInfo, new Object[] { id });
        if(rawJson==null)
            return null;
        BillInfo[] bills=json.fromJson(rawJson, BillInfo[].class); // convert json to foodcategory[]
        List<BillInfo> listBill = new LinkedList<>(Arrays.asList(bills));
        return listBill;
        
    }
    
    public void Print(int index) throws IOException
    {
        String timeStamp = new SimpleDateFormat("yyyyMMdd_HHmmss").format(Calendar.getInstance().getTime());
        JOptionPane.showMessageDialog(null, timeStamp);
        String raw= mySqlConnection.executeNoneQuery(Query.updateBill, new Object[] { index , timeStamp  });
        if (raw.equals("1")==true) JOptionPane.showMessageDialog(null, "Đã cập nhật thành công");
    }
    public class Bill
    {
        @SerializedName("ID") 
        public int id;
        @SerializedName("IDTable") 
        public int idtable;
        @SerializedName("DateCheckIn") 
        public String checkin;
        @SerializedName("DateCheckOut") 
        public String checkout;
        @SerializedName("Discount") 
        public Double discount;
        @SerializedName("TotalPrice") 
        public double price;
        @SerializedName("Username") 
        public String username;
        
        
        public Bill(int id,int idtable,String checkin,String checkout,Double discount,Double price, String name)
        {
            this.id = id;
            this.idtable = idtable;
            this.checkin=checkin;
            this.checkout=checkout;
            this.discount=discount;
            this.price=price;
            this.username=name;
        }
        
        public Bill(){}
        public Bill (int id)
        {
            this.id=id;
        }
    }
    
    public class BillInfo {
        @SerializedName("Name") public String name;
        @SerializedName("Price") public double price;
        @SerializedName("IDImage") public int idImage;
        @SerializedName("Quantity") public int quantity;
        @SerializedName("Image") @Expose public String stringImage;
        public byte[] image;
        public BillInfo(String name, double price, int idIamge){
            this.name = name;
            this.price = price;
            this.idImage = idIamge;
        }
        
        
        public byte[] getImage(){
            if(image == null)
                image = Base64.getDecoder().decode(stringImage);
            return image;
        }
        public BillInfo(){}
    }
}
