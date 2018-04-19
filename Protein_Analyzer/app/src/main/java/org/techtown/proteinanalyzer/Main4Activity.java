package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Main4Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main4);

        Intent myIntent4 = getIntent();
        String composition = myIntent4.getStringExtra("composition");
        TextView text4 = (TextView) findViewById(R.id.textView4);
        text4.setMovementMethod(new ScrollingMovementMethod());

        //Calculate amino acids length and composition

        String positive = "[RHK]";
        Pattern p = Pattern.compile(positive);
        Matcher m = p.matcher(composition);

        String negative = "[DE]";
        Pattern q = Pattern.compile(negative);
        Matcher n = q.matcher(composition);

        String nonpolar = "[GAVLMI]";
        Pattern r = Pattern.compile(nonpolar);
        Matcher o = r.matcher(composition);

        String polar = "[STCPNQ]";
        Pattern s = Pattern.compile(polar);
        Matcher t = s.matcher(composition);

        String aromatic = "[FYW]";
        Pattern b = Pattern.compile(aromatic);
        Matcher c = b.matcher(composition);

        int counter = 0;
        int positiveAA = 0;
        int negativeAA = 0;
        int nonpolarAA = 0;
        int polarAA = 0;
        int aromaticAA = 0;

        for (int i = 0; i < composition.length(); i++) {

        }
            if (m.lookingAt()) {
            }
            while (m.find()) {
                positiveAA++;

            }

            if (n.lookingAt()) {
            }
            while (n.find()) {
                negativeAA++;

            }

            if (o.lookingAt()) {
            }
            while (o.find()) {
                nonpolarAA++;

            }
            if (t.lookingAt()) {
            }
            while (t.find()) {
                polarAA++;

            }

            if (c.lookingAt()) {
            }
            while (c.find()) {
                aromaticAA++;

            }


            String positiveCharge = "<font color = '#EE0000'> <b> positively charged amino acids </b> </font>";
            String negativeCharge = "<font color = '#0000FF'> <b> negatively charged amino acids </b> </font>";
            String nonpolarCharge = "<font color = '#808080'> <b> non-polar amino acids </b> </font>";
            String polarCharge = "<font color = '#800080'> <b> polar amino acids </b> </font>";
            String aromaticCharge = "<font color = '#32CD32'> <b> aromatic amino acids </b> </font>";


            text4.setText(Html.fromHtml(
                    positiveAA + positiveCharge + "<br>" +
                            negativeAA + negativeCharge + "<br>" +
                            nonpolarAA + nonpolarCharge + "<br>" +
                            polarAA + polarCharge + "<br>" +
                            aromaticAA + aromaticCharge

            ));


        }


}
