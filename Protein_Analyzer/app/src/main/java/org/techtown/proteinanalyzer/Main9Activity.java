package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

public class Main9Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main9);


        Intent myIntent9 = getIntent();
        String name= myIntent9.getStringExtra("name");
        TextView textView9= (TextView) findViewById(R.id.textView9);
        textView9.setMovementMethod(new ScrollingMovementMethod());

        textView9.setText(name);

    }
}
