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

import Foundation
import PklMessagePack

public class ExternalReaderMessageTransport: BaseMessageTransport, @unchecked Sendable {
    override var running: Bool { self._running }
    private var _running = true

    init(reader: Reader, writer: Writer) {
        super.init()
        self.reader = reader
        self.writer = writer
        self.encoder = .init(writer: self.writer)
        self.decoder = .init(reader: self.reader)
    }

    override func decodeMessage(_ messageType: MessageType) throws -> ServerMessage {
        switch messageType {
        case MessageType.INITIALIZE_MODULE_READER_REQUEST:
            return try self.decoder.decode(as: InitializeModuleReaderRequest.self)
        case MessageType.INITIALIZE_RESOURCE_READER_REQUEST:
            return try self.decoder.decode(as: InitializeResourceReaderRequest.self)
        case MessageType.CLOSE_EXTERNAL_PROCESS:
            return try self.decoder.decode(as: CloseExternalProcess.self)
        default:
            return try super.decodeMessage(messageType)
        }
    }

    override func close() {
        self._running = false
    }
}
