package conduitApp.performance.createTokens;

import com.intuit.karate.Runner;

import java.util.HashMap;
import java.util.Map;

public class CreateTokens {

    private static String [] emails = {
            "kakashisensei1@test.com",
            "kakashisensei2@test.com",
            "kakashisensei3@test.com",
    };

    public static void createAccessTokens(){
        for (String email: emails){
            Map<String, Object> account = new HashMap<>();
            account.put("userEmail", email);
            account.put("userPassword", "Welcome1");
            Runner.runFeature("classpath:helpers/CreateToken.feature",account, true);
        }
    }
}
