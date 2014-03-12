package me.hch;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created with IntelliJ IDEA.
 * User: hch
 * Date: 14-3-12
 * Time: 下午8:23
 * To change this template use File | Settings | File Templates.
 */

@Controller
@RequestMapping("/repo")
public class Repo {
    @RequestMapping(method = RequestMethod.GET)
    public String get() {
        return "repo";
    }
}
