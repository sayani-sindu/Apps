package com.example.demoapplication;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import java.util.HashMap;

import so.plotline.insights.Listeners.PlotlineRedirectListener;
import so.plotline.insights.Plotline;

public class StudentDetailActivity extends AppCompatActivity {

    private TextView textDetailName;
    private TextView textDetailAge;
    private TextView textDetailCourse;
    private TextView textDetailAvatar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_student_detail);

        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }



        textDetailName = findViewById(R.id.textDetailName);
        textDetailAge = findViewById(R.id.textDetailAge);
        textDetailCourse = findViewById(R.id.textDetailCourse);
        textDetailAvatar = findViewById(R.id.textDetailAvatar);

        // ===== READING DATA FROM INTENT =====
        // getIntent() — gets the Intent that started this Activity.
        // The Intent was created in StudentsFragment with putExtra() calls.
        // getStringExtra("student_name") — reads the String value attached with key "student_name".
        // The KEY must be exactly the same string used in putExtra(). Case-sensitive.
        // WHAT IF KEY DOESN'T MATCH: Returns null → NullPointerException when you use it.
        Bundle extras = getIntent().getExtras();

        if (extras != null) {
            String name = extras.getString("student_name", "Unknown");
            // getInt(key, defaultValue) — reads an int. Second param is the default if key not found.
            int age = extras.getInt("student_age", 0);
            String course = extras.getString("student_course", "Unknown");

            // Update the UI with received data.
            textDetailName.setText(name);
            textDetailAge.setText("Age: " + age);
            textDetailCourse.setText(course);

            // Set avatar — first letter of name.
            if (!name.isEmpty()) {
                textDetailAvatar.setText(String.valueOf(name.charAt(0)).toUpperCase());
            }
        }
    }

    @Override
    public boolean onSupportNavigateUp() {
        finish();
        return true;
    }
}