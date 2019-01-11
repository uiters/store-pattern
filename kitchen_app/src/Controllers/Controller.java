/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controllers;

/**
 *
 * @author thienlan
 */
public abstract class Controller {
    public abstract void insert(Object object); 
    public abstract void delete(Object object);
    public abstract void update(Object object);
    public abstract void loadFull();
}
