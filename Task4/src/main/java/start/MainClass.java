package start;
import integration.SgmDBException;
import view.BlockingInterpreter;
import controller.Controller;

import java.sql.SQLException;
/*************************************************************************************************
 * *  Main class for the MVC
 * *  @compile javac mainClass.java
 * *  @run java mainClass
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/
public class MainClass {


    public static void main(String[] args) throws SQLException, SgmDBException {
        try {
            new BlockingInterpreter(new Controller()).handleCmds();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (SgmDBException e) {
            throw new RuntimeException(e);
        }
    }

}


