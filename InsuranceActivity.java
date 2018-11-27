package com.example.deepa;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class InsuranceActivity extends AppCompatActivity {
    String iid[],iname[],pamount[],etagno[],payble[],insdate[];
    RecyclerView rinsurance;
    InsuranceBeanClass ibc;
    List<InsuranceBeanClass> lic;
    insuranceAdapter iadt;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_insurance);
        rinsurance = (RecyclerView) findViewById(R.id.rinsurance);

        lic = new ArrayList<>();

        web w = new web();
        w.execute();
    }
    public class web extends AsyncTask<String,String,String>
    {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w=new WebServiceCaller();
            w.setSoapObject("Insurance");
            w.callWebService();
            String response=w.getResponse();
            return response;

        }

        @Override
        protected void onPostExecute (String s) {
            super.onPostExecute(s);
            Toast.makeText(InsuranceActivity.this, s, Toast.LENGTH_SHORT).show();
            try {
                JSONArray ja=new JSONArray(s);
                JSONObject jb=null;
                iid=new String[ja.length()];
                iname=new String[ja.length()];
                pamount=new String[ja.length()];

                payble=new String[ja.length()];
                insdate=new String[ja.length()];

                for (int i=0;i<ja.length();i++)
                {
                    jb=ja.getJSONObject(i);

                    iid[i]=jb.getString("id");
                    iname[i]=jb.getString("iname");
                    pamount[i]=jb.getString("totamt");

                    payble[i]=jb.getString("amtpayable");
                    insdate[i]=jb.getString("insdate");


                    ibc=new InsuranceBeanClass();
                    ibc.setId(iid[i]);
                    ibc.setIname(iname[i]);
                    ibc.setTotamt(pamount[i]);

                    ibc.setAmtpayable(payble[i]);
                    ibc.setInsdate(insdate[i]);


                    lic.add(ibc);
                }
                iadt=new insuranceAdapter(lic,getApplicationContext());
                rinsurance.setLayoutManager(new LinearLayoutManager(getApplicationContext()));
                rinsurance.setAdapter(iadt);


            } catch (JSONException e) {
                e.printStackTrace();
                Log.d("Exception",e+"");
            }
        }
    }
}

