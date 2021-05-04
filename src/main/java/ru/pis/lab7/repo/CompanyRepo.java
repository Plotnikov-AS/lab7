package ru.pis.lab7.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import ru.pis.lab7.model.TableCompany;

import java.util.List;

@Repository
public interface CompanyRepo extends JpaRepository<TableCompany, Long> {

    @Query("SELECT com FROM TableCompany com")
    List<TableCompany> getAllCompanies();

    TableCompany getById(Long id);

    @Query("SELECT com " +
            "FROM TableCompany com " +
            "WHERE com.inn LIKE CONCAT('%', :companyINN, '%')")
    List<TableCompany> getAllByCompanyINN(@Param("companyINN") String companyINN);
}
