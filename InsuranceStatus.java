package com.example.deepa;

import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

public class InsuranceStatus extends AppCompatActivity implements View.OnClickListener {
    TextView tv_istatus;
    String uid="";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_insurance_status);
        tv_istatus=(TextView)findViewById(R.id.tv_istatus);
        tv_istatus.setOnClickListener(this);
        SharedPreferences sh = getSharedPreferences("MyData", MODE_PRIVATE);
        uid = sh.getString("userid", "");
    }

    @Override
    public void onClick(View view) {
        web w=new web();
        w.execute(uid);

    }
    public class web extends AsyncTask<String,String,String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w = new WebServiceCaller();
            w.setSoapObject("Insurancestatus");
            w.callWebService();
            String response=w.getResponse();
            return response;

        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(InsuranceStatus.this,s, Toast.LENGTH_SHORT).show();
        }
    }

}
