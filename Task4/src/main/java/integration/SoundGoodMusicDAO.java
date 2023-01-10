/*
 * The MIT License (MIT)
 * Copyright (c) 2020 Leif Lindbäck
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction,including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so,subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

package integration;
/*************************************************************************************************
 * *  DAO -- Database Access Object architecture
 * *  the DAO is the integration layer between the controller and the database.
 * *  There is no logic at all in this layer.
 * *
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.*;

public class SoundGoodMusicDAO {
    private PreparedStatement listInstrumentType;
    private PreparedStatement getListRental;
    private PreparedStatement getALL;
    private PreparedStatement listAll;
    private PreparedStatement updateStock;
    private PreparedStatement terminateRental;
    private PreparedStatement addRental;
    private PreparedStatement getNumberOfActiveRentsbyStudent;
    private PreparedStatement getAvailability;
    private Connection connection;

    /**
     *
     * @throws SQLException
     */
    public SoundGoodMusicDAO() throws SQLException {
        try {
            createConnect();
        } catch (Exception e) {
            throw new SQLException("Connection to database failed", e);
        }
    }

    /**
     * This method creates a connection to the database.
     * @throws SQLException
     */
    private void createConnect() throws SQLException {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/soundgood",
                "postgres", "facerap3");
        connection.setAutoCommit(false);
        prepareStatements(connection);
    }

    /**
     * This method returns false if the <instrument_id> is available to rent.
     * @param instrumentID
     * @return availability of the specified <instrument_id>
     */
    public boolean findAvailability(int instrumentID)
    {
        boolean rented = true;
        ResultSet result = null;
        try{
            getAvailability.setInt(1,instrumentID);
            result = getAvailability.executeQuery();
            while(result.next()){
                rented = result.getBoolean("rented");

            }

            return rented;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method returns the available instruments of the specified <type>
     * If <type> equals "all" then all available instruments will be returned in a List.
     * @param type
     * @return List<Instruments>
     * @throws SgmDBException
     */
    public List<Instruments> findAllInstrumentInStock(String type) throws SgmDBException {
        ResultSet result = null;
        try {
            List<Instruments> instruments = new ArrayList<>();
            if (type.equals("all")){
                result = listAll.executeQuery();
            }
            else {
                listInstrumentType.setObject(1, (instrument_enum.valueOf(type)), Types.OTHER);
                result = listInstrumentType.executeQuery();
            }
            while (result.next()) {

                instruments.add(new Instruments(result.getInt("id"),
                        result.getString("instrument"),
                        result.getString("brand"),
                        result.getBoolean("rented"),
                        result.getString("price")));

            }
            connection.commit();
            return instruments;
        } catch (SQLTimeoutException e) {  // Handle the SQL timeout exception
        } catch (SQLTransientException e) {
        } catch (SQLRecoverableException e) {
            // Handle the SQL recoverable exception
        } catch (SQLException e) {
            // Handle the general SQL exception
        }
        catch (IllegalArgumentException e) {
            System.out.println(e + " The specified instrument is not in the database, please try with a different value.");
            System.exit(1);
        }
        finally {
            closeResultSet("return count ", result);
        }
        return null;
    }

    /**
     * This method gets all rentals that are stored in the database and returns them.
     * @return all rentals that is stored in the database.
     * @throws SQLException
     * @throws SgmDBException
     */
    public List<Rentals>findAllRentals() throws SQLException, SgmDBException {
        ResultSet result = null;
        try {
            result = getALL.executeQuery();
            List<Rentals> rentals = new ArrayList<>();
            while (result.next())
            {
                rentals.add(new Rentals(result.getInt("instrument_in_stock_id"),
                                        result.getString("fee"),
                                        result.getString("start_at"),
                                        result.getString("end_at"),
                                        result.getInt("student_id"),
                                        result.getBoolean("terminated")));

            }
            connection.commit();

            return rentals;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        finally {
            closeResultSet("return count ", result);
        }
    }

    /**
     * This method creates a rental with the
     * @param studentId
     * @param instrumentId
     * @throws SQLException
     */
    public void createRentInstrument(int studentId, int instrumentId) throws SQLException {
        try {
            addRental.setInt(1, studentId);
            addRental.setInt(2, instrumentId);
            //addRental.executeUpdate();
            addRental.execute();
            connection.commit();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method terminates a rental for specified <studentID>, <instrumentID>
     * @param studentId
     * @param instrumentId
     * @throws SQLException
     */
    public void deleteRental(int studentId, int instrumentId) throws SQLException {
        try {
            terminateRental.setInt(1, studentId);
            terminateRental.setInt(2, instrumentId);
            updateStock.setInt(1,instrumentId);
            terminateRental.execute();
            updateStock.execute();
            connection.commit();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * This method takes a <studentID> as parameter and returns the number
     * of active rentals the student have
     * @param studentId
     * @return
     * @throws SQLException
     * @throws SgmDBException
     */
    public int findCount(int studentId) throws SQLException, SgmDBException {
        ResultSet result = null;
        int amount = 20; 
        try {
            getNumberOfActiveRentsbyStudent.setInt(1, studentId);
            //addRental.executeUpdate();
            result = getNumberOfActiveRentsbyStudent.executeQuery();
            while(result.next())
            {
                amount = result.getInt("amount");
            }
            connection.commit();
            return amount;
        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        finally {
            closeResultSet("return count ", result);
        }
    }

    /**
     * This method closes the ResultSet
     * @param failureMsg
     * @param result
     * @throws SgmDBException
     */
    public void closeResultSet(String failureMsg, ResultSet result) throws SgmDBException{
        try {
            result.close();
        }
        catch(Exception e){
            throw new SgmDBException(failureMsg + "could not close result set.", e);
        }
    }

    /**
     * The method is pre-compiled SQL statements
     * which allows it to be executed more efficiently than a regular SQL statement.
     * @param connection
     * @throws SQLException
     */
    public void prepareStatements(Connection connection) throws SQLException {
        listInstrumentType = connection.prepareStatement("SELECT * FROM instrument_in_stock WHERE instrument = ? AND rented = FALSE;");
        getNumberOfActiveRentsbyStudent = connection.prepareStatement(
                "SELECT COUNT(*) AS amount FROM rent_instrument JOIN instrument_in_stock ON rent_instrument.instrument_in_stock_id = instrument_in_stock.id WHERE rent_instrument.student_id = ? AND instrument_in_stock.rented = true;");
        addRental = connection.prepareStatement("INSERT INTO rent_instrument (instrument_in_stock_id, fee, start_at, end_at, student_id, terminated)" +
                "SELECT id, price, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP + INTERVAL '1 month', ?, false " +
                "FROM instrument_in_stock WHERE id = ?");
        getALL = connection.prepareStatement("SELECT * FROM rent_instrument");
        terminateRental = connection.prepareStatement("UPDATE rent_instrument SET terminated = true, end_at = CURRENT_TIMESTAMP WHERE student_id = ? AND instrument_in_stock_id = ?;");
        updateStock = connection.prepareStatement("UPDATE instrument_in_stock SET rented = false WHERE id = ?");
        getListRental = connection.prepareStatement("SELECT * FROM rent_instrument WHERE student_id = ? ;");
        getAvailability = connection.prepareStatement("SELECT rented from instrument_in_stock where id = ? ");
        listAll = connection.prepareStatement("select * from instrument_in_stock where rented = false; ");
    }

    /**
     * instrument ENUM values that are available in the database.
     */
    public enum instrument_enum {
        guitar, piano, saxophone, trumpet, harmonica, fiol, cello, clarinett, violin
    }
}