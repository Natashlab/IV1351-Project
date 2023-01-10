package integration;
/*************************************************************************************************
 * *  Exceptions
 * *
 * *  @author Natasha Donner
 * *  Created: 02.01.2022
 * *  Updated 08.01.2022
 *************************************************************************************************/

public class SgmDBException extends Exception{
 public SgmDBException(String error){
        super(error);
    }

 public SgmDBException(String error, Throwable t){
        super(error, t);
    }
}

