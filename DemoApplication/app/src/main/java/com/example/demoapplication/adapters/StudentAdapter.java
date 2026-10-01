package com.example.demoapplication.adapters;

// These are imports — they bring in code from other packages so you can use it.
// Android won't know what RecyclerView, Context, etc. are without these.
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.example.demoapplication.R;
import com.example.demoapplication.model.Student;

import java.util.List;

// StudentAdapter extends RecyclerView.Adapter<StudentAdapter.StudentViewHolder>
// "extends" means: StudentAdapter IS a RecyclerView.Adapter, with extra behavior we define.
// The <StudentAdapter.StudentViewHolder> part says: "use our inner ViewHolder class".
// RecyclerView.Adapter is abstract — it FORCES us to implement the 3 methods.
public class StudentAdapter extends RecyclerView.Adapter<StudentAdapter.StudentViewHolder> {

    // The data list — holds all Student objects to display.
    private List<Student> studentList;

    // Context — needed to inflate XML layouts. Think of it as a reference to the app environment.
    private Context context;

    // Listener interface — this is how we handle clicks from outside the Adapter.
    // The Activity/Fragment sets a listener, Adapter calls it when a row is clicked.
    // This pattern is called "callback" or "interface delegation".
    private OnStudentClickListener listener;

    // Defining an interface for click handling.
    // An interface is a CONTRACT — whoever implements it MUST provide the onClick method.
    // By doing this, the Adapter doesn't need to know what happens on click.
    // The Fragment decides what to do. Clean separation of concerns.
    public interface OnStudentClickListener {
        void onStudentClick(Student student); // called when a row is tapped
    }

    // Constructor — called when you create: new StudentAdapter(context, list, listener)
    // Stores the references so the Adapter can use them later.
    public StudentAdapter(Context context, List<Student> studentList, OnStudentClickListener listener) {
        this.context = context;
        this.studentList = studentList;
        this.listener = listener;
    }

    // ===== METHOD 1: onCreateViewHolder =====
    // Called by RecyclerView when it needs a NEW row view.
    // This happens only when no recycled view is available.
    // RecyclerView is smart — it calls this as few times as possible.
    //
    // @NonNull — tells Android "this method will never return null".
    // @param parent — the RecyclerView itself (the container).
    // @param viewType — if you have multiple row types, use this. We have one type.
    // @return — a new StudentViewHolder wrapping the inflated row view.
    @NonNull
    @Override
    public StudentViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // LayoutInflater: Reads an XML layout file and converts it into actual Java View objects.
        // from(context) — creates an inflater using the app's environment.
        // inflate(R.layout.item_student, parent, false):
        //   - R.layout.item_student → the XML file to inflate
        //   - parent → the RecyclerView (used for layout sizing info)
        //   - false → don't attach to parent yet (RecyclerView handles this)
        // WHAT IF FALSE IS TRUE: Android attaches the view twice, causing crashes.
        View view = LayoutInflater.from(context).inflate(R.layout.item_student, parent, false);

        // Wrap the inflated view in our ViewHolder and return it.
        return new StudentViewHolder(view);
    }

    // ===== METHOD 2: onBindViewHolder =====
    // Called every time a row needs to display data.
    // Could be a fresh view OR a recycled view from a row that scrolled off-screen.
    //
    // @param holder — the ViewHolder (has references to the TextViews inside the row).
    // @param position — the index in the list (0 = first student, 1 = second, etc.)
    @Override
    public void onBindViewHolder(@NonNull StudentViewHolder holder, int position) {
        // Get the Student at this position from the list.
        Student student = studentList.get(position);

        // Set the text on the TextViews using the Student's data.
        // holder.textName → the TextView reference stored in ViewHolder.
        // student.getName() → calls the getter on the Student model.
        holder.textName.setText(student.getName());
        holder.textCourse.setText(student.getCourse());
        holder.textAge.setText(student.getAge() + " yrs");

        // Set the avatar initial — first letter of the student's name, uppercase.
        // charAt(0) → get the first character.
        // toUpperCase() → make it uppercase.
        // String.valueOf() → convert the char to a String (setText needs a String).
        holder.textAvatar.setText(String.valueOf(student.getName().charAt(0)).toUpperCase());

        // Handle row click — call the listener's method and pass the Student object.
        // The listener is the Fragment that created this Adapter.
        // So the Fragment's onStudentClick method runs when user taps a row.
        holder.itemView.setOnClickListener(v -> {
            if (listener != null) {
                listener.onStudentClick(student);
            }
        });
    }

    // ===== METHOD 3: getItemCount =====
    // RecyclerView calls this to know how many rows to create.
    // If this returns 5, RecyclerView creates at most 5 rows (probably fewer visible).
    @Override
    public int getItemCount() {
        return studentList.size();
    }

    // Method to update the data and refresh the list.
    // notifyDataSetChanged() tells RecyclerView: "data changed, redraw everything."
    // This is called from outside when a new student is added.
    public void updateList(List<Student> newList) {
        this.studentList = newList;
        notifyDataSetChanged(); // RecyclerView redraws all visible rows
    }

    // ===== INNER CLASS: StudentViewHolder =====
    // A ViewHolder is a simple class that holds references to the Views inside one row.
    // "static" means it doesn't need an instance of StudentAdapter to exist.
    // It extends RecyclerView.ViewHolder, which requires us to pass the row's root view.
    public static class StudentViewHolder extends RecyclerView.ViewHolder {

        // References to Views inside item_student.xml.
        // We declare them here so we find them ONCE (in the constructor).
        // They are reused every time onBindViewHolder is called.
        TextView textName;
        TextView textCourse;
        TextView textAge;
        TextView textAvatar;

        // Constructor — receives the inflated row view.
        // super(itemView) passes it to RecyclerView.ViewHolder, which stores it as this.itemView.
        public StudentViewHolder(@NonNull View itemView) {
            super(itemView);

            // findViewById — searches inside itemView for a View with this ID.
            // R.id.textStudentName → the ID we gave in item_student.xml.
            // WHAT IF ID DOESN'T MATCH: Returns null → crash when setText is called.
            textName = itemView.findViewById(R.id.textStudentName);
            textCourse = itemView.findViewById(R.id.textStudentCourse);
            textAge = itemView.findViewById(R.id.textStudentAge);
            textAvatar = itemView.findViewById(R.id.textAvatar);
        }
    }
}