package com.example.demoapplication;

import android.content.Intent;
import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.viewpager2.widget.ViewPager2;

import com.example.demoapplication.adapters.ViewPagerAdapter;
import com.example.demoapplication.fragments.StudentFragment;
import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.firebase.messaging.FirebaseMessaging;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;

import so.plotline.insights.Listeners.PlotlineRedirectListener;
import so.plotline.insights.Plotline;
import so.plotline.insights.PlotlinePush;

// AppCompatActivity — the base class for all Activities.
// "extends AppCompatActivity" means MainActivity IS an Activity with modern support.
// AppCompatActivity supports:
//   - Toolbar (instead of old ActionBar)
//   - Fragment management
//   - Material Design components
// WHAT IF YOU EXTEND Activity INSTEAD: Older API, no Toolbar support, less compatibility.
public class MainActivity extends AppCompatActivity {

    private ViewPager2 viewPager;
    private BottomNavigationView bottomNavigation;
    private Toolbar toolbar;

    // ===== onCreate =====
    // The FIRST method called when the Activity starts.
    // Everything in here runs before the user sees the screen.
    // @param savedInstanceState — if the Activity was killed and recreated (e.g., screen rotation),
    //                            this Bundle contains the previously saved state. Null on first launch.
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // super.onCreate() — MUST be called first.
        // Calls AppCompatActivity's own setup code (sets up the window, loads the theme).
        // WHAT IF REMOVED: App crashes immediately with a runtime exception.
        super.onCreate(savedInstanceState);
        Plotline.init(this, BuildConfig.PLOTLINE_API_KEY, "sindu_test");
        Plotline.track("TestEvent1");
        PlotlinePush.requestPushPermission(this);

        FirebaseMessaging.getInstance().getToken()
                .addOnCompleteListener(task -> {
                    if (task.isSuccessful()) {
                        String token = task.getResult();
                        PlotlinePush.setFcmToken(getApplicationContext(), token);
                    }
                });
        Plotline.setLocale(this, "hi");
        try {
            Plotline.identify(new JSONObject().put("uiMode", "light").put("Fibe Coins", 16000));
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }

        // setContentView — loads the XML layout and displays it on screen.
        // R.layout.activity_main → res/layout/activity_main.xml
        // This is the line that connects XML to Java.
        // WHAT IF REMOVED: The screen is blank. No views exist. Any findViewById call crashes.
        setContentView(R.layout.activity_main);

        Plotline.setPlotlineRedirectListener(new PlotlineRedirectListener() {

            @Override
            public void onPlotlineRedirect(HashMap<String, String> hashMap) {
                if (hashMap.containsKey("url")) {

                    String url = hashMap.get("url");

                    if (url != null && url.equals("studentPage")) {
                        Intent intent = new Intent(MainActivity.this, AddStudentActivity.class);
                        startActivity(intent);
                    }
                }
            }
        });

        // Find views by their XML IDs.
        // R.id.toolbar matches android:id="@+id/toolbar" in the XML.
        // findViewById returns a View — we cast it to the specific type we need.
        toolbar = findViewById(R.id.toolbar);
        viewPager = findViewById(R.id.viewPager);
        bottomNavigation = findViewById(R.id.bottomNavigation);

        // Set up the Toolbar as the app's ActionBar.
        // setSupportActionBar tells AppCompatActivity to use OUR Toolbar instead of the default.
        // Without this: The Toolbar renders visually but has no back button, menu, or title control.
        setSupportActionBar(toolbar);

        // Set up the ViewPager2 with our Adapter.
        // ViewPagerAdapter knows which Fragment to show for each tab.
        ViewPagerAdapter adapter = new ViewPagerAdapter(this);
        viewPager.setAdapter(adapter);

        // ===== LINKING BOTTOM NAV AND VIEWPAGER =====

        // When user taps a bottom nav item → switch ViewPager to that page.
        bottomNavigation.setOnItemSelectedListener(item -> {
            int itemId = item.getItemId();

            if (itemId == R.id.nav_dashboard) {
                // setCurrentItem(0, true) — go to page 0 with smooth animation.
                // setCurrentItem(0, false) — jump to page 0 instantly (no animation).
                viewPager.setCurrentItem(0, true);
                return true; // returning true = "I handled this event"

            } else if (itemId == R.id.nav_students) {
                viewPager.setCurrentItem(1, true);
                return true;
            }

            return false; // returning false = "I didn't handle this"
        });

        // When user SWIPES the ViewPager → update bottom nav to show correct tab as selected.
        // Without this: Swipe works visually but bottom nav stays on old tab.
        viewPager.registerOnPageChangeCallback(new ViewPager2.OnPageChangeCallback() {
            @Override
            public void onPageSelected(int position) {
                super.onPageSelected(position);

                // Update bottom nav selection based on which page is visible.
                if (position == 0) {
                    bottomNavigation.setSelectedItemId(R.id.nav_dashboard);
                } else if (position == 1) {
                    bottomNavigation.setSelectedItemId(R.id.nav_students);
                }
            }
        });
    }
    // Called by DashboardFragment to switch to the Students tab and open Add Student form.
    public void switchToStudentsTab() {
        // Switch ViewPager to page 1 (Students tab)
        viewPager.setCurrentItem(1, true);

        // Small delay to let the Fragment become visible before we call its method.
        // Without this, the Fragment may not be attached yet.
        viewPager.postDelayed(() -> {
            StudentFragment studentsFragment = (StudentFragment) getSupportFragmentManager()
                    .findFragmentByTag("f1"); // ViewPager2 tags fragments as "f0", "f1", "f2"...
            if (studentsFragment != null) {
                studentsFragment.openAddStudent();
            }
        }, 300);
    }

}