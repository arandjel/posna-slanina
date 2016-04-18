package slanina_posna.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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

		return "home";
	}

	/**
	 * POST requests to http://localhost:8080/hello/addPerson goes here. The new
	 * person data is passed from HTML from and bound into the Person object.
	 */
	@RequestMapping(value = "/addSlanina", method = RequestMethod.POST)
	public String addSlanina(@ModelAttribute Slanina s) {
		slaninaService.add(s);
		return "redirect:/";
	}
}
