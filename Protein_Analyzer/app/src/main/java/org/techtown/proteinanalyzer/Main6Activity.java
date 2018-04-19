package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

public class Main6Activity extends AppCompatActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main6);


        Intent myIntent6 = getIntent();
        String function= myIntent6.getStringExtra("function");
        TextView text6 = (TextView) findViewById(R.id.textView6);
        text6.setMovementMethod(new ScrollingMovementMethod());

        text6.setText(Html.fromHtml(function));

    }
}
