package vn.hcmute.springboot4.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.hcmute.springboot4.entity.User;
import vn.hcmute.springboot4.service.UserService;

@Controller
public class ProfileController {

    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/profile")
    public String profilePage(HttpSession session, ModelMap model) {
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }
        model.addAttribute("user", currentUser);
        return "web/profile";
    }

    @PostMapping("/profile")
    public String updateProfile(
            @RequestParam("fullname") String fullname,
            @RequestParam("email") String email,
            @RequestParam("phone") String phone,
            @RequestParam(value = "newPassword", required = false) String newPassword,
            HttpSession session,
            RedirectAttributes redirectAttributes) {

        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            return "redirect:/login";
        }

        User updated = userService.findById(currentUser.getId()).orElse(currentUser);
        updated.setFullname(fullname);
        updated.setEmail(email);
        updated.setPhone(phone);
        if (StringUtils.hasText(newPassword)) {
            updated.setPassword(newPassword);
        }
        userService.save(updated);
        session.setAttribute("currentUser", updated);

        redirectAttributes.addFlashAttribute("message", "Cập nhật thông tin cá nhân thành công!");
        return "redirect:/profile";
    }
}
