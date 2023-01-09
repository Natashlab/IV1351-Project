package model;
/*************************************************************************************************
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/
public class Rentals implements RentalsDTO{
    int instrument_in_stock_id;
    String fee;
    String start_at;
    String end_at;
    int student_id;
    boolean terminated;

    public Rentals(int instrument_in_stock_id, String fee, String start_at,String end_at, int student_id, boolean terminated ) {
        this.instrument_in_stock_id = instrument_in_stock_id;
        this.fee = fee;
        this.start_at = start_at;
        this.end_at = end_at;
        this.student_id = student_id;
        this.terminated = terminated;
    }

    @Override
    public String toString() {
        return "" + instrument_in_stock_id + "," +
                fee + "," +
                start_at + "," +
                end_at + ","+
                student_id + "," + terminated + "\n";
    }
}