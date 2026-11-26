package vn.hcmute.springboot4.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import vn.hcmute.springboot4.entity.Category;
import vn.hcmute.springboot4.entity.User;
import vn.hcmute.springboot4.repository.CategoryRepository;
import vn.hcmute.springboot4.repository.UserRepository;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final CategoryRepository categoryRepository;

    public DataInitializer(UserRepository userRepository, CategoryRepository categoryRepository) {
        this.userRepository = userRepository;
        this.categoryRepository = categoryRepository;
    }

    @Override
    public void run(String... args) {
        if (userRepository.count() == 0) {
            userRepository.save(new User("admin", "admin@gmail.com", "Quản Trị Viên", "123456", 1, "0901234567"));
            userRepository.save(new User("user", "user@gmail.com", "Khách Hàng", "123", 3, "0909876543"));
            userRepository.save(new User("manager", "manager@gmail.com", "Quản Lý Cửa Hàng", "123456", 2, "0912345678"));
            userRepository.save(new User("nguyenvana", "vana@gmail.com", "Nguyễn Văn A", "123456", 3, "0923456789"));
            userRepository.save(new User("tranthib", "thib@gmail.com", "Trần Thị B", "123456", 3, "0934567890"));
            userRepository.save(new User("levanc", "vanc@gmail.com", "Lê Văn C", "123456", 3, "0945678901"));
            userRepository.save(new User("phamthid", "thid@gmail.com", "Phạm Thị D", "123456", 3, "0956789012"));
        }

        if (categoryRepository.count() == 0) {
            categoryRepository.save(new Category("Quần Áo Nam", "ao_nam.png", true));
            categoryRepository.save(new Category("Quần Áo Nữ", "ao_nu.png", true));
            categoryRepository.save(new Category("Giày Thể Thao", "giay_tt.png", true));
            categoryRepository.save(new Category("Phụ Kiện Thời Trang", "phu_kien.png", true));
            categoryRepository.save(new Category("Túi Xách", "tui_xach.png", true));
            categoryRepository.save(new Category("Đồng Hồ", "dong_ho.png", false));
            categoryRepository.save(new Category("Đồ Thể Thao", "the_thao.png", true));
        }
    }
}
