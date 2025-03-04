package dao;

import dal.DBContext;
import model.Doctor;
import model.DoctorSchedule;
import model.Shift;
import model.system.Staff;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DoctorScheduleDBContext extends DBContext<DoctorSchedule> {

    private static final Logger LOGGER = Logger.getLogger(DoctorScheduleDBContext.class.getName());

    

    public List<DoctorSchedule> getSchedulesByDoctorBetweenDates(int doctorId, Date startDate, Date endDate) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        String sql = "SELECT ds.id, ds.doctor_id, ds.schedule_date, ds.shift_id, s.time_start, s.time_end, ds.available "
                + "FROM Doctor_Schedule ds "
                + "JOIN Shift s ON ds.shift_id = s.id "
                + "WHERE ds.doctor_id = ? AND ds.schedule_date BETWEEN ? AND ? "
                + "ORDER BY ds.schedule_date, s.time_start";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            stmt.setDate(2, startDate);
            stmt.setDate(3, endDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                DoctorSchedule ds = new DoctorSchedule();
                ds.setId(rs.getInt("id"));
                ds.setScheduleDate(rs.getDate("schedule_date"));
                // Tạo đối tượng Shift
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getTime("time_start"), rs.getTime("time_end"));
                ds.setShift(shift);
                // Nếu đối tượng Doctor không được join đầy đủ, bạn có thể gọi DoctorDAO.getDoctorById(doctorId)
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("doctor_id"));
                // Giả sử bạn đã set các thông tin khác cho doctor (hoặc có thể load từ DAO riêng)
                ds.setDoctor(doctor);
                ds.setAvailable(rs.getInt("available") == 1);
                schedules.add(ds);
            }
        } catch (SQLException ex) {
            // Log lỗi
            ex.printStackTrace();
        }
        return schedules;
    }

    public List<DoctorSchedule> getAvailableShiftsForDate(int doctorId, Date selectedDate) {
        List<DoctorSchedule> shifts = new ArrayList<>();
        String sql = "SELECT * FROM Doctor_Schedule WHERE doctor_id = ? AND schedule_date = ? AND available = 1";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            stmt.setDate(2, selectedDate);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                DoctorSchedule schedule = new DoctorSchedule();
                schedule.setId(rs.getInt("id"));
                schedule.setScheduleDate(rs.getDate("schedule_date"));
                // Add other fields as needed
                shifts.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shifts;
    }

    // Get available future dates for a doctor
    public List<Date> getAvailableDates(int doctorId) {
        List<Date> availableDates = new ArrayList<>();
        String sql = """
            SELECT DISTINCT schedule_date 
            FROM Doctor_Schedule 
            WHERE doctor_id = ? AND available = 1 AND schedule_date >= GETDATE()
            ORDER BY schedule_date ASC
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, doctorId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                availableDates.add(rs.getDate("schedule_date"));
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching available dates: {0}", ex.getMessage());
        }
        return availableDates;
    }

    // Get available time slots for a doctor on a specific date
    public DoctorSchedule getScheduleByDateAndShift(int doctorId, Date date, int shiftId) {
        DoctorSchedule schedule = null;
        String sql = """
        SELECT ds.id, ds.schedule_date, ds.shift_id, s.time_start, s.time_end, ds.available
        FROM Doctor_Schedule ds
        JOIN Shift s ON ds.shift_id = s.id
        WHERE ds.doctor_id = ? AND ds.schedule_date = ? AND ds.shift_id = ? AND ds.available = 1
    """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, doctorId);
            stm.setDate(2, date);
            stm.setInt(3, shiftId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) { // Fetch only one record
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getTime("time_start"), rs.getTime("time_end"));
                schedule = new DoctorSchedule(
                        rs.getInt("id"),
                        null, // Doctor object can be set later if needed
                        rs.getDate("schedule_date"),
                        shift,
                        rs.getInt("available") == 1
                );
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching doctor schedule by date & shift: {0}", ex.getMessage());
        }
        return schedule;
    }

    @Override
    public void insert(DoctorSchedule schedule) {
        String sql = "INSERT INTO Doctor_Schedule (doctor_id, schedule_date, shift_id, available) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stm = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stm.setInt(1, schedule.getDoctor().getId());
            stm.setDate(2, schedule.getScheduleDate());
            stm.setInt(3, schedule.getShift().getId());
            stm.setInt(4, schedule.isAvailable() ? 1 : 0); // Chuyển boolean thành int

            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = stm.getGeneratedKeys();
                if (generatedKeys.next()) {
                    schedule.setId(generatedKeys.getInt(1));
                    LOGGER.info("Doctor schedule added successfully with ID: " + schedule.getId());
                }
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error inserting doctor schedule: {0}", ex.getMessage());
        }
    }

    @Override
    public DoctorSchedule get(String id) {
        DoctorSchedule schedule = null;
        DoctorDBContext docDb = new DoctorDBContext();
        String sql = """
            SELECT ds.id, ds.doctor_id, ds.schedule_date, ds.shift_id, s.time_start, s.time_end, ds.available
            FROM Doctor_Schedule ds
            JOIN Shift s ON ds.shift_id = s.id
            WHERE ds.id = ?
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, Integer.parseInt(id));
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Doctor doctor = docDb.getDoctorById(rs.getInt("doctor_id"));
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getTime("time_start"), rs.getTime("time_end"));

                schedule = new DoctorSchedule(
                        rs.getInt("id"),
                        doctor,
                        rs.getDate("schedule_date"),
                        shift,
                        rs.getInt("available") == 1
                );
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching doctor schedule: {0}", ex.getMessage());
        }
        return schedule;
    }

    @Override
    public void update(DoctorSchedule schedule) {
        String sql = "UPDATE Doctor_Schedule SET available = ? WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, schedule.isAvailable() ? 1 : 0);
            stm.setInt(2, schedule.getId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating doctor schedule: {0}", ex.getMessage());
        }
    }

    @Override
    public void delete(DoctorSchedule schedule) {
        String sql = "DELETE FROM Doctor_Schedule WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, schedule.getId());

            int affectedRows = stm.executeUpdate();
            if (affectedRows > 0) {
                LOGGER.info("Doctor schedule deleted successfully.");
            } else {
                LOGGER.warning("No doctor schedule found with the given ID.");
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting doctor schedule: {0}", ex.getMessage());
        }
    }

    public List<DoctorSchedule> getSchedulesByDoctor(int doctorId, Date date) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        DoctorDBContext docDB = new DoctorDBContext();
        String sql = """
            SELECT ds.id, ds.schedule_date, ds.shift_id, s.time_start, s.time_end, ds.available
            FROM Doctor_Schedule ds
            JOIN Shift s ON ds.shift_id = s.id
            WHERE ds.doctor_id = ? AND ds.schedule_date = ?
        """;
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, doctorId);
            stm.setDate(2, date);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getTime("time_start"), rs.getTime("time_end"));
                DoctorSchedule schedule = new DoctorSchedule(
                        rs.getInt("id"),
                        docDB.getDoctorById(doctorId),
                        rs.getDate("schedule_date"),
                        shift,
                        rs.getInt("available") == 1
                );
                schedules.add(schedule);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching doctor schedules: {0}", ex.getMessage());
        }
        return schedules;
    }

    @Override
    public ArrayList<DoctorSchedule> list() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    public List<DoctorSchedule> getSchedulesBetweenDates(Date startDate, Date endDate) {
        List<DoctorSchedule> schedules = new ArrayList<>();
        DoctorDBContext docDB = new DoctorDBContext();
        String sql = """
            SELECT ds.id, ds.doctor_id, ds.schedule_date, ds.shift_id, s.time_start, s.time_end, ds.available
            FROM Doctor_Schedule ds
            JOIN Shift s ON ds.shift_id = s.id
            WHERE ds.schedule_date BETWEEN ? AND ?
            ORDER BY ds.schedule_date, s.time_start
        """;

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Doctor doctor = docDB.getDoctorById(rs.getInt("doctor_id"));
                Shift shift = new Shift(rs.getInt("shift_id"), rs.getTime("time_start"), rs.getTime("time_end"));

                DoctorSchedule schedule = new DoctorSchedule(
                        rs.getInt("id"),
                        doctor,
                        rs.getDate("schedule_date"),
                        shift,
                        rs.getInt("available") == 1
                );
                schedules.add(schedule);
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching schedules between dates: {0}", ex.getMessage());
        }
        return schedules;
    }

    public boolean assignShift(int doctorId, Date shiftDate, int shiftId) {
        // Kiểm tra xem đã có lịch của bác sĩ vào ngày và ca đó chưa
        String checkSql = "SELECT COUNT(*) FROM Doctor_Schedule WHERE doctor_id = ? AND schedule_date = ? AND shift_id = ?";
        try (PreparedStatement checkStmt = connection.prepareStatement(checkSql)) {
            checkStmt.setInt(1, doctorId);
            checkStmt.setDate(2, shiftDate);
            checkStmt.setInt(3, shiftId);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                // Đã tồn tại lịch, không thực hiện insert lại
                return false;
            }
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error checking duplicate shift: {0}", ex.getMessage());
            return false;
        }

        // Nếu chưa tồn tại, thực hiện INSERT
        String insertSql = "INSERT INTO Doctor_Schedule (doctor_id, schedule_date, shift_id, available) VALUES (?, ?, ?, 1)";
        try (PreparedStatement stm = connection.prepareStatement(insertSql)) {
            stm.setInt(1, doctorId);
            stm.setDate(2, shiftDate);
            stm.setInt(3, shiftId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error assigning shift: {0}", ex.getMessage());
            return false;
        }
    }

    public boolean updateShift(int scheduleId, Date shiftDate, int shiftId) {
        String sql = "UPDATE Doctor_Schedule SET schedule_date = ?, shift_id = ? WHERE id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setDate(1, shiftDate);
            stm.setInt(2, shiftId);
            stm.setInt(3, scheduleId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error updating shift: {0}", ex.getMessage());
            return false;
        }
    }

    public boolean deleteShift(int scheduleId) {
        String sql = "DELETE FROM Doctor_Schedule WHERE id = ?";

        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setInt(1, scheduleId);
            return stm.executeUpdate() > 0;
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error deleting shift: {0}", ex.getMessage());
            return false;
        }
    }
}
