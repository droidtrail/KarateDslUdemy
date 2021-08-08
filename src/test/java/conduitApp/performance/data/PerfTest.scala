package conduitApp.performance.data

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

class PerfTest extends Simulation {

  val protocol = karateProtocol(
    "/api/articles/{slugId}"-> Nil
  )

//  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
//  protocol.runner.karateEnv("perf")

  val createArticle = scenario("Create and delete article").exec(karateFeature("classpath:conduitApp/performance/data/createArticle.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(1)
      ).protocols(protocol)
  )
}
