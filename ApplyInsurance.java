package com.example.deepa;

import android.app.DatePickerDialog;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

import org.json.JSONArray;
import org.json.JSONObject;

import java.util.Calendar;

public class ApplyInsurance extends AppCompatActivity implements AdapterView.OnItemSelectedListener, View.OnClickListener {
    EditText et_name;
    EditText et_addr;
    EditText et_contact;
    EditText et_email;
    EditText et_cattleno;

    TextView tv_date;
    Spinner sp_caste, sp_insname, sp_tagno;
    Button btnsubmit, btncancel;

    ArrayAdapter<String> casteadapter;
    ArrayAdapter<String> insadapter;
    ArrayAdapter<String> tagadapter;

    String insurancename[];
    String insuranceid[];

    String tagid[];
    String tagno[];

    String premiumid[];
    private int mYear, mMonth, mDay;

    String casteid[] = {"0", "1", "2", "3", "4"};
    String castename[] = {"--SELECT--", "SC", "ST", "OBC", "GENERAL"};

    String cid, inid, tid;
    String uid="";
    String dt = "";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_apply_insurance);
        et_name = (EditText) findViewById(R.id.et_name);
        et_addr = (EditText) findViewById(R.id.et_addr);
        et_contact = (EditText) findViewById(R.id.et_contact);
        et_email = (EditText) findViewById(R.id.et_email);
        sp_caste = (Spinner) findViewById(R.id.sp_caste);
        sp_insname = (Spinner) findViewById(R.id.sp_insname);
        tv_date = (TextView) findViewById(R.id.tv_date);

        et_cattleno = (EditText) findViewById(R.id.et_cattleno);
        sp_tagno = (Spinner) findViewById(R.id.sp_tagno);
        btnsubmit = (Button) findViewById(R.id.btnsubmit);
        btncancel = (Button) findViewById(R.id.btncancel);

        SharedPreferences sh = getSharedPreferences("MyData", MODE_PRIVATE);
        uid = sh.getString("userid", "");

        insu in = new insu();
        in.execute();

        web cd = new web();
        cd.execute(uid);

        casteadapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, castename);
        casteadapter.setDropDownViewResource(android.R.layout.simple_spinner_item);
        sp_caste.setAdapter(casteadapter);

//        sp_caste.setOnItemSelectedListener(this);
//        sp_insname.setOnItemSelectedListener(this);
//        sp_tagno.setOnItemSelectedListener(this);

        tv_date.setOnClickListener(this);

        btnsubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String name = et_name.getText().toString();
                String address = et_addr.getText().toString();
                String contact = et_contact.getText().toString();
                String email = et_email.getText().toString();
                String catno = et_cattleno.getText().toString();

                cid = casteid[sp_caste.getSelectedItemPosition()];
                inid = insuranceid[sp_insname.getSelectedItemPosition()];
                tid = tagid[sp_tagno.getSelectedItemPosition()];

                appins ai = new appins();
                ai.execute(uid, cid, inid, tid, dt);


            }
        });

    }


    @Override
    public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {



    }

    @Override
    public void onNothingSelected(AdapterView<?> adapterView) {

    }

    @Override
    public void onClick(View view) {
        final Calendar c = Calendar.getInstance();
        mYear = c.get(Calendar.YEAR);
        mMonth = c.get(Calendar.MONTH);
        mDay = c.get(Calendar.DAY_OF_MONTH);


        DatePickerDialog datePickerDialog = new DatePickerDialog(ApplyInsurance.this, new DatePickerDialog.OnDateSetListener() {

            @Override
            public void onDateSet(DatePicker view, int year,
                                  int monthOfYear, int dayOfMonth) {

                tv_date.setText(year + "-" + (monthOfYear + 1) + "-" + dayOfMonth);
                dt = dayOfMonth + "-" + (monthOfYear + 1) + "-" + year;
            }
        }, mYear, mMonth, mDay);

        datePickerDialog.show();

    }


    public class insu extends AsyncTask<String, String, String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller wc = new WebServiceCaller();
            wc.setSoapObject("GetInsurance");
            wc.callWebService();
            return wc.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
//            Toast.makeText(ApplyInsurance.this, "" + s, Toast.LENGTH_SHORT).show();
            Log.d("Details", s);
            try {
                JSONArray ja = new JSONArray(s);
                JSONObject jb = null;

                insuranceid = new String[ja.length()];
                insurancename = new String[ja.length()];
                premiumid = new String[ja.length()];

                for (int i = 0; i < ja.length(); i++) {
                    jb = ja.getJSONObject(i);

                    insuranceid[i] = jb.getString("typeid");
                    insurancename[i] = jb.getString("iname");
                    premiumid[i] = jb.getString("premiumid");
                }

                insadapter = new ArrayAdapter<String>(ApplyInsurance.this, android.R.layout.simple_spinner_item, insurancename);
                insadapter.setDropDownViewResource(android.R.layout.simple_spinner_item);
                sp_insname.setAdapter(insadapter);
            } catch (Exception ex) {

            }

        }
    }


    public class appins extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w = new WebServiceCaller();
            w.setSoapObject("ApplyInsurance");
            w.addProperty("user_id", strings[0]);
            w.addProperty("caste", strings[1]);
            w.addProperty("insurancename", strings[2]);
            w.addProperty("eartagno", strings[3]);
            w.addProperty("date", strings[4]);
            w.callWebService();
            String response = w.getResponse();
            return response;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(ApplyInsurance.this, s, Toast.LENGTH_SHORT).show();
        }
    }


    public class web extends AsyncTask<String, String, String> {

        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w = new WebServiceCaller();
            w.setSoapObject("Gettagno");
            w.addProperty("uid",strings[0]);
            w.callWebService();
            return w.getResponse();
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(ApplyInsurance.this, "" + s, Toast.LENGTH_SHORT).show();
            Log.d("Details", s);
            try {
                JSONArray ja = new JSONArray(s);
                JSONObject jb = null;

                tagid = new String[ja.length()];
                tagno = new String[ja.length()];


                for (int i = 0; i < ja.length(); i++) {
                    jb = ja.getJSONObject(i);

                    tagid[i] = jb.getString("tagid");
                    tagno[i] = jb.getString("tagno");

                }

                tagadapter = new ArrayAdapter<String>(ApplyInsurance.this, android.R.layout.simple_spinner_item, tagno);
                tagadapter.setDropDownViewResource(android.R.layout.simple_spinner_item);
                sp_tagno.setAdapter(tagadapter);

            }
            catch (Exception ex) {
Log.d("Exception",ex+"");
            }

        }
    }
}


