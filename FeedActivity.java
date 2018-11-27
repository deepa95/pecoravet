package com.example.deepa;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class FeedActivity extends AppCompatActivity {
    RecyclerView rview;
    FeedBeanClass fbc;
    List<FeedBeanClass>lfc;
    FeedAdapter fadt;
    String feedid[],feedname[],feedprice[],feedqnty[];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_feed);
        rview=(RecyclerView)findViewById(R.id.rview);

        lfc=new ArrayList<>();

        web w=new web();
        w.execute();

    }

    private class web extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w=new WebServiceCaller();
            w.setSoapObject("Feed");

            w.callWebService();
            String response=w.getResponse();
            return response;


        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(FeedActivity.this, s, Toast.LENGTH_SHORT).show();
            try {
                JSONArray ja=new JSONArray(s);
                JSONObject jb=null;
                feedid=new String[ja.length()];
                feedname=new String[ja.length()];
                feedprice=new String[ja.length()];
                feedqnty=new String[ja.length()];

                for (int i=0;i<ja.length();i++)
                {
                    jb=ja.getJSONObject(i);

                    feedid[i]=jb.getString("id");
                    feedname[i]=jb.getString("name");
                    feedprice[i]=jb.getString("rate");
                    feedqnty[i]=jb.getString("quantity");

                    fbc=new FeedBeanClass();
                    fbc.setName(feedname[i]);
                    fbc.setId(feedid[i]);
                    fbc.setPrice(feedprice[i]);
                    fbc.setQnty(feedqnty[i]);


                    lfc.add(fbc);
                }
                fadt=new FeedAdapter(lfc,getApplicationContext());
                rview.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                rview.setAdapter(fadt);


            } catch (JSONException e) {
                e.printStackTrace();
            }
        }
    }
}
