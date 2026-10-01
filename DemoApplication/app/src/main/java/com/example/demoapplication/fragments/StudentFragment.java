package com.example.demoapplication.fragments;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.example.demoapplication.AddStudentActivity;
import com.example.demoapplication.R;
import com.example.demoapplication.StudentDetailActivity;
import com.example.demoapplication.adapters.StudentAdapter;
import com.example.demoapplication.model.Student;

import java.util.ArrayList;
import java.util.List;

public class StudentFragment extends Fragment implements StudentAdapter.OnStudentClickListener {

    private RecyclerView recyclerView;
    private StudentAdapter adapter;
    private List<Student> studentList;
    private TextView textEmpty;

    // ActivityResultLauncher — the modern way to start an Activity and GET A RESULT back.
    // Think of it like ordering food — you place the order (start Activity),
    // and when it's ready, the callback fires (the result comes back here).
    //
    // ActivityResultContracts.StartActivityForResult() — the contract type.
    // This means: "I'm starting an Activity and I expect a result back."
    //
    // The callback (lambda) runs when AddStudentActivity calls setResult() + finish().
    // result.getResultCode() tells you if it was RESULT_OK or RESULT_CANCELED.
    //
    // IMPORTANT: This must be registered BEFORE the fragment starts (not inside a method).
    // That's why it's declared here at field level, not inside onViewCreated.
    private final ActivityResultLauncher<Intent> addStudentLauncher = registerForActivityResult(
            new ActivityResultContracts.StartActivityForResult(),
            result -> {
                // This block runs when AddStudentActivity finishes.

                // Check if the user actually saved (RESULT_OK) vs pressed back (RESULT_CANCELED).
                if (result.getResultCode() == AppCompatActivity.RESULT_OK && result.getData() != null) {

                    // getData() gets the Intent that AddStudentActivity sent back via setResult().
                    Intent data = result.getData();

                    // Read the student data that was packed into the result Intent.
                    String name = data.getStringExtra("student_name");
                    int age = data.getIntExtra("student_age", 0);
                    String course = data.getStringExtra("student_course");

                    // Create a new Student object with the received data.
                    Student newStudent = new Student(name, age, course);

                    // Add it to our list.
                    studentList.add(newStudent);

                    // Tell the adapter the data changed so RecyclerView redraws.
                    adapter.notifyDataSetChanged();

                    // Hide empty state if it was showing.
                    updateEmptyState();
                }
            }
    );

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_students, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        recyclerView = view.findViewById(R.id.recyclerViewStudents);
        textEmpty = view.findViewById(R.id.textEmpty);

        studentList = getSampleStudents();

        adapter = new StudentAdapter(getContext(), studentList, this);
        recyclerView.setLayoutManager(new LinearLayoutManager(getContext()));
        recyclerView.setAdapter(adapter);

        updateEmptyState();
    }

    @Override
    public void onStudentClick(Student student) {
        Intent intent = new Intent(getActivity(), StudentDetailActivity.class);
        intent.putExtra("student_name", student.getName());
        intent.putExtra("student_age", student.getAge());
        intent.putExtra("student_course", student.getCourse());
        startActivity(intent);
    }

    // This is now PUBLIC so DashboardFragment can call it to trigger adding a student.
    public void openAddStudent() {
        Intent intent = new Intent(getActivity(), AddStudentActivity.class);
        // Use the launcher instead of startActivity().
        // addStudentLauncher.launch() = start the Activity AND wait for its result.
        // startActivity() = start it and forget. No result comes back.
        addStudentLauncher.launch(intent);
    }

    private List<Student> getSampleStudents() {
        List<Student> list = new ArrayList<>();
        list.add(new Student("Ravi Kumar", 21, "Computer Science"));
        list.add(new Student("Priya Sharma", 20, "Electronics"));
        list.add(new Student("Arjun Patel", 22, "Mechanical Engg."));
        return list;
    }

    private void updateEmptyState() {
        if (studentList.isEmpty()) {
            recyclerView.setVisibility(View.GONE);
            textEmpty.setVisibility(View.VISIBLE);
        } else {
            recyclerView.setVisibility(View.VISIBLE);
            textEmpty.setVisibility(View.GONE);
        }


    }

    public int getStudentCount() {
        if (studentList == null) return 0;
        return studentList.size(); // actual size, not hardcoded
    }
}