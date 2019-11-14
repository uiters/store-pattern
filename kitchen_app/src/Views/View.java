/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Views;

/**
 * @author Thang Le
 */
public abstract class View {
    abstract void insert(Object object); //for add

    abstract void delete(int row); //for delete

    abstract void update(int row, Object object);//for update

    abstract void loadView(Object objects); //load full
}
