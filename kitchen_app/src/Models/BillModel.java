/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Constants.Query;
import com.google.gson.Gson;
import com.google.gson.annotations.SerializedName;

import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Thang Le
 */
public class BillModel {
    private static BillModel _instance = null;

    public static BillModel getInstance() {
        if (_instance == null)
            _instance = new BillModel();
        return _instance;
    }

    private final Gson json;//convert json
    private final MySqlConnection mySqlConnection;

    private BillModel() {
        json = new Gson();
        mySqlConnection = MySqlConnection.getInstance();
    }

    public List<Bill> getOrder() throws IOException {
        String rawJson = mySqlConnection.executeQuery(Query.getOrder, null);
        if (rawJson == null) //data null
            return null;
        Bill[] bills = json.fromJson(rawJson, Bill[].class); // convert json to foodcategory[]
        List<Bill> listBill = new LinkedList<>(Arrays.asList(bills));
        return listBill;
    }

    public List<BillInfo> getBillInfo(int id) throws IOException {
        String rawJson = mySqlConnection.executeQuery(Query.getBillInfo, new Object[]{id});
        if (rawJson == null)
            return null;
        BillInfo[] bills = json.fromJson(rawJson, BillInfo[].class); // convert json to foodcategory[]
        List<BillInfo> listBill = new LinkedList<>(Arrays.asList(bills));
        return listBill;

    }

    public class Bill {
        @SerializedName("ID")
        public int id;
        @SerializedName("IDTable")
        public int idtable;
        @SerializedName("Name")
        public String table;
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


        public Bill(int id, int idtable, String checkin, String checkout, Double discount, Double price, String name) {
            this.id = id;
            this.idtable = idtable;
            this.checkin = checkin;
            this.checkout = checkout;
            this.discount = discount;
            this.price = price;
            this.username = name;
        }

        public Bill() {
        }

        public Bill(int id) {
            this.id = id;
        }

        @Override
        public String toString() {
            String str =
                    "BILL : " + id + "\n" +
                            "Table: " + table + "\n" +
                            "Date Checkin: " + checkin + "\n" +
                            "Date Checkout: " + checkout + "\n" +
                            "Staff: " + username + "\n" +
                            "Discount: " + discount + "\n";
            return str;
        }
    }

    public class BillInfo {
        @SerializedName("IDFood")
        public int idFood;
        @SerializedName("Name")
        public String name;
        @SerializedName("Quantity")
        public int quantityDatabase;

        public int quantityNow = 0;
        public int totalDone = 0;
        private int quantityPre = 0;

        public BillInfo(String name) {
            this.name = name;
        }

        public BillInfo() {
        }

        public boolean getDone() {
            return quantityNow <= 0;
        }

        public void setDone(boolean value) {
            if (value) {
                totalDone += quantityNow;
                quantityPre = quantityNow;
                quantityNow = 0;
            } else {
                totalDone -= quantityPre;
                quantityNow = quantityPre;
                quantityPre = 0;
            }
        }

        @Override
        public String toString() {
            return name + ": " + quantityDatabase + "\n";
        }
    }
}
