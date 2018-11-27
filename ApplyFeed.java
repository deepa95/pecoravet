package com.example.deepa;

import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

import org.json.JSONArray;
import org.json.JSONObject;

public class ApplyFeed extends AppCompatActivity implements View.OnClickListener {
    EditText et_name;
    EditText et_addr;
    EditText et_contact;
    EditText et_email;
    EditText et_fname;
    EditText et_fqty;
    Spinner sp_feed;
    Button btnsubmit;
    Button btncancel;

    String feedname[];
    String feedid[];

    ArrayAdapter<String> feedadapter;
    String fid;
    String uid="";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_apply_feed);
        et_name = (EditText) findViewById(R.id.et_name);
        et_addr = (EditText) findViewById(R.id.et_addr);
        et_contact = (EditText) findViewById(R.id.et_contact);
        et_email = (EditText) findViewById(R.id.et_email);
        sp_feed=(Spinner)findViewById(R.id.sp_feed);
        et_fqty=(EditText)findViewById(R.id.et_fqty);
        btnsubmit = (Button) findViewById(R.id.btnsubmit);
        btncancel = (Button) findViewById(R.id.btncancel);
        btnsubmit.setOnClickListener(this);
        SharedPreferences sh = getSharedPreferences("MyData", MODE_PRIVATE);
        uid = sh.getString("userid", "");

        web w1=new web();
        w1.execute();

    }

    @Override
    public void onClick(View view) {
        String name = et_name.getText().toString();
        String address = et_addr.getText().toString();
        String contact = et_contact.getText().toString();
        String email = et_email.getText().toString();
        String fname=et_fname.getText().toString();
        String fqty=et_fqty.getText().toString();
        fid = feedid[sp_feed.getSelectedItemPosition()];

        appfeed ai = new appfeed();
        ai.execute(uid,fid,fqty);
    }

    public class appfeed extends AsyncTask<String,String,String>{

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w = new WebServiceCaller();
            w.setSoapObject("Applyfeed");
            w.addProperty("user_id", strings[0]);
            w.addProperty("feedname", strings[1]);
            w.addProperty("qty", strings[2]);
            w.callWebService();
            String response = w.getResponse();
            return response;

        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(ApplyFeed.this, s, Toast.LENGTH_SHORT).show();
        }
    }

    public class web extends AsyncTask<String,String,String>{

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wf=new WebServiceCaller();
            wf.setSoapObject("Getfeed");

            wf.callWebService();
            return wf.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            Toast.makeText(ApplyFeed.this, "" + s, Toast.LENGTH_SHORT).show();
            Log.d("Details", s);
            try {
                JSONArray ja = new JSONArray(s);
                JSONObject jb = null;

                feedid = new String[ja.length()];
                feedname = new String[ja.length()];


                for (int i = 0; i < ja.length(); i++) {
                    jb = ja.getJSONObject(i);

                    feedid[i] = jb.getString("feedid");
                    feedname[i] = jb.getString("feedname");

                }

                feedadapter = new ArrayAdapter<String>(ApplyFeed.this, android.R.layout.simple_spinner_item, feedname);
                feedadapter.setDropDownViewResource(android.R.layout.simple_spinner_item);
                sp_feed.setAdapter(feedadapter);

            }
            catch (Exception ex) {
                Log.d("Exception",ex+"");
            }

        }
    }

}
