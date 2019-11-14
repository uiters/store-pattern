/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import Constants.Constant;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;


/**
 * @author thienlan
 */
public class MySqlConnection {
    private MySqlConnection() {
    }

    private static MySqlConnection _instance = null;

    public static MySqlConnection getInstance() {
        if (_instance == null)
            _instance = new MySqlConnection();
        return _instance;
    }


    public String executeQuery(String query, Object[] parameter) throws IOException {
        if (parameter != null)
            query = addParameter(query, parameter);
        return openConnection(query, Constant.keyQuery);
    }

    public String executeNoneQuery(String query, Object[] parameter) throws IOException {
        if (parameter != null)
            query = addParameter(query, parameter);
        return openConnection(query, Constant.keyNoneQuery);
    }

    private String openConnection(String query, String keyQuery) throws UnsupportedEncodingException, IOException {

        HttpClient client = HttpClients.createDefault();
        ArrayList<NameValuePair> params = new ArrayList<>();
        HttpPost post = new HttpPost(Constant.urlConnect);
        NameValuePair data = new BasicNameValuePair(keyQuery, query);
        params.add(data);
        post.setEntity(new UrlEncodedFormEntity(params, "UTF-8"));

        HttpResponse respone = client.execute(post);
        HttpEntity entity = null;
        if (respone.getStatusLine().getStatusCode() == 200) {
            entity = respone.getEntity();
        }
        if (entity == null)
            return null;
        else
            return EntityUtils.toString(entity);
    }

    private String addParameter(String query, Object[] parameter) {
        String[] list = query.split(" ");
        query = "";
        int i = 0;
        for (String element : list) {
            if (parameter.length > i && element.contains("@")) {
                String prepare = "\'" + parameter[i++].toString() + "\'";
                if (element.contains(","))
                    prepare += ',';
                query += prepare;
            } else query += element;
            query += " ";
        }
        return query;
    }
}
