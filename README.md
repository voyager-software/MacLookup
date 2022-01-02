# MacLookup

Lookup for all Mac names, colors, model identifiers and part numbers.

## Usage

Get the Mac model identifier string:

```
let model = MacLookup.shared.getModel()
```

Find the Mac info for the model identifier:

```
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
