package vn.hcmute.springboot4.controller;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginForm(HttpServletRequest request, HttpSession session, ModelMap model) {
        if (session.getAttribute("currentUser") != null) {
            User current = (User) session.getAttribute("currentUser");
            return current.getRoleid() == 1 ? "redirect:/admin/categories/searchpaginated" : "redirect:/home";
        }
        if (request.getCookies() != null) {
            for (Cookie c : request.getCookies()) {
                if ("rememberedUsername".equals(c.getName())) {
                    model.addAttribute("rememberedUsername", c.getValue());
                }
            }
        }
        return "auth/login";
    }

    @PostMapping("/login")
    public String loginSubmit(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam(value = "remember", required = false) String remember,
            HttpSession session,
            HttpServletResponse response,
            ModelMap model) {

        if (!StringUtils.hasText(username) || !StringUtils.hasText(password)) {
            model.addAttribute("alert", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu.");
            return "auth/login";
        }

        User user = userService.login(username.trim(), password);
        if (user == null) {
            model.addAttribute("alert", "Sai tên đăng nhập hoặc mật khẩu!");
            model.addAttribute("username", username);
            return "auth/login";
        }

        session.setAttribute("currentUser", user);

        Cookie cookie = new Cookie("rememberedUsername", "on".equals(remember) ? user.getUsername() : "");
        cookie.setPath("/");
        cookie.setMaxAge("on".equals(remember) ? 7 * 24 * 60 * 60 : 0);
        response.addCookie(cookie);

        if (user.getRoleid() != null && user.getRoleid() == 1) {
            return "redirect:/admin/categories/searchpaginated";
        }
        return "redirect:/home";
    }

    @GetMapping("/register")
    public String registerForm(HttpSession session) {
        if (session.getAttribute("currentUser") != null) {
            return "redirect:/home";
        }
        return "auth/register";
    }

    @PostMapping("/register")
    public String registerSubmit(
            @RequestParam("username") String username,
            @RequestParam("email") String email,
            @RequestParam("fullname") String fullname,
            @RequestParam("phone") String phone,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            ModelMap model,
            RedirectAttributes redirectAttributes) {

        model.addAttribute("username", username);
        model.addAttribute("email", email);
        model.addAttribute("fullname", fullname);
        model.addAttribute("phone", phone);

        if (!StringUtils.hasText(username) || !StringUtils.hasText(password) || !StringUtils.hasText(email)) {
            model.addAttribute("alert", "Tên đăng nhập, email và mật khẩu không được để trống!");
            return "auth/register";
        }
        if (!password.equals(confirmPassword)) {
            model.addAttribute("alert", "Mật khẩu xác nhận không khớp!");
            return "auth/register";
        }
        if (userService.existsByUsername(username.trim())) {
            model.addAttribute("alert", "Tên đăng nhập đã tồn tại!");
            return "auth/register";
        }
        if (userService.existsByEmail(email.trim())) {
            model.addAttribute("alert", "Email đã được sử dụng!");
            return "auth/register";
        }

        User newUser = new User(username.trim(), email.trim(), fullname, password, 3, phone);
        userService.save(newUser);

        redirectAttributes.addFlashAttribute("successMessage", "Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/403")
    public String accessDenied() {
        return "error/403";
    }
}
