package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

public class Main3Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);

        Intent myIntent3 = getIntent();
        String sequence = myIntent3.getStringExtra("sequence");
        TextView text3 = (TextView) findViewById(R.id.textView3);
        text3.setMovementMethod(new ScrollingMovementMethod());

        text3.setText(sequence);

        //counting protein sequence length from the extracted data
        int counter = 0;
        for (int i = 0; i < sequence.length(); i++) {
          if (Character.isLetter(sequence.charAt(i)))
               counter++;
        }

        String count = Integer.toString(counter);

        text3.setText(count+" total amino acids residues");


       }



}



