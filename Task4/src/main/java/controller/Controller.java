package controller;

/*************************************************************************************************
 * *  MVC (Model-View-Controller) architecture
 * *  the controller is a component that manages the interactions between the model and the view
 * *
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/

import integration.SgmDBException;
import integration.SoundGoodMusicDAO;
import model.Instruments;
import model.Rentals;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Controller {
private final SoundGoodMusicDAO sgmDao;

    /**
     * @throws SgmDBException
     * @throws SQLException
     */
    public Controller() throws SgmDBException, SQLException {
        sgmDao = new SoundGoodMusicDAO();
    }

    /**
     * This method checks if student is allowed to rent instrument and if
     * the requested instrument is available.
     * The method then calls SoundGoodMusicDAO.createRentInstrument to create a rental
     * the particular <studentID, instrumentID>
     *
     * @param studentID
     * @param instrumentID
     * @return String value, representing the information about the rental
     * @throws SQLException
     */
    public String createRental(int studentID, int instrumentID) throws SQLException {
        int count = 0;

        try {

            count = sgmDao.findCount(studentID);
            if (count >= 2) {
                return "Student already rents " + count + " instruments and therefore can't rent another one";
            }

             if (sgmDao.findAvailability(instrumentID))
             {
                 return "The requested instrument with id " + instrumentID + " is not available ";
             }

            else {
                 sgmDao.createRentInstrument(studentID, instrumentID);
                 return"Instrument rented";
             }

        } catch (SgmDBException e) {
            throw new RuntimeException(e);
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * This method calls SoundGoodMusicDAO.findAllRentals to get all rentals that
     * is stored in the database, and returns a list will all rentals
     *
     * @return all leases that are stored in the database
     * @throws SQLException
     * @throws SgmDBException
     */
    public  List<Rentals> listAllRentals() throws SQLException, SgmDBException {
        try {
            List<Rentals> rentals = new ArrayList<>();
            rentals = sgmDao.findAllRentals();
            return rentals;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (SgmDBException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method calls the method SoundGoodMusicDAO.terminate to terminate a rental
     *
     * @param studentID
     * @param instrumentID
     * @throws SQLException
     */
    public void terminateRental(int studentID, int instrumentID) throws SQLException {
        try {
            sgmDao.deleteRental(studentID, instrumentID);
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * This method returns a list with instruments, the instrument is chosen by the
     * parameter type. If type = all, all instruments that are available to rent will be returned.
     * @param type
     * @return
     * @throws SQLException
     */
    public List<Instruments> ListInstrumentAvailable(String type) throws SQLException
    {
        try{
            List<Instruments> instruments = new ArrayList<>();
            instruments = sgmDao.findAllInstrumentInStock(type);
            return instruments;
        } catch (SgmDBException e) {
            throw new RuntimeException(e);
        }
    }



}
