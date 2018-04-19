package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.widget.TextView;

import java.math.BigDecimal;

public class Main5Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main5);

        Intent myIntent5 = getIntent();
        String weight = myIntent5.getStringExtra("weight");
        TextView text5 = (TextView) findViewById(R.id.textView5);
        text5.setMovementMethod(new ScrollingMovementMethod());

        //counting amino acids composition

        double totalMW =0.0;

        for (int i =0 ;i< weight.length();i++) {

            if (weight.charAt(i) == 'A') {

                totalMW += 89.09;

            } else if (weight.charAt(i) == 'C') {

                totalMW += 121.15;

            } else if (weight.charAt(i) == 'D') {

                totalMW += 133.10;

            } else if (weight.charAt(i) == 'E') {

                totalMW += 147.13;

            } else if (weight.charAt(i)== 'F') {

                totalMW += 165.19;

            } else if (weight.charAt(i) == 'G') {

                totalMW += 75.07;

            } else if (weight.charAt(i) == 'H') {

                totalMW += 155.16;

            } else if (weight.charAt(i) == 'I') {

                totalMW += 131.17;

            } else if (weight.charAt(i) == 'K') {

                totalMW += 146.19;

            } else if (weight.charAt(i) == 'L') {

                totalMW += 131.17;

            } else if (weight.charAt(i) == 'M') {

                totalMW += 149.21;

            } else if (weight.charAt(i) == 'N') {

                totalMW += 132.12;

            } else if (weight.charAt(i)== 'P') {

                totalMW += 115.13;

            } else if (weight.charAt(i) == 'Q') {

                totalMW += 146.15;

            } else if (weight.charAt(i) == 'R') {

                totalMW += 174.20;

            } else if (weight.charAt(i) == 'S') {

                totalMW += 105.09;

            } else if (weight.charAt(i) == 'T') {

                totalMW += 119.12;

            } else if (weight.charAt(i) == 'V') {

                totalMW += 117.15;

            } else if (weight.charAt(i) == 'W') {

                totalMW += 204.23;

            } else if (weight.charAt(i) == 'Y') {

                totalMW += 181.19;
            }
        }

            //convert to kilodalton
            int totalMW2 = (int)(totalMW / 1000);
            String totalPWM = Integer.toString(totalMW2);
            text5.setText(Html.fromHtml(totalPWM+" kDa (kilodaltons)"));
    }
}
