package com.example.deepa;

import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

public class Registration extends AppCompatActivity {
    EditText et_name,et_addr,et_dob,et_contact,et_email,et_user,et_pass;
    RadioButton rb_male,rb_female;
    RadioGroup rgb;
    Button btnsubmit,btncancel;
    String gender;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registration2);
        et_name=(EditText)findViewById(R.id.et_name);
        et_addr=(EditText) findViewById(R.id.et_addr);
        rb_male=(RadioButton)findViewById(R.id.rb_male);
        rb_female=(RadioButton)findViewById(R.id.rb_female);
        rgb=(RadioGroup)findViewById(R.id.rgb);
        et_dob=(EditText) findViewById(R.id.et_dob);
        et_contact=(EditText) findViewById(R.id.et_contact);
        et_email=(EditText) findViewById(R.id.et_email);
        et_user=(EditText) findViewById(R.id.et_user);
        et_pass=(EditText) findViewById(R.id.et_pass);
        btnsubmit=(Button)findViewById(R.id.btnsubmit);
        btncancel=(Button)findViewById(R.id.btncancel);


        rgb.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                if (i==R.id.rb_male){
                    gender="Male";
                }
               else if (i==R.id.rb_female){
                    gender="Female";
                }
            }
        });



        btnsubmit.setOnClickListener(new View.OnClickListener() {


            @Override
            public void onClick(View view) {
                String name=et_name.getText().toString();
                String address=et_addr.getText().toString();
                String dob=et_dob.getText().toString();
                String contact=et_contact.getText().toString();
                String email=et_email.getText().toString();
                String user=et_user.getText().toString();
                String pass=et_pass.getText().toString();


                web w=new web();
                w.execute(name,address,gender,dob,contact,email,user,pass);

            }
        });







    }

    private class web extends AsyncTask<String,String,String>{
        @Override
        protected String doInBackground(String... strings) {

            WebServiceCaller w=new WebServiceCaller();
            w.setSoapObject("Registration");
            w.addProperty("name",strings[0]);
            w.addProperty("address",strings[1]);
            w.addProperty("gender",strings[2]);
            w.addProperty("dob",strings[3]);
            w.addProperty("contact",strings[4]);
            w.addProperty("email",strings[5]);
            w.addProperty("user",strings[6]);
            w.addProperty("pass",strings[7]);

            w.callWebService();
            String response=w.getResponse();
            return response;
        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);


            Toast.makeText(Registration.this,s, Toast.LENGTH_SHORT).show();
        }
    }
}
