package ru.pis.lab7.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import ru.pis.lab7.model.TableCompany;
import ru.pis.lab7.service.CompanyService;

import java.util.List;

import static org.springframework.util.CollectionUtils.isEmpty;

@Controller
@RequiredArgsConstructor
public class CompanyController {
    private final CompanyService companyService;

    @GetMapping("/")
    public String getAllCompanies(Model model) {
        List<TableCompany> companies = companyService.getAllCompanies();
        model.addAttribute("companies", companies);
        return "mainPage";
    }

    @PostMapping("/add")
    public String add(String companyName, String companyINN, Model model) {
        companyService.addNewCompany(companyName, companyINN);
        return "redirect:/";
    }

    @PostMapping("/delete")
    public String delete(String companyId, Model model) {
        companyService.deleteCompany(companyId);
        return "redirect:/";
    }

    @PostMapping("/edit")
    public String edit(String companyId, String companyName, String companyINN, Model model) {
        companyService.editCompany(companyId, companyName, companyINN);
        List<TableCompany> doubles = checkDoubles(companyINN);
        if (isEmpty(doubles) || doubles.size() == 1) {
            return "redirect:/";
        } else {
            model.addAttribute("doubles", doubles);
            model.addAttribute("showDels", true);
            return "doubles";
        }

    }

    @PostMapping("/check")
    public String check(String companyINN, Model model) {
        List<TableCompany> doubles = checkDoubles(companyINN);
        model.addAttribute("doubles", doubles);
        model.addAttribute("showDels", false);

        return "doubles";
    }

    private List<TableCompany> checkDoubles(String companyINN) {
        return companyService.checkDoubles(companyINN);
    }
}
