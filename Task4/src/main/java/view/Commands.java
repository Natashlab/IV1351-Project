package view;

public class Commands {
    private String[] command;
    public String listCommands() {
        return ("\n1.List all instruments that is available, write ls <all>" +
                "\n2.List all instrument of a specific type, write ls <type>" +
                "\n3.List all leases, write leases" +
                "\n4.Rent instrument, write rent <student_id> <instrument_id>" +
                "\n5.Terminate a rental, write terminate <student_id> <instrument_id>" +
                "\n6.To quit press q");
    }
}
