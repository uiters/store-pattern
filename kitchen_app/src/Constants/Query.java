/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Constants;

/**
 *
 * @author thienlan
 */
public class Query {
    
     
    
    //bill
    public static String getOrder="call USP_Admin_GetOrders() ";
    public static String getBillInfo="call USP_Admin_GetFoodFromBill( @ID ) ";

    //login
    public static String checkLogin="call USP_Admin_CheckLogin( @username  )";
    
    //report
    public static String getReport="call USP_Admin_GetReport( @date  )";
    
    
            
}
