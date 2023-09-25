import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class Test {
    public static void main(String[] args) {
        String sql = "insert into board (writer, title, contents, game_name) values (?, ?, ?, 'dragon')";
        try (
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/avengers", "avengers", "avengers");
            PreparedStatement pstat = con.prepareStatement(sql)
        ) {
            for (int i = 1; i < 145; i++) {
                pstat.setString(1, "writer" + i);
                pstat.setString(2, "title" + i);
                pstat.setString(3, "contents" + i);
                pstat.addBatch();
            }
            pstat.executeBatch(); // Batch: 일괄 처리
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
