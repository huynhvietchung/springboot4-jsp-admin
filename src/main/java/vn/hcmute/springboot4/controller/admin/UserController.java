package vn.hcmute.springboot4.controller.admin;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import vn.hcmute.springboot4.entity.User;
import vn.hcmute.springboot4.service.UserService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/admin/users/searchpaginated";
    }

    @RequestMapping("/searchpaginated")
    public String search(
            ModelMap model,
            @RequestParam(name = "keyword", required = false) String keyword,
            @RequestParam("page") Optional<Integer> page,
            @RequestParam("size") Optional<Integer> size) {

        int currentPage = Math.max(1, page.orElse(1));
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("username").ascending());
        Page<User> resultPage;

        if (StringUtils.hasText(keyword)) {
            resultPage = userService.search(keyword.trim(), pageable);
            model.addAttribute("keyword", keyword.trim());
        } else {
            resultPage = userService.findAll(pageable);
        }

        int totalPages = resultPage.getTotalPages();
        if (totalPages > 0) {
            int start = Math.max(1, currentPage - 2);
            int end = Math.min(currentPage + 2, totalPages);
            if (totalPages > 5) {
                if (end == totalPages) {
                    start = Math.max(1, end - 4);
                } else if (start == 1) {
                    end = Math.min(totalPages, start + 4);
                }
            }
            List<Integer> pageNumbers = IntStream.rangeClosed(start, end)
                    .boxed()
                    .collect(Collectors.toList());
            model.addAttribute("pageNumbers", pageNumbers);
        }

        model.addAttribute("userPage", resultPage);
        return "admin/user/list";
    }

    @GetMapping("/add")
    public String addForm(ModelMap model) {
        model.addAttribute("user", new User());
        model.addAttribute("isEdit", false);
        return "admin/user/addOrEdit";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, ModelMap model, RedirectAttributes redirectAttributes) {
        Optional<User> opt = userService.findById(id);
        if (opt.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy User với ID = " + id);
            return "redirect:/admin/users/searchpaginated";
        }
        model.addAttribute("user", opt.get());
        model.addAttribute("isEdit", true);
        return "admin/user/addOrEdit";
    }

    @PostMapping("/save")
    public String save(
            @ModelAttribute("user") User user,
            ModelMap model,
            RedirectAttributes redirectAttributes) {

        boolean isNew = (user.getId() == null);
        if (isNew) {
            if (!StringUtils.hasText(user.getUsername()) || !StringUtils.hasText(user.getPassword())) {
                model.addAttribute("alert", "Username và Password không được để trống!");
                model.addAttribute("isEdit", false);
                return "admin/user/addOrEdit";
            }
            if (userService.existsByUsername(user.getUsername().trim())) {
                model.addAttribute("alert", "Username đã tồn tại!");
                model.addAttribute("isEdit", false);
                return "admin/user/addOrEdit";
            }
            user.setUsername(user.getUsername().trim());
        } else {
            Optional<User> existingOpt = userService.findById(user.getId());
            if (existingOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("message", "User không tồn tại!");
                return "redirect:/admin/users/searchpaginated";
            }
            User existing = existingOpt.get();
            existing.setEmail(user.getEmail());
            existing.setFullname(user.getFullname());
            existing.setPhone(user.getPhone());
            existing.setRoleid(user.getRoleid());
            existing.setAvatar(user.getAvatar());
            if (StringUtils.hasText(user.getPassword())) {
                existing.setPassword(user.getPassword());
            }
            user = existing;
        }

        userService.save(user);
        redirectAttributes.addFlashAttribute("message",
                isNew ? "Thêm mới User thành công!" : "Cập nhật User thành công!");
        return "redirect:/admin/users/searchpaginated";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (userService.findById(id).isPresent()) {
            userService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Xóa User thành công!");
        } else {
            redirectAttributes.addFlashAttribute("message", "User không tồn tại!");
        }
        return "redirect:/admin/users/searchpaginated";
    }
}
