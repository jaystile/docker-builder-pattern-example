package com.greatedebate.server.v1;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController()
@RequestMapping("/server/v1")
public class ServerService {

    /**
     * Test connectivity or preflight connections
     * @return "ACK"
     */
    @GetMapping("/acknowledge")
    String acknowledge() {
      return "ACK";
    }
}