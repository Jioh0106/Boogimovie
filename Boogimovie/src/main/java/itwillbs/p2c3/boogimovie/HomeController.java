package itwillbs.p2c3.boogimovie;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import itwillbs.p2c3.boogimovie.service.MovieInfoService;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private MovieInfoService movieService;
	
	@Autowired
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
	public String home(Model model , HttpSession session,MemberVO member, MovieVO movieTrail) {
		
		
		return "inc/index";
	}
}

//	@GetMapping("movieFuture")//
//	public String movieFuture(Model model) {
//		
//		List<MovieVO> movieFuture = movieService.getMovieFuture();
//		model.addAttribute("movieFuture", movieFuture);
//		//System.out.println("�뿬湲곕뒗 臾대퉬�벂泥�" + movieFuture);�솗�씤�셿猷�
//	    return "movie/movieFuture";
//	}
//}
