import java.lang.*;
public class TestDate2 {
      public static void main(String[] args) {
              long timeStamp = System.currentTimeMillis();
           java.util.Date time=new java.util.Date(timeStamp);
           System.out.println("timestamp: "+timeStamp);
           System.out.println("java.util.Date: "+time);
      }
}
