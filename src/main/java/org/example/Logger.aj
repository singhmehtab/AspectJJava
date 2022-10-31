package org.example;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public aspect Logger {
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
    Date date = new Date();
    private int n = 0;
    static {
    try {
        Thread.sleep(10);
    } catch(InterruptedException e){
        System.out.println("InterruptedException caught");
    }
    try {
        PrintWriter out = new PrintWriter(new FileWriter("callgraph.txt"));
        out.println("@startuml");
        out.close();
    } catch(IOException e) {}
    }

    pointcut observerAddition() : call( * *.*(..))
            && !within(Logger)
            && !cflow(call(* java.*.*.*(..)));

    before() : observerAddition() {
        try {
            Thread.sleep(10);
        } catch(InterruptedException e) {
            System.out.println("InterruptedException caught");
        }
        try {
            PrintWriter out = new PrintWriter(new FileWriter("callgraph.txt", true));
            if (thisJoinPoint.getThis() != null) {
                out.println(" " +
                        thisJoinPoint.getThis().getClass().getName() +
                        "->" + thisJoinPoint.getTarget().getClass().getName()
                        + " : " + thisJoinPoint.getSignature().getName() );
            }
            out.close();
        } catch (IOException e) {}
    }
    // Now that the main method is done...
    after(): execution(void *.main(String[])) {
        try {
            Thread.sleep(10);
        } catch(InterruptedException e) {
            System.out.println("InterruptedException caught");
        }
        try {
            PrintWriter out = new PrintWriter(new FileWriter("callgraph.txt", true));
            out.println("@enduml");
            out.close();
        } catch (IOException e) {}
    }
}
