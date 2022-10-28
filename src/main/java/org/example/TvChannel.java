package org.example;

public class TvChannel implements Observer {
    private Blogger blogger;
    private String state;
    public TvChannel(Blogger blogger) {
        this.blogger = blogger;
        this.blogger.addObserver(this);
    }
    public void update() {
        this.state = blogger.getHeadline();
    }
    public String getState() {
        return "TvChannel: " + this.state;
    }}
