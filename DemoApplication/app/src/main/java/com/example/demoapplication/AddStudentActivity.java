package com.example.demoapplication;


import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;

import com.google.android.material.textfield.TextInputEditText;

import java.util.HashMap;

import so.plotline.insights.Listeners.PlotlineRedirectListener;
import so.plotline.insights.Plotline;

public class AddStudentActivity extends AppCompatActivity {

    // These are the input fields — the user types into these.
    private TextInputEditText editName;
    private TextInputEditText editAge;
    private TextInputEditText editCourse;
    private Button btnSave;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_student);

        // Set up Toolbar with back button
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        // setDisplayHomeAsUpEnabled(true) — shows the back arrow (←) in the Toolbar.
        // When tapped, it calls onSupportNavigateUp() which we handle below.
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }

        // Find the input fields and button.
        editName = findViewById(R.id.editName);
        editAge = findViewById(R.id.editAge);
        editCourse = findViewById(R.id.editCourse);
        btnSave = findViewById(R.id.btnSaveStudent);

        btnSave.setOnClickListener(v -> {
            saveStudent();
            Plotline.track("Event123");
            


        });


    }

    private void saveStudent() {
        String name = editName.getText().toString().trim();
        String ageStr = editAge.getText().toString().trim();
        String course = editCourse.getText().toString().trim();

        if (TextUtils.isEmpty(name)) {
            editName.setError("Please enter a name");
            editName.requestFocus();
            return;
        }
        if (TextUtils.isEmpty(ageStr)) {
            editAge.setError("Please enter an age");
            editAge.requestFocus();
            return;
        }
        if (TextUtils.isEmpty(course)) {
            editCourse.setError("Please enter a course");
            editCourse.requestFocus();
            return;
        }

        int age;
        try {
            age = Integer.parseInt(ageStr);
        } catch (NumberFormatException e) {
            editAge.setError("Please enter a valid age");
            editAge.requestFocus();
            return;
        }



        // Instead of just showing a Toast and closing,
        // we pack the data into an Intent and send it BACK to whoever opened us.
        // setResult() — attaches a result to this Activity before closing.
        // RESULT_OK — tells the caller "the user completed the action successfully".
        // RESULT_CANCELED — would mean user cancelled (like pressing back).
        Intent resultIntent = new Intent();
        resultIntent.putExtra("student_name", name);
        resultIntent.putExtra("student_age", age);
        resultIntent.putExtra("student_course", course);

        setResult(RESULT_OK, resultIntent);  // ← send data back

        Toast.makeText(this, "Student added: " + name, Toast.LENGTH_SHORT).show();
        finish();
    }

    // Called when the back arrow (←) in the Toolbar is tapped.
    @Override
    public boolean onSupportNavigateUp() {
        // finish() — closes this Activity and returns to the previous one.
        finish();
        return true;
    }
}