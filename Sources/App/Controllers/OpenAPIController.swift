//
//  File.swift
//  
//
//  Created by KaayZenn on 18/07/2024.
//

import Foundation
import Vapor
import VaporToOpenAPI

struct OpenAPIController: RouteCollection {

    func boot(routes: RoutesBuilder) throws {

        // generate OpenAPI documentation
        routes.get("swagger.json") { req in
            req.application.routes.openAPI(
                info: InfoObject(
                    title: "Swagger Barrel",
                    description: "This is an API for Barrel",
                    termsOfService: URL(string: "http://swagger.io/terms/"),
                    contact: ContactObject(
                        email: "apiteam@swagger.io"
                    ),
                    license: LicenseObject(
                        name: "Apache 2.0",
                        url: URL(string: "http://www.apache.org/licenses/LICENSE-2.0.html")
                    ),
                    version: Version(1, 0, 17)
                )
            )
        }
        .excludeFromOpenAPI()
    }
}
