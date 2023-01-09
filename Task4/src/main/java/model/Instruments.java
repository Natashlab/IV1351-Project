package model;
/*************************************************************************************************
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/
public class Instruments implements InstrumentsDTO{
    int id;
    String instrument;
    String brand;
    Boolean rented;
    String price;

    public Instruments(int id, String instrument, String brand, Boolean rented, String price) {
        this.id = id;
        this.instrument = instrument;
        this.brand = brand;
        this.rented = rented;
        this.price = price;
    }

    @Override
    public String toString() {
        return "" + id + "," + instrument + "," + brand + "," + rented + "," + price + "\n";
    }
}
