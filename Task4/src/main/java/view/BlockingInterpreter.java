package view;
import controller.Controller;
import integration.SgmDBException;
import model.Instruments;
import model.InstrumentsDTO;
import model.Rentals;
import model.RentalsDTO;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 * *  Compilation:  javac Main.java
 * *  Execution:    java Main < input.txt

 * * List instruments It shall be possible to list all instruments of a certain kind
 * * (guitar, saxophone, etc) that are available to rent.
 * * Instruments which are already rented shall not be included in the listing.
 * * The listing shall show brand and price for each listed instrument.
 */

public class BlockingInterpreter {
    private final Scanner in = new Scanner(System.in);
    private Controller controller;
    private boolean quit = false;
    private Commands commands;

    /**
     *
     * @param controller
     * @throws SQLException
     * @throws SgmDBException
     */
    public BlockingInterpreter(Controller controller) throws SQLException, SgmDBException {
    this.controller = controller;
    commands = new Commands();
    }

    public void stop(){
    quit = true;
    }
    /**
     * @throws SQLException
     * @throws SgmDBException
     */
    public void handleCmds() throws SQLException, SgmDBException {
    String instr;
    int studentID, instrumentID;
        while(!quit){
            System.out.println(commands.listCommands());
            String a = in.next();
            switch (a) {
                case "ls" -> {
                    instr = in.next();
                    List<? extends InstrumentsDTO> instruments = controller.ListInstrumentAvailable(instr);
                    System.out.println(instruments);
                }
                case "rent" -> {
                    studentID = in.nextInt();
                    instrumentID = in.nextInt();
                    System.out.println(controller.createRental(studentID, instrumentID));
                }

                case "terminate" -> {
                    studentID = in.nextInt();
                    instrumentID = in.nextInt();
                    controller.terminateRental(studentID, instrumentID);
                    System.out.println("Rental terminated");
                }
                case "leases" ->{
                    List<? extends RentalsDTO> rentals = controller.listAllRentals();
                    System.out.println(rentals);
                }
                case "q" -> {
                    System.out.println("System is quitting");
                    quit = true;
                }
                default -> throw new IllegalStateException("Unexpected value: " + a);
            }
        }
    }
}