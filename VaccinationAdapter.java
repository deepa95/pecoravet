package com.example.deepa;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.example.deepa.pecoravet.R;

import java.util.List;

/**
 * Created by DEEPA on 11-11-2018.
 */

public class VaccinationAdapter extends RecyclerView.Adapter<VaccinationAdapter.MyViewHolder> {

    Context context;
    VaccinationBeanClass vbc;
    List<VaccinationBeanClass>lvc;

    public VaccinationAdapter(List<VaccinationBeanClass> lvc, Context applicationContext) {
        this.lvc=lvc;
        this.context=applicationContext;
    }


    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_row_vaccination,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {

        vbc=lvc.get(position);
        holder.tv_tagno.setText(vbc.getTagno());
        holder.tv_vaccindate.setText(vbc.getDate());
        holder.tv_itemname.setText(vbc.getItemname());

    }

    @Override
    public int getItemCount() {
        return lvc.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        TextView tv_tagno,tv_vaccindate,tv_itemname;
        public MyViewHolder(View itemView) {
            super(itemView);
            tv_tagno=(TextView) itemView.findViewById(R.id.tv_tagno);
            tv_vaccindate=(TextView) itemView.findViewById(R.id.tv_vaccindate);
            tv_itemname=(TextView) itemView.findViewById(R.id.tv_itemname);

        }
    }
}
