import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.Scanner;

final class PopulateDb {
  public static void main(final String[] args) {
    final String conString = "jdbc:sqlite:" + args[0];
    final String selectSt = "select id from category where name = ?";
    final Scanner sc = new Scanner(System.in);
    try {Class.forName("org.sqlite.JDBC");}
    catch (final ClassNotFoundException ex) {
      throw new RuntimeException(ex);
    }
    try {
      final Connection con = DriverManager.getConnection(conString);
      con.setAutoCommit(false);
      String stmt = "insert into category values(null,?)";
      final PreparedStatement categorySt = con.prepareStatement(stmt);
      stmt = "insert into genre values (null,(%s),?)";
      stmt = String.format(stmt, selectSt);
      final PreparedStatement genreSt = con.prepareStatement(stmt);
      while (sc.hasNextLine()) {
        final String[] genres = sc.nextLine().split(",");
        categorySt.setString(1, genres[0]);
        categorySt.executeUpdate();
        genreSt.setString(1, genres[0]);
        for (String genre : genres) {
          genreSt.setString(2, genre);
          genreSt.executeUpdate();
        }
      }
      con.commit();
    } catch (final SQLException ex) {
      throw new RuntimeException(ex);
    }
  }
}
