package com.example.deepa;

import android.content.Context;
import android.content.Intent;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.deepa.pecoravet.R;

import java.util.List;

/**
 * Created by DEEPA on 17-11-2018.
 */

public class insuranceAdapter extends RecyclerView.Adapter<insuranceAdapter.MyViewHolder> {
    Context context;
    InsuranceBeanClass ibc;
    List<InsuranceBeanClass>lic;

    public insuranceAdapter(List<InsuranceBeanClass> lic, Context applicationContext) {
        this.lic=lic;
        this.context=applicationContext;
    }

    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_row_insurance,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {
        ibc=lic.get(position);
        holder.tv_insname.setText(ibc.getIname());

        holder.tv_total.setText(ibc.getTotamt());
        holder.tv_payable.setText(ibc.getAmtpayable());
        holder.tv_duedate.setText(ibc.getInsdate());

    }

    @Override
    public int getItemCount() {
        return lic.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        TextView tv_insname,tv_total,tv_payable,tv_duedate,tv_apply;

        public MyViewHolder(View itemView) {
            super(itemView);
            tv_insname=(TextView) itemView.findViewById(R.id.tv_insname);

            tv_total=(TextView) itemView.findViewById(R.id.tv_total);
            tv_payable=(TextView) itemView.findViewById(R.id.tv_payable);
            tv_duedate=(TextView) itemView.findViewById(R.id.tv_duedate);
            tv_apply=(TextView) itemView.findViewById(R.id.tv_apply);
            tv_apply.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                int a=getAdapterPosition();
                ibc=lic.get(a);
                String insID=ibc.getId();
                    Intent in=new Intent(context.getApplicationContext(),ApplyInsurance.class);
                    in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    in.putExtra("InsuranceID",insID);
                    context.startActivity(in);

                }
            });
        }
    }
}
