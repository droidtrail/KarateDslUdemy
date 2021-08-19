package conduitApp.performance.data

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._
import conduitApp.performance.createTokens.CreateTokens
import scala.util.Random


class PerfTest extends Simulation {

  CreateTokens.createAccessTokens()

  val protocol = karateProtocol(
    "/api/articles/{slugId}"-> Nil
  )

//  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val csvFeeder = csv("articles.csv").circular
  val tokenfeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken))

  val createArticle = scenario("Create and delete article")
    .feed(csvFeeder)
    .feed(csvFeeder)
    .exec(karateFeature("classpath:conduitApp/performance/data/createArticle.feature"))

  setUp(
    createArticle.inject(
        atOnceUsers(1),
        nothingFor(4.seconds),
        constantUsersPerSec(1).during(3.seconds),
//        constantUsersPerSec(1).during(10.seconds),
//        rampUsersPerSec(2).to(10).during(20.seconds),
//        nothingFor(5.seconds),
//        constantUsersPerSec(1).during(5.seconds)
      ).protocols(protocol)
  )
}
