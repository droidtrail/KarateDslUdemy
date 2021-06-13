package conduitApp;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

class ConduitTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:conduitApp/feature").parallel(5);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
 }

