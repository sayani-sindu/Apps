package com.example.demoapplication.model;

// A Model class is a plain Java class that represents ONE piece of data.
// Think of it as a blueprint. A "Student" has a name, age, and course.
// This class doesn't DO anything — it just HOLDS data.

public class Student {


    private String name;
    private int age;
    private String course;

    // CONSTRUCTOR

    public Student(String name, int age, String course) {
        this.name = name;
        this.age = age;
        this.course = course;
    }

    // GETTERS — methods that let other classes READ the private fields
    // getName() returns the value of the private "name" field
    // Without this, no other class can read the student's name
    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getCourse() {
        return course;
    }

    // SETTERS — methods that let other classes CHANGE the private fields
    // setName("new name") updates the name field
    public void setName(String name) {
        this.name = name;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public void setCourse(String course) {
        this.course = course;
    }
}