package com.example.demoapplication.fragments;

import android.app.AlertDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;

import com.example.demoapplication.MainActivity;
import com.example.demoapplication.R;
import com.example.demoapplication.WebActivity;

import org.json.JSONException;
import org.json.JSONObject;

import so.plotline.insights.Plotline;

public class DashboardFragment extends Fragment {

    private Button btnAddStudent;
    private Button btnShowDialog;
    private Button btnShowToast;
    private TextView textStudentCount;
    private Button btnOpenStudentsWeb;
    private Button btnOpenCourseWeb;

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container,
                             @Nullable Bundle savedInstanceState) {
        return inflater.inflate(R.layout.fragment_dashboard, container, false);
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);

        // Find views FIRST — must happen before onResume uses them
        btnAddStudent = view.findViewById(R.id.btnAddStudent);
        btnShowDialog = view.findViewById(R.id.btnShowDialog);
        btnShowToast = view.findViewById(R.id.btnShowToast);
        textStudentCount = view.findViewById(R.id.textStudentCount);
        btnOpenStudentsWeb = view.findViewById(R.id.btnOpenStudentsWeb);
        btnOpenCourseWeb = view.findViewById(R.id.btnOpenCourseWeb);
        // Set initial count
        textStudentCount.setText("Total Students: " + getLiveStudentCount());

        btnAddStudent.setOnClickListener(v -> {
            if (getActivity() != null) {
                ((MainActivity) getActivity()).switchToStudentsTab();
            }
        });

        btnShowDialog.setOnClickListener(v ->{
            JSONObject properties = new JSONObject();
            try {
                properties.put("token", "YOUR_TOKEN_HERE");
                properties.put("Build", "true");
                properties.put("email_id", "user@example.com");
                Plotline.identify(properties);

            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
            showInfoDialog();
        });

        btnShowToast.setOnClickListener(v -> {
            JSONObject properties = new JSONObject();
            try {
                properties.put("clicked", true);
                properties.put("Testing", "done");
                Plotline.track("Clicked_Toast", properties);
                Plotline.track("Payment Sucecss", new JSONObject().put("redeem_amount", 100).put("trans_type", "P2P"));

                Plotline.showStory(getActivity(),"69e86ebb42852f568d3e4294", "69e86ebb42852f568d3e4295");

            } catch (JSONException e) {
                throw new RuntimeException(e);
            }

            Toast.makeText(getContext(), "Hello from Dashboard!", Toast.LENGTH_SHORT).show();
        });

        btnOpenStudentsWeb.setOnClickListener(v -> {
            Intent intent = new Intent(requireContext(), WebActivity.class);
            intent.putExtra(WebActivity.EXTRA_PAGE, "students.html");
            startActivity(intent);
        });

        btnOpenCourseWeb.setOnClickListener(v -> {
            Intent intent = new Intent(requireContext(), WebActivity.class);
            intent.putExtra(WebActivity.EXTRA_PAGE, "courses.html");
            startActivity(intent);
        });
    }

    // Runs every time Dashboard tab becomes visible — AFTER onViewCreated has already run once
    // so textStudentCount is guaranteed to exist here
    @Override
    public void onResume() {
        super.onResume();
        if (textStudentCount != null) {
            textStudentCount.setText("Total Students: " + getLiveStudentCount());
        }
    }

    private void showInfoDialog() {
        new AlertDialog.Builder(getContext())
                .setTitle("About This App")
                .setMessage("This is the Student App.\nVersion 1.0\nBuilt with Java & XML.")
                .setPositiveButton("OK", (dialog, which) -> dialog.dismiss())
                .setNegativeButton("Cancel", (dialog, which) -> dialog.dismiss())
                .show();
    }

    private int getLiveStudentCount() {
        // FIXED: StudentsFragment not StudentFragment
        StudentFragment studentsFragment = (StudentFragment) getParentFragmentManager()
                .findFragmentByTag("f1");

        if (studentsFragment != null) {
            return studentsFragment.getStudentCount();
        }

        return 3; // default until StudentsFragment is loaded
    }
}