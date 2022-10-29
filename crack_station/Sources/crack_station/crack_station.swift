import Foundation

public protocol Decrypter {
    init()

    /// Either returns the cracked plain-text password
    /// or, if unable to crack, then returns nil.
    /// - Parameter shaHash: The SHA-1 or SHA-256 digest that corresponds to the encrypted password.
    /// - Returns: The underlying plain-text password if `shaHash` was successfully cracked. Otherwise returns nil.
    func decrypt(shaHash: String) -> String?
}
 
public struct CrackStation: Decrypter {
    
    public init() {
    }

    func safeShell(_ command: String) throws -> String {
    let task = Process()
    let pipe = Pipe()
    
    task.standardOutput = pipe
    task.standardError = pipe
    task.arguments = ["-c", command]
    task.executableURL = URL(fileURLWithPath: "/bin/sh") //<--updated
    task.standardInput = nil

    try task.run() //<--updated
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)!
    
    return output
    }

public func decrypt(shaHash: String) -> String? {
    let filePath = FileManager.default.currentDirectoryPath + "/Sources/crack_station/Resources/data.json"
    let fileManager = FileManager.default
    print("test1")

    if fileManager.fileExists(atPath: filePath) {
            print("test2")
            do{
                let lookupTable = try loadDictionaryFromDisk()
                let ans = lookupTable[shaHash] ?? nil
                print("test3")
                return ans
            } catch {
                print("test4")
                return "error"
            }
    } else {
            print("test5")

            do{
                let pypath = try safeShell("find . -name maketable.py")
                let pwd = try safeShell("pwd")
                print("Pwd is:",pwd)
                print(type(of: pypath))
                print("Path is:",pypath)
                let result = try safeShell("python3 ../../Sources/crack_station/Resources/maketable.py")
                print("one")
                let _ = try safeShell("mv data.json ../../Sources/crack_station/Resources")
                print("two")
                if result.contains("No such file or directory") {
                    let _ = try safeShell("mv data.json Sources/crack_station")
                    print("two")
                }
                let lookupTable = try loadDictionaryFromDisk()
                let ans = lookupTable[shaHash] ?? "Not found"
                return ans
            } catch {
                return "error"
            }
        }
}

}


func loadDictionaryFromDisk() throws -> [String : String] {
    guard let path = Bundle.module.url(forResource: "data", withExtension: "json") else { return [:] }

        let data = try Data(contentsOf: path)
        let jsonResult = try JSONSerialization.jsonObject(with: data)

        if let lookupTable: Dictionary = jsonResult as? Dictionary<String, String> {
            return lookupTable
        } else {
            return [:]
    }
}
