package com.example.deepa;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.example.deepa.pecoravet.R;

public class Login extends AppCompatActivity {
    EditText et_username,et_password;
    Button btnlogin;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        et_username=(EditText)findViewById(R.id.et_username);
        et_password=(EditText)findViewById(R.id.et_password);
        btnlogin=(Button)findViewById(R.id.btnlogin);
        btnlogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String uname=et_username.getText().toString();
                String pass=et_password.getText().toString();

                web w=new web();
                w.execute(uname,pass);

            }
        });
    }

    private class web extends AsyncTask<String,String,String> {
        @Override
        protected String doInBackground(String... strings) {
            WebServiceCaller w=new WebServiceCaller();
            w.setSoapObject("Login");
            w.addProperty("Username",strings[0]);
            w.addProperty("Password",strings[1]);
            w.callWebService();
            String response=w.getResponse();
            return response;

        }

        @Override
        protected void onPostExecute(String s) {
            super.onPostExecute(s);
            Toast.makeText(Login.this,s, Toast.LENGTH_SHORT).show();
            String data[]=s.split(":");
            String id=data[0];
            String msg=data[1];

            if (msg.equals("Success"))
            {

                SharedPreferences sh=getSharedPreferences("MyData",MODE_PRIVATE);
                SharedPreferences.Editor editor=sh.edit();
                editor.putString("userid",id);
                editor.commit();
                Intent in =new Intent(Login.this,HomePage.class);
                startActivity(in);
            }
        }
    }

}
