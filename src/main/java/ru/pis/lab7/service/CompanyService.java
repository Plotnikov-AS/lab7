package ru.pis.lab7.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import ru.pis.lab7.dao.CompanyDao;
import ru.pis.lab7.model.TableCompany;

import java.util.List;

import static java.util.Collections.emptyList;
import static org.springframework.util.CollectionUtils.isEmpty;

@Service
@RequiredArgsConstructor
public class CompanyService {
    private final CompanyDao companyDao;

    public List<TableCompany> getAllCompanies() {
        return companyDao.getAllCompanies();
    }

    public void addNewCompany(String companyName, String companyINN) {
        TableCompany company = new TableCompany();
        company.setName(companyName);
        company.setInn((companyINN));
        company.setToDelete(0);

        companyDao.saveCompany(company);
    }

    public void deleteCompany(String companyId) {
        TableCompany company = companyDao.getCompanyById(Long.valueOf(companyId));
        companyDao.deleteCompany(company);
    }

    public void editCompany(String companyId, String companyName, String companyINN) {
        TableCompany company = companyDao.getCompanyById(Long.valueOf(companyId));
        company.setName(companyName);
        company.setInn((companyINN));
        companyDao.saveCompany(company);
    }

    public List<TableCompany> checkDoubles(String companyINN) {
        List<TableCompany> companies = companyDao.getAllByCompanyINN(companyINN);
        if (isEmpty(companies)) {
            return emptyList();
        }

        for (int i = 1; i < companies.size(); i++) {
            companyDao.getCompanyById(companies.get(i).getId()).setToDelete(1);
        }

        return companies;
    }
}
