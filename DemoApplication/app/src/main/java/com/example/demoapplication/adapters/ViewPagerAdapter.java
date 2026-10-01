package com.example.demoapplication.adapters;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentActivity;
import androidx.viewpager2.adapter.FragmentStateAdapter;

import com.example.demoapplication.fragments.DashboardFragment;
import com.example.demoapplication.fragments.StudentFragment;

// ViewPagerAdapter extends FragmentStateAdapter.
// FragmentStateAdapter connects ViewPager2 to Fragments.
// It's similar to RecyclerView.Adapter — but for Fragments instead of views.
// FragmentStateAdapter saves and restores Fragment state when you swipe away and back.
public class ViewPagerAdapter extends FragmentStateAdapter {

    // Constructor — takes a FragmentActivity.
    // FragmentActivity is the Activity that hosts the ViewPager.
    // super(fragmentActivity) passes it to FragmentStateAdapter so it can manage Fragment lifecycle.
    public ViewPagerAdapter(@NonNull FragmentActivity fragmentActivity) {
        super(fragmentActivity);
    }

    // ===== METHOD 1: createFragment =====
    // Called when ViewPager2 needs to show a page.
    // @param position — 0 = first tab, 1 = second tab.
    // Returns the Fragment for that position.
    // WHAT IF position doesn't match: Returns null → crash.
    @NonNull
    @Override
    public Fragment createFragment(int position) {
        switch (position) {
            case 0:
                return new DashboardFragment(); // First tab
            case 1:
                return new StudentFragment();  // Second tab
            default:
                return new DashboardFragment();
        }
    }

    // ===== METHOD 2: getItemCount =====
    // How many pages (tabs) does this ViewPager have?
    // We have 2 Fragments.
    @Override
    public int getItemCount() {
        return 2;
    }
}