package ru.pis.lab7.model;

import lombok.Data;

import javax.persistence.*;

@Data
@Entity
@Table(name = "table_company", schema = "lab7_schema")
public class TableCompany {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String inn;
    @Column(name = "to_delete")
    private Integer toDelete;
}
