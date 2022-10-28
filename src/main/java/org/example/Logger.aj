package org.example;

import org.aspectj.lang.JoinPoint;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Stack;
import java.util.stream.Collectors;

public aspect Logger {

    List<JoinPoint> callStack = new ArrayList<>();

    pointcut observerAddition() : (call( * *.*(..))
        || execution( *.new(..)))
            && !within(Logger)
            && !cflow(call(* java.*.*.*(..)));

    before() : observerAddition() {
        if (callStack.size() > 0 ) {
            System.out.println(" " +
                    callStack.get(callStack.size()-1).getTarget().getClass().getSimpleName() +
                    "->" + thisJoinPoint.getTarget().getClass().getSimpleName()  + " : " + thisJoinPoint.getSignature().getName() );
        }
        callStack.add(thisJoinPoint);
    }

    after() : observerAddition() {
       if (callStack.get(callStack.size()-1) == thisJoinPoint) {
           callStack.remove(callStack.size()-1);
       }
    }
}
