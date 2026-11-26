package vn.hcmute.springboot4;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import vn.hcmute.springboot4.entity.Category;
import vn.hcmute.springboot4.entity.User;
import vn.hcmute.springboot4.service.CategoryService;
import vn.hcmute.springboot4.service.UserService;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
class Springboot4JspApplicationTests {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Test
    void contextLoadsAndSeedDataExists() {
        assertThat(userService.count()).isGreaterThanOrEqualTo(2);
        assertThat(categoryService.count()).isGreaterThanOrEqualTo(2);
    }

    @Test
    void loginWithValidAndInvalidCredentials() {
        User admin = userService.login("admin", "123456");
        assertThat(admin).isNotNull();
        assertThat(admin.getRoleid()).isEqualTo(1);

        User invalid = userService.login("admin", "wrongpass");
        assertThat(invalid).isNull();
    }

    @Test
    void categorySearchAndPaginationWorks() {
        Page<Category> page = categoryService.findByNameContaining("Nam", PageRequest.of(0, 3));
        assertThat(page.getContent()).isNotEmpty();
        assertThat(page.getContent().get(0).getName()).containsIgnoringCase("Nam");
    }

    @Test
    void userSearchAndPaginationWorks() {
        Page<User> page = userService.search("admin", PageRequest.of(0, 3));
        assertThat(page.getContent()).isNotEmpty();
        assertThat(page.getContent().get(0).getUsername()).isEqualTo("admin");
    }
}
