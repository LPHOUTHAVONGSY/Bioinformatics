package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.Html;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;

public class Main11Activity extends AppCompatActivity {

    TextView TextView11;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main11);

        EditText editText = (EditText)findViewById(R.id.editText11);
        TextView11 = (TextView) findViewById(R.id.textView11);
        TextView11.setMovementMethod(new ScrollingMovementMethod());
        Button button11 = (Button)findViewById(R.id.button11);
        new findID().execute();

    }
    public void onButton11Clicked(View v){

        //take user input and send to Main2Activity
        Intent myIntent= new Intent (this,Main2Activity.class);
        EditText editText = (EditText)findViewById(R.id.editText11);
        myIntent.putExtra("number", editText.getText().toString());
        startActivity(myIntent);

    }

    public class findID extends AsyncTask<Void, Void, Void> {



        String word;
        String word2;



        @Override
        protected Void doInBackground(Void... params) {

            ArrayList<String> proteinName = new ArrayList<String>();


            try {


                Intent myIntent10 = getIntent();
                String protein = myIntent10.getStringExtra("number");

                String SEARCH_STRING = protein;
                String URL = "http://www.uniprot.org/uniprot/";
                String query = "?query=";
                String score = "&sort=score";

                String html = URL + query + SEARCH_STRING + score;

                Document doc = Jsoup.connect(html).get();

                //Extracting protein IDs and protein Names
                for (Element table : doc.select("table")) {
                    for (Element row : table.select("tr")) {
                        Elements tds = row.select("td");
                        if (tds.size() > 8) {
                            proteinName.add(tds.get(1).text() + ": " + tds.get(4).text());

                        }

                    }
                }

                //lists protein IDs and protein names from the extracted table in a ListView
                for(int i = 0; i < 11; i++){
                    TextView11.setText(Html.fromHtml(proteinName.get(0)+"<br>"+"<br>"+proteinName.get(1)+"<br>"+"<br>"+proteinName.get(2)+
                            "<br>"+"<br>"+proteinName.get(3)+"<br>"+"<br>"+proteinName.get(4)+"<br>"+"<br>"+proteinName.get(5)+"<br>"+"<br>"+proteinName.get(6)+"<br>"+"<br>"+proteinName.get(7)
                            +"<br>"+"<br>"+proteinName.get(8)+"<br>"+"<br>"+proteinName.get(9)+"<br>"+"<br>"+proteinName.get(10)

                    ));

                }


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);


        }


    }
}
