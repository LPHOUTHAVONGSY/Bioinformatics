package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main8Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main8);
        Intent myIntent8 = getIntent();
        String fasta = myIntent8.getStringExtra("fasta");
        TextView text8 = (TextView)findViewById(R.id.textView8);
        text8.setMovementMethod(new ScrollingMovementMethod());


        //Using regular expression to remove white-space in fasta file
        String trim  = " ";
        Pattern b = Pattern.compile(trim);
        Matcher c = b.matcher(fasta);
        if (c.lookingAt()){

        }
        while (c.find()){
            fasta =fasta.replaceAll(" ","");
        }

        //Using regular expression to remove fasta file header
        String rawSequence = fasta.replaceAll(">\\S*SV=\\d","");

        //Using for loop to iterate through each letter of protein sequence and add colors based on their amino acid properties
        String colorSequence="";

        for (int i =0 ;i< rawSequence.length();i++) {

            if (rawSequence.charAt(i) == 'A') {
                colorSequence += "<font color = '#808080'>A</font>";

            } else if (rawSequence.charAt(i) == 'C') {
                colorSequence += "<font color = '#800080'>C</font>";

            } else if (rawSequence.charAt(i) == 'D') {
                colorSequence += "<font color = '#0000FF'>D</font>";

            } else if (rawSequence.charAt(i) == 'E') {
                colorSequence += "<font color = '#0000FF'>E</font>";

            } else if (rawSequence.charAt(i)== 'F') {
                colorSequence += "<font color = '#32CD32'>F</font>";

            } else if (rawSequence.charAt(i) == 'G') {
                colorSequence += "<font color = '#808080'>G</font>";

            } else if (rawSequence.charAt(i) == 'H') {
                colorSequence += "<font color = '#EE0000'>H</font>";

            } else if (rawSequence.charAt(i) == 'I') {
                colorSequence += "<font color = '#808080'>I</font>";

            } else if (rawSequence.charAt(i) == 'K') {
                colorSequence += "<font color = '#EE0000'>K</font>";

            } else if (rawSequence.charAt(i) == 'L') {
                colorSequence += "<font color = '#808080'>L</font>";

            } else if (rawSequence.charAt(i) == 'M') {
                colorSequence += "<font color = '#808080'>M</font>";

            } else if (rawSequence.charAt(i) == 'N') {
                colorSequence += "<font color = '#800080'>N</font>";

            } else if (rawSequence.charAt(i)== 'P') {
                colorSequence += "<font color = '#800080'>P</font>";

            } else if (rawSequence.charAt(i) == 'Q') {
                colorSequence += "<font color = '#800080'>Q</font>";

            } else if (rawSequence.charAt(i) == 'R') {
                colorSequence += "<font color = '#EE0000'>R</font>";

            } else if (rawSequence.charAt(i) == 'S') {
                colorSequence += "<font color = '#800080'>S</font>";

            } else if (rawSequence.charAt(i) == 'T') {
                colorSequence += "<font color = '#800080'>T</font>";

            } else if (rawSequence.charAt(i) == 'V') {
                colorSequence += "<font color = '#808080'>V</font>";

            } else if (rawSequence.charAt(i) == 'W') {
                colorSequence += "<font color = '#32CD32'>W</font>";

            } else if (rawSequence.charAt(i) == 'Y') {
                colorSequence += "<font color = '#32CD32'>Y</font>";
            }
        }

        text8.setText(Html.fromHtml(colorSequence));



    }
}
