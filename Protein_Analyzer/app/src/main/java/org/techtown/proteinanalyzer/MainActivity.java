package org.techtown.proteinanalyzer;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.request.target.GlideDrawableImageViewTarget;

public class MainActivity extends AppCompatActivity {



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //opening an images in Imageview using Glide api
        Button button = findViewById(R.id.button);
        EditText editText = findViewById(R.id.editText);
        ImageView imageView = (ImageView) findViewById(R.id.img1);
        GlideDrawableImageViewTarget imageViewTarget = new GlideDrawableImageViewTarget(imageView);
        Glide.with(this).load(R.drawable.logo3).into(imageViewTarget);




    }

    public void onButton1Clicked(View v) {

        //take user input and send to Main2Activity
        Intent myIntent = new Intent(this, Main11Activity.class);
        EditText editText = (EditText) findViewById(R.id.editText);
        myIntent.putExtra("number", editText.getText().toString());
        startActivity(myIntent);

    }







}