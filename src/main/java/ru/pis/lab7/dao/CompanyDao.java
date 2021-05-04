package ru.pis.lab7.dao;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;
import ru.pis.lab7.model.TableCompany;
import ru.pis.lab7.repo.CompanyRepo;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;
import java.util.List;

import static java.util.Objects.isNull;

@Repository
@Transactional
@RequiredArgsConstructor
public class CompanyDao {
    private final CompanyRepo companyRepo;
    @PersistenceContext
    private final EntityManager entityManager;

    public List<TableCompany> getAllCompanies() {
        return companyRepo.getAllCompanies();
    }

    public void saveCompany(TableCompany company) {
        if (isNull(company)) {
            throw new IllegalArgumentException("Company is empty");
        }

        entityManager.persist(company);
    }

    public TableCompany getCompanyById(Long id) {
        return companyRepo.getById(id);
    }

    public void deleteCompany(TableCompany company) {
        if (isNull(company)) {
            throw new IllegalArgumentException("Company is empty");
        }

        entityManager.remove(company);
    }

    public List<TableCompany> getAllByCompanyINN(String companyINN) {
        return companyRepo.getAllByCompanyINN(companyINN);
    }
}
