package com.example.deepa;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import com.example.deepa.pecoravet.R;

public class HomePage extends AppCompatActivity implements View.OnClickListener {

Button btnfeed,btninsurance,btnvaccination,btnfeedbck,btnistatus;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home_page);
        btnfeed=(Button) findViewById(R.id.btnfeed);
        btninsurance=(Button) findViewById(R.id.btninsurance);
        btnvaccination=(Button) findViewById(R.id.btnvaccination);
        btnfeedbck=(Button) findViewById(R.id.btnfeedback);
        btnistatus=(Button)findViewById(R.id.btnistatus);
        btnfeed.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent in =new Intent(HomePage.this,FeedActivity.class);
                startActivity(in);
            }
        });
        btninsurance.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent in =new Intent(HomePage.this,InsuranceActivity.class);
                startActivity(in);
            }
        });
        btnvaccination.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent in =new Intent(HomePage.this,VaccinationActivity.class);
                startActivity(in);
            }
        });
        btnfeedbck.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent in =new Intent(HomePage.this,FeedbackActivity.class);
                startActivity(in);
            }
        });
        btnistatus.setOnClickListener(this);
    }

    @Override
    public void onClick(View view) {
        Intent in =new Intent(HomePage.this,InsuranceStatus.class);
        startActivity(in);

    }
}
