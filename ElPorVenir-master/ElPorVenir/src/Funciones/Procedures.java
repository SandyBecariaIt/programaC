package Funciones;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Types;
import javax.swing.JOptionPane;
import jdk.nashorn.internal.scripts.JO;

public class Procedures {
    
    public static void AgragaCompania(String descripcion ){
        Connection conexion=Conexion.ObtenerConexion();
        if(conexion !=null){
            try {
                CallableStatement cs = conexion.prepareCall("{Call dbo.AgregaCompania(?)}");
                cs.setString(1, descripcion);
                cs.execute();
               } catch (Exception e) {
                JOptionPane.showMessageDialog(null,"Error:"+e.getMessage());
            }
         }
    }
    
    public static void AgregarProveedor(String marca,String telefono, String compania){
        Connection conexion=Conexion.ObtenerConexion();
        if(conexion !=null){
            try{
                CallableStatement cs=conexion.prepareCall("{Call dbo.AgregaProveedor(?,?,?,?)}");
                cs.setString(1,marca);
                cs.setString(2,telefono);
                cs.setString(3,compania);
                cs.registerOutParameter(4,Types.VARCHAR);
                cs.execute();
                JOptionPane.showMessageDialog(null,cs.getString(4));
            }catch(Exception e){
                JOptionPane.showMessageDialog(null,"Error"+e.getMessage());
            }
        }
    }
    
}
