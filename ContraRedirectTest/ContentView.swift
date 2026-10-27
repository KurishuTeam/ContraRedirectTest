import SwiftUI

extension FileManager.SearchPathDirectory: CustomStringConvertible {
    public var description: String {
        switch self {
        case .libraryDirectory:
            "Library"
        case .documentDirectory:
            "Documents"
        case .cachesDirectory:
            "Caches"
        case .applicationSupportDirectory:
            "Application Support"
        case .downloadsDirectory:
            "Downloads"
        default:
            "RawValue: \(rawValue)"
        }
    }
}

struct ContentView: View {
    @State var status = "Checking"
    
    @State var map: [FileManager.SearchPathDirectory:[URL]] = [:]
    
    let searchPaths: [FileManager.SearchPathDirectory] = [
        .documentDirectory,
        .libraryDirectory,
        .applicationSupportDirectory,
        .cachesDirectory
    ]
    
    var body: some View {
        VStack {
            NavigationStack {
                VStack {
                    List {
                        Text("Status: **\(status)**")
                        Section("Paths") {
                            ForEach(searchPaths, id: \.self) { searchPath in
                                Text("\(searchPath): `\(getString(forSearchPath: searchPath))`")
                            }
                        }
                    }
                }
                .navigationTitle("ContraRedirect Test")
            }
        }
        .onAppear {
            checkHooks()
        }
    }
    
    func getString(forSearchPath searchPath: FileManager.SearchPathDirectory) -> String {
        return map[searchPath]?.description ?? "nil"
    }
    
    func checkHooks() {
        
        
        var urls: [[URL]] = []
        
        
        for searchPath in searchPaths {
            let url = FileManager.default.urls(for: searchPath, in: .userDomainMask)
            urls.append(url)
            
            for a in url {
                print(a)
                if a.path.contains("/var/mobile/") {
                    status = "Fail (1 or more paths contain /var/mobile/)"
                }
            }
            
            map[searchPath] = url
        }
        
        if urls.isEmpty {
            status = "Fail (URLs were empty)"
        } else if status == "Checking" {
            status = "Success"
        }
    }
}
