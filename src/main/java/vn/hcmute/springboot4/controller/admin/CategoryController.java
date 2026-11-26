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
import vn.hcmute.springboot4.entity.Category;
import vn.hcmute.springboot4.service.CategoryService;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Controller
@RequestMapping("/admin/categories")
public class CategoryController {

    private final CategoryService categoryService;

    public CategoryController(CategoryService categoryService) {
        this.categoryService = categoryService;
    }

    @GetMapping({"", "/"})
    public String index() {
        return "redirect:/admin/categories/searchpaginated";
    }

    @RequestMapping("/searchpaginated")
    public String search(
            ModelMap model,
            @RequestParam(name = "name", required = false) String name,
            @RequestParam("page") Optional<Integer> page,
            @RequestParam("size") Optional<Integer> size) {

        int currentPage = Math.max(1, page.orElse(1));
        int pageSize = size.orElse(3);

        Pageable pageable = PageRequest.of(currentPage - 1, pageSize, Sort.by("name").ascending());
        Page<Category> resultPage;

        if (StringUtils.hasText(name)) {
            resultPage = categoryService.findByNameContaining(name.trim(), pageable);
            model.addAttribute("name", name.trim());
        } else {
            resultPage = categoryService.findAll(pageable);
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

        model.addAttribute("categoryPage", resultPage);
        return "admin/category/list";
    }

    @GetMapping("/add")
    public String addForm(ModelMap model) {
        model.addAttribute("category", new Category());
        model.addAttribute("isEdit", false);
        return "admin/category/addOrEdit";
    }

    @GetMapping("/edit/{id}")
    public String editForm(@PathVariable("id") Long id, ModelMap model, RedirectAttributes redirectAttributes) {
        Optional<Category> opt = categoryService.findById(id);
        if (opt.isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "Không tìm thấy Category với ID = " + id);
            return "redirect:/admin/categories/searchpaginated";
        }
        model.addAttribute("category", opt.get());
        model.addAttribute("isEdit", true);
        return "admin/category/addOrEdit";
    }

    @PostMapping("/save")
    public String save(
            @ModelAttribute("category") Category category,
            RedirectAttributes redirectAttributes) {
        boolean isNew = (category.getId() == null);
        categoryService.save(category);
        redirectAttributes.addFlashAttribute("message",
                isNew ? "Thêm mới Category thành công!" : "Cập nhật Category thành công!");
        return "redirect:/admin/categories/searchpaginated";
    }

    @GetMapping("/delete/{id}")
    public String delete(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        if (categoryService.findById(id).isPresent()) {
            categoryService.deleteById(id);
            redirectAttributes.addFlashAttribute("message", "Xóa Category thành công!");
        } else {
            redirectAttributes.addFlashAttribute("message", "Category không tồn tại!");
        }
        return "redirect:/admin/categories/searchpaginated";
    }
}
