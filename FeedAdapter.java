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
 * Created by DEEPA on 11-11-2018.
 */

public class FeedAdapter extends RecyclerView.Adapter<FeedAdapter.MyViewHolder> {

    Context context;
    FeedBeanClass fbc;
    List<FeedBeanClass>lfc;

    public FeedAdapter(List<FeedBeanClass> lfc, Context applicationContext) {
        this.lfc=lfc;
        this.context=applicationContext;
    }


    @Override
    public MyViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View itemView= LayoutInflater.from(parent.getContext()).inflate(R.layout.single_row_feed,parent,false);
        return new MyViewHolder(itemView);
    }

    @Override
    public void onBindViewHolder(MyViewHolder holder, int position) {

        fbc=lfc.get(position);
        holder.tv_feedname.setText(fbc.getName());
        holder.tv_feedprice.setText(fbc.getPrice());
        holder.tv_feedremain.setText(fbc.getQnty());
    }

    @Override
    public int getItemCount() {
        return lfc.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder {
        TextView tv_feedname,tv_feedprice,tv_feedremain,tv_apply;

        public MyViewHolder(View itemView) {
            super(itemView);

            tv_feedname=(TextView)itemView.findViewById(R.id.tv_feedname);
            tv_feedprice=(TextView)itemView.findViewById(R.id.tv_feedprice);
            tv_feedremain=(TextView)itemView.findViewById(R.id.tv_feedremain);
            tv_apply=(TextView) itemView.findViewById(R.id.tv_apply);
            tv_apply.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {

                    int a=getAdapterPosition();
                    fbc=lfc.get(a);
                    String feedID=fbc.getId();
                    Intent in=new Intent(context.getApplicationContext(),ApplyFeed.class);
                    in.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    in.putExtra("Feedid",feedID);
                    context.startActivity(in);

                }
            });

        }
    }
}
