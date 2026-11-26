package vn.hcmute.springboot4.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @Column(length = 255)
    private String email;

    @Column(length = 255)
    private String fullname;

    @Column(nullable = false, length = 100)
    private String password;

    @Column(length = 255)
    private String avatar;

    // 1: Admin, 2: Manager, 3: Customer
    @Column(nullable = false)
    private Integer roleid = 3;

    @Column(length = 20)
    private String phone;

    private LocalDate createddate = LocalDate.now();

    public User() {
    }

    public User(String username, String email, String fullname, String password, Integer roleid, String phone) {
        this.username = username;
        this.email = email;
        this.fullname = fullname;
        this.password = password;
        this.roleid = roleid;
        this.phone = phone;
        this.createddate = LocalDate.now();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public LocalDate getCreateddate() {
        return createddate;
    }

    public void setCreateddate(LocalDate createddate) {
        this.createddate = createddate;
    }
}
