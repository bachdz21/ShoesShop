/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal.imp;


import dal.DBConnect;
import dal.IProductVariantDAO;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ProductVariant;
    

public class ProductVariantDAO extends DBConnect implements IProductVariantDAO {

    public List<ProductVariant> getAllProductVariants() {
    List<ProductVariant> variants = new ArrayList<>();
    String query = "SELECT PV.VariantID, PV.ProductID, P.ProductName, C.ColorName, S.SizeName, PV.Stock " +
                   "FROM ProductVariants PV " +
                   "JOIN Products P ON PV.ProductID = P.ProductID " +
                   "JOIN Colors C ON PV.ColorID = C.ColorID " +
                   "JOIN Sizes S ON PV.SizeID = S.SizeID";

    try (PreparedStatement stmt = c.prepareStatement(query);
         ResultSet rs = stmt.executeQuery()) {
        while (rs.next()) {
            variants.add(new ProductVariant(
                rs.getInt("VariantID"),
                rs.getInt("ProductID"),
                rs.getString("ProductName"),  // Th�m productName v�o ?�y
                rs.getString("ColorName"),
                rs.getString("SizeName"),
                rs.getInt("Stock")
            ));
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return variants;
}
}