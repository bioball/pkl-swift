//===----------------------------------------------------------------------===//
// Copyright © 2026 Apple Inc. and the Pkl project authors. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//===----------------------------------------------------------------------===//

protocol MessageTransport: Sendable {
    /// Send a message to the Pkl server.
    func send(_ message: ClientMessage) throws

    /// Returns a stream that yields messages from the pkl server over time.
    func getMessages() throws -> AsyncThrowingStream<ServerMessage, Error>

    /// Close the transport.
    func close() throws
}
