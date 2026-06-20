package com.example.singleton;

public class LoggerTest {
    public static void main(String[] args) {
        Logger logger1 = Logger.getInstance();
        Logger logger2 = Logger.getInstance();

        if (logger1 == logger2) {
            System.out.println("Success: Both logger1 and logger2 point to the same Logger instance.");
        } else {
            System.out.println("Failure: logger1 and logger2 point to different Logger instances.");
        }

        logger1.log("This is a log message from logger1.");
        logger2.log("This is a log message from logger2.");
    }
}
