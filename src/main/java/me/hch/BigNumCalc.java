package me.hch;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Created by huaiwang on 14-3-12.
 */

@Controller
@RequestMapping("/calc")
public class BigNumCalc {
    @RequestMapping(method = RequestMethod.GET)
    public String calc() {
        return "calc";
    }
}
