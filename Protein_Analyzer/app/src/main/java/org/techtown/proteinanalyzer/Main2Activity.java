package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.os.AsyncTask;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;



public class Main2Activity extends AppCompatActivity {


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);


        Button button1 = (Button) findViewById(R.id.button1);
        Button button2 = (Button) findViewById(R.id.button2);
        Button button3 = (Button) findViewById(R.id.button3);
        Button button4 = (Button) findViewById(R.id.button4);
        Button button5 = (Button) findViewById(R.id.button5);
        Button button6 = (Button) findViewById(R.id.button6);
        Button button7 = (Button) findViewById(R.id.button7);

        //Assigning function to the button
        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findLength().execute();

            }

        });

        button2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findComp().execute();

            }

        });

        button3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findWeight().execute();

            }

        });

        button4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findFunction().execute();

            }

        });

        button5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findArticles().execute();

            }

        });

        button6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findFasta().execute();

            }

        });

        button7.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                new findName().execute();

            }

        });


    }

    public class findName extends AsyncTask<Void, Void, Void> {

        String name;


        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent = getIntent();
                String protein = myIntent.getStringExtra("number");

                //use protein ID to search for protein name
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId = protein;
                String html = URL + proteinId;

                Document doc = Jsoup.connect(html).get();
                Element divs = doc.select("div#content-protein > h1").first();



               name = divs.text();


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);


            //send protein name to Main9Activity
            Intent myIntent9 = new Intent(Main2Activity.this, Main9Activity.class);
            myIntent9.putExtra("name",name);
            startActivity(myIntent9);


        }


    }
    public class findLength extends AsyncTask<Void, Void, Void> {

                String sequence;

                @Override
                protected Void doInBackground(Void... params) {


                    try {

                        Intent myIntent2 = getIntent();
                        String protein = myIntent2.getStringExtra("number");

                        //use protein ID to search for protein sequence
                        String URL = "http://www.uniprot.org/uniprot/";
                        String proteinId = protein;
                        String html = URL + proteinId;

                        Document doc = Jsoup.connect(html).get();
                        Elements divs = doc.select("pre.sequence");



                        sequence = divs.text();


                    } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send protein function sequence to main3activity
            Intent myIntent3 = new Intent(Main2Activity.this, Main3Activity.class);
            myIntent3.putExtra("sequence",sequence);
            startActivity(myIntent3);


        }


    }

    public class findComp extends AsyncTask<Void, Void, Void> {

        String composition;

        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent4 = getIntent();
                String protein = myIntent4.getStringExtra("number");

                //use protein ID to search for protein sequence
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId = protein;
                String html = URL + proteinId;

                Document doc = Jsoup.connect(html).get();
                Elements divs = doc.select("pre.sequence");



                composition = divs.text();


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send protein function sequence to main3activity
            Intent myIntent4 = new Intent(Main2Activity.this, Main4Activity.class);
            myIntent4.putExtra("composition",composition);
            startActivity(myIntent4);


        }


    }

    public class findWeight extends AsyncTask<Void, Void, Void> {


        String weight;

        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent5 = getIntent();
                String protein = myIntent5.getStringExtra("number");

                //use protein ID to search for protein sequence
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId = protein;
                String html = URL + proteinId;

                Document doc = Jsoup.connect(html).get();
                Elements divs = doc.select("pre.sequence");



                weight = divs.text();


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send protein function sequence to main3activity
            Intent myIntent5 = new Intent(Main2Activity.this, Main5Activity.class);
            myIntent5.putExtra("weight",weight);
            startActivity(myIntent5);


        }


    }

    public class findFunction extends AsyncTask<Void, Void, Void> {

        String function;

        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent6 = getIntent();
                String protein = myIntent6.getStringExtra("number");

                //use protein ID to search for protein function
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId2 = protein;
                String html = URL + proteinId2;

                Document doc = Jsoup.connect(html).get();
                Elements divs = doc.select("div.annotation");
                Element divs2 = divs.get(0);
                doc.select("span[class*=attribution ECO]").remove();



                function = divs2.text();


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send protein function data to main4activity
            Intent myIntent6 = new Intent(Main2Activity.this, Main6Activity.class);
            myIntent6.putExtra("function", function);
            startActivity(myIntent6);


        }
    }

    public class findArticles extends AsyncTask<Void, Void, Void> {

        String article1;
        String article2;
        String article3;
        String article4;
        String article5;

        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent7 = getIntent();
                String protein = myIntent7.getStringExtra("number");

                //Use protein ID to search for publications
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId = protein.toUpperCase();
                String html = URL + proteinId;

                Document doc = Jsoup.connect(html + "/publications").get();
                Elements div1 = doc.select("li#ref1");
                Elements div2 = doc.select("li#ref2");
                Elements div3 = doc.select("li#ref3");
                Elements div4 = doc.select("li#ref4");
                Elements div5 = doc.select("li#ref5");


                article1 = div1.text();
                article2 = div2.text();
                article3 = div3.text();
                article4 = div4.text();
                article5 = div5.text();

            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send protein publication data to main6activity
            Intent myIntent7 = new Intent(Main2Activity.this, Main7Activity.class);
            myIntent7.putExtra("article1", article1);
            myIntent7.putExtra("article2", article2);
            myIntent7.putExtra("article3", article3);
            myIntent7.putExtra("article4", article4);
            myIntent7.putExtra("article5", article5);
            startActivity(myIntent7);


        }
    }


    public class findFasta extends AsyncTask<Void, Void, Void> {

        String fasta;

        @Override
        protected Void doInBackground(Void... params) {


            try {

                Intent myIntent8 = getIntent();
                String protein = myIntent8.getStringExtra("number");

                //Use protein ID to search for raw protein sequence
                String URL = "http://www.uniprot.org/uniprot/";
                String proteinId = protein;
                String html = URL + proteinId;

                Document doc = Jsoup.connect(html+".fasta").get();




                fasta = doc.body().text();


            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void aVoid) {
            super.onPostExecute(aVoid);

            //Send raw protein sequence data to main5activity
            Intent myIntent8 = new Intent(Main2Activity.this, Main8Activity.class);
            myIntent8.putExtra("fasta", fasta);
            startActivity(myIntent8);


        }
    }





}
