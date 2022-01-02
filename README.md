# MacLookup

Lookup for all Mac names, colors, model identifiers and part numbers.

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/voyager-software/MacLookup.git", from: "1.0.1"),
    /// ...
]
```

## Usage

```swift
import MacLookup
```

Get the Mac model identifier string:

```swift
let model = MacLookup.shared.getModel()
```

Find the Mac info for the model identifier:

```swift
if let model = MacLookup.shared.getModel() 
{
    // "iMac21,2"

    if let mac = MacLookup.shared.find(model: model)
    {
        print(mac.name)     // "iMac (24-inch, M1, 2021)"
        print(mac.colors)   // ["Silver","pink","blue","green"]
        print(mac.models)   // ["iMac21,2"]
        print(mac.parts)    // ["MGTF3xx/a","MJV83xx/a","MJV93xx/a","MJVA3xx/a"]
    }
}
```
