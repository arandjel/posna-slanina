package slanina_posna.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import slanina_posna.entities.Slanina;
import slanina_posna.services.SlaninaService;

@Controller
@RequestMapping("/")
public class IndexController {

	@Autowired
	private SlaninaService slaninaService;

	@RequestMapping(method = RequestMethod.GET)
	public String listAll(Model model) {

		model.addAttribute("slanine", slaninaService.getAll());
		model.addAttribute("slaninaModel", new Slanina());


		return "home";
	}

	/**
	 * POST requests to http://localhost:8080/posna-slanina/addSlanina goes here. The new
	 * slanina data is passed from HTML from and bound into the Slanina object.
	 */
	@RequestMapping(value = "/addSlanina", method = RequestMethod.POST)
	public String addSlanina(@ModelAttribute Slanina s) {
		slaninaService.add(s);
		return "redirect:/";
	}
	
	/**
	 * AJAX GET method for slanina search.
	 * @param tagName
	 * @return
	 */
	@RequestMapping(value = "/searchSlanina", method = RequestMethod.GET)
	public @ResponseBody List<Slanina> getTags(@RequestParam (value="search_string") String searchString) {

		return getSearchResult(searchString);

	}

	/**
	 * Searches from list of all slanina names for search string.
	 * @param searchString String for slanina name search
	 * @return List of Slaninas that contain search string
	 */
	private List<Slanina> getSearchResult(String searchString) {

		List<Slanina> data = slaninaService.getAll();
		
		List<Slanina> result = new ArrayList<Slanina>();

		// iterate a list and filter by tagName
		for (Slanina slanina : data) {
			
			// toUpperCase so it wont be case sensitive
			if (slanina.getName().toUpperCase().contains(searchString.toUpperCase())) 
				result.add(slanina);
		}

		return result;
	}
	
	/**
	 * AJAX POST create Slanina method
	 * @param slanina
	 * @return
	 */
	@RequestMapping(value="/create", method=RequestMethod.POST,
			produces = MediaType.APPLICATION_JSON_VALUE, 
			consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody Slanina createSlanina(@RequestBody Slanina slanina) {
		
		System.out.println("Create slanina method");
		
		slaninaService.add(slanina);
		return slanina;
	}

}
