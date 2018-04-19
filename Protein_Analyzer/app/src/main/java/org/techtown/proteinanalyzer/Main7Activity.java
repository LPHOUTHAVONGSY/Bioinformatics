package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;

public class Main7Activity extends AppCompatActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main7);


       populateListView();

       }
    private void populateListView(){

        //Get data and Print 5 articles
        Intent myIntent7 = getIntent();
        String article1 = myIntent7.getStringExtra("article1");
        String article2 = myIntent7.getStringExtra("article2");
        String article3 = myIntent7.getStringExtra("article3");
        String article4 = myIntent7.getStringExtra("article4");
        String article5 = myIntent7.getStringExtra("article5");

        //Print out data in a listview
        String[] List = {article1,article2,article3,article4,article5};
        ArrayAdapter <String> adapter = new ArrayAdapter<String>(this,R.layout.listview1,List);
        ListView Li7 = (ListView)findViewById(R.id.ListView7);
        Li7.setAdapter(adapter);

    }
}
