//
//  OpenAIConnector.swift
//  ChatGPT
//
//  Created by Pablo Navarro Zepeda on 17/11/23.
//

import Foundation
import Combine

class OpenAIConnector: ObservableObject {
    /// This URL might change in the future, so if you get an error, make sure to check the OpenAI API Reference.
    let openAIURL = URL(string: "https://api.openai.com/v1/chat/completions")
    let openAIKey = ""
    
    /// This is what stores your messages. You can see how to use it in a SwiftUI view here:
    @Published var messageLog: [[String: String]] = [
        /// Modify this to change the personality of the assistant.
        ["role": "system", "content": "You're a friendly, helpful assistant"],        
        
    ]

    func sendToAssistant() async {
        print("Request Started")

        var request = URLRequest(url: self.openAIURL!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(self.openAIKey)", forHTTPHeaderField: "Authorization")

        let httpBody: [String: Any] = [
            "model" : "gpt-3.5-turbo",
            "messages" : messageLog
        ]

        var httpBodyJson: Data? = nil
        do {
            httpBodyJson = try JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        } catch {
            print("Unable to convert to JSON \(error)")
            logMessage("error", messageUserType: .assistant)
            return
        }

        request.httpBody = httpBodyJson

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let jsonStr = String(data: data, encoding: .utf8) {
                print(jsonStr)
                let responseHandler = OpenAIResponseHandler()
                if let message = responseHandler.decodeJson(jsonString: jsonStr)?.choices[0].message["content"] {
                    DispatchQueue.main.async {
                        self.logMessage(message, messageUserType: .assistant)
                    }
                }
            }
        } catch {
            print("Network request failed: \(error)")
            logMessage("error", messageUserType: .assistant)
        }
    }
}


/// Don't worry about this too much. This just gets rid of errors when using messageLog in a SwiftUI List or ForEach.
extension Dictionary: Identifiable { public var id: UUID { UUID() } }
extension Array: Identifiable { public var id: UUID { UUID() } }
extension String: Identifiable { public var id: UUID { UUID() } }

/// DO NOT TOUCH THIS. LEAVE IT ALONE.
extension OpenAIConnector {
    private func executeRequest(request: URLRequest, withSessionConfig sessionConfig: URLSessionConfiguration?) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        let session: URLSession
        if (sessionConfig != nil) {
            session = URLSession(configuration: sessionConfig!)
        } else {
            session = URLSession.shared
        }
        var requestData: Data?
        let task = session.dataTask(with: request as URLRequest, completionHandler:{ (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if error != nil {
                print("error: \(error!.localizedDescription): \(error!.localizedDescription)")
            } else if data != nil {
                requestData = data
            }
            
            print("Semaphore signalled")
            semaphore.signal()
        })
        task.resume()
        
        // Handle async with semaphores. Max wait of 10 seconds
        let timeout = DispatchTime.now() + .seconds(20)
        print("Waiting for semaphore signal")
        let retVal = semaphore.wait(timeout: timeout)
        print("Done waiting, obtained - \(retVal)")
        return requestData
    }
}

extension OpenAIConnector {
    /// This function makes it simpler to append items to messageLog.
    func logMessage(_ message: String, messageUserType: MessageUserType) {
        var messageUserTypeString = ""
        switch messageUserType {
        case .user:
            messageUserTypeString = "user"
        case .assistant:
            messageUserTypeString = "assistant"
        }
        
        messageLog.append(["role": messageUserTypeString, "content": message])
    }
    
    enum MessageUserType {
        case user
        case assistant
    }
}
