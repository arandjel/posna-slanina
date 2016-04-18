package slanina_posna.services;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.hibernate.mapping.Array;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import slanina_posna.entities.Slanina;


@Service
public class SlaninaService {

	  @PersistenceContext
	  private EntityManager em;

	  @Transactional
	  public List<Slanina> getAll(){
		  List<Slanina> slanine = new ArrayList<Slanina>();

		  slanine = em.createQuery("SELECT FROM Slanina s", Slanina.class).getResultList();
		  
		  return slanine;
	  }
	  
	  @Transactional
	  public void add(Slanina s) {
	    em.persist(s);
	  }

}
