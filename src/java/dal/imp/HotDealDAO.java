package dal.imp;

import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import model.HotDealSettings;

public class HotDealDAO extends DBConnect {

    public HotDealSettings getHotDealSettings() throws SQLException {
        HotDealSettings settings = null;
        String query = "SELECT * FROM HotDealSettings";
        try (PreparedStatement stmt = c.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                settings = new HotDealSettings();
                settings.setEndTime(rs.getTimestamp("EndTime"));
                settings.setTitle(rs.getString("Title"));
                settings.setSubtitle(rs.getString("Subtitle"));
                settings.setImageURL(rs.getString("ImageURL")); // Lấy ImageURL
            }
        }
        return settings;
    }

    public void saveHotDealSettings(HotDealSettings settings) throws SQLException {
        String query = "UPDATE HotDealSettings SET EndTime = ?, Title = ?, Subtitle = ?, ImageURL = ?, LastUpdated = GETDATE()";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            if (settings.getEndTime() != null) {
                stmt.setTimestamp(1, settings.getEndTime());
            } else {
                stmt.setNull(1, java.sql.Types.TIMESTAMP);
            }
            stmt.setString(2, settings.getTitle());
            stmt.setString(3, settings.getSubtitle());
            stmt.setString(4, settings.getImageURL()); // Lưu ImageURL

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected == 0) {
                String insertQuery = "INSERT INTO HotDealSettings (EndTime, Title, Subtitle, ImageURL, LastUpdated) VALUES (?, ?, ?, ?, GETDATE())";
                try (PreparedStatement insertStmt = c.prepareStatement(insertQuery)) {
                    if (settings.getEndTime() != null) {
                        insertStmt.setTimestamp(1, settings.getEndTime());
                    } else {
                        insertStmt.setNull(1, java.sql.Types.TIMESTAMP);
                    }
                    insertStmt.setString(2, settings.getTitle());
                    insertStmt.setString(3, settings.getSubtitle());
                    insertStmt.setString(4, settings.getImageURL()); // Thêm ImageURL
                    insertStmt.executeUpdate();
                }
            }
        }
    }

    public void resetHotDealSettings() throws SQLException {
        String query = "UPDATE HotDealSettings SET EndTime = NULL, Title = NULL, Subtitle = NULL, ImageURL = NULL, LastUpdated = GETDATE()";
        try (PreparedStatement stmt = c.prepareStatement(query)) {
            stmt.executeUpdate();
        }
    }
    
    public static void main(String[] args) throws SQLException {
        HotDealDAO h = new HotDealDAO();
        System.out.println(h.getHotDealSettings());
    }
}