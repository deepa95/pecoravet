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

public class VaccinationActivity extends AppCompatActivity {
    RecyclerView rvview;
    VaccinationBeanClass vbc;
    List<VaccinationBeanClass>lvc;
    VaccinationAdapter vadt;
    String vid[],tagno[],date[],itname[];

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_vaccination);
        rvview=(RecyclerView) findViewById(R.id.rvview);
        lvc=new ArrayList<>();
        web w=new web();
        w.execute();

    }

    private class web extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w=new WebServiceCaller();
            w.setSoapObject("Vaccination");

            w.callWebService();
            String response=w.getResponse();
            return response;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(VaccinationActivity.this,s, Toast.LENGTH_SHORT).show();
            try {
                JSONArray ja=new JSONArray(s);
                JSONObject jb=null;
                vid=new String[ja.length()];
                tagno=new String[ja.length()];
                date=new String[ja.length()];
                itname=new String[ja.length()];
                for (int i=0;i<ja.length();i++)
                {
                    jb=ja.getJSONObject(i);

                    vid[i]=jb.getString("id");
                    tagno[i]=jb.getString("tagno");
                    date[i]=jb.getString("date");
                    itname[i]=jb.getString("itemname");

                    vbc=new VaccinationBeanClass();
                    vbc.setId(vid[i]);
                    vbc.setTagno(tagno[i]);
                    vbc.setDate(date[i]);
                    vbc.setItemname(itname[i]);



                    lvc.add(vbc);
                }
                vadt=new VaccinationAdapter(lvc,getApplicationContext());
                rvview.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                rvview.setAdapter(vadt);



            } catch (JSONException e) {
                e.printStackTrace();
            }

        }
    }
}
