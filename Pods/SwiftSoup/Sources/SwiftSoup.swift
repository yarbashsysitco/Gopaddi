import Foundation

@available(iOS 9.0, *)
public func parse(_ html: String, _ baseUri: String)throws->Document {
    if #available(iOS 9.0, *) {
        return try Parser.parse(html, baseUri)
    } else {
        if #available(iOS 9.0, *) {
            let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
            return try Parser.parse(html, baseUri)
        } else {
            // Fallback on earlier versions
            fatalError("Parsing HTML is not supported on iOS versions earlier than 9.0.")
        }
    }
}

@available(iOS 9.0, *)
public func parse(_ html: String, _ baseUri: String, _ parser: Parser)throws->Document {
    return try parser.parseInput(html, baseUri)
}

@available(iOS 9.0, *)
public func parse(_ html: String)throws->Document {
    if #available(iOS 9.0, *) {
        return try Parser.parse(html, "")
    } else {
        if #available(iOS 9.0, *) {
            let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
            return try Parser.parse(html, "")
        } else {
            // Fallback on earlier versions
            fatalError("Parsing HTML is not supported on iOS versions earlier than 9.0.")
        }
    }
}

@available(iOS 9.0, *)
public func parseBodyFragment(_ bodyHtml: String, _ baseUri: String)throws->Document {
    if #available(iOS 9.0, *) {
        return try Parser.parseBodyFragment(bodyHtml, baseUri)
    } else {
        if #available(iOS 9.0, *) {
            let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
            return try Parser.parseBodyFragment(bodyHtml, baseUri)
        } else {
            // Fallback on earlier versions
            fatalError("Parsing HTML body fragments is not supported on iOS versions earlier than 9.0.")
        }
    }
}

@available(iOS 9.0, *)
public func parseBodyFragment(_ bodyHtml: String)throws->Document {
    if #available(iOS 9.0, *) {
        return try Parser.parseBodyFragment(bodyHtml, "")
    } else {
        if #available(iOS 9.0, *) {
            let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
            return try Parser.parseBodyFragment(bodyHtml, "")
        } else {
            // Fallback on earlier versions
            fatalError("Parsing HTML body fragments is not supported on iOS versions earlier than 9.0.")
        }
    }
}

@available(iOS 9.0, *)
public func clean(_ bodyHtml: String, _ baseUri: String, _ whitelist: Whitelist) throws -> String? {
    let dirty: Document // Define dirty in a common scope accessible to both if blocks

    if #available(iOS 9.0, *) {
        dirty = try Parser.parseBodyFragment(bodyHtml, baseUri)
    } else {
        let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
        dirty = try Parser.parseBodyFragment(bodyHtml, baseUri)
    }

    let cleaner = Cleaner(whitelist)
    let clean = try cleaner.clean(dirty)
    return try clean.body()?.html()
}

public func clean(_ bodyHtml: String, _ whitelist: Whitelist) throws -> String? {
    if #available(iOS 9.0, *) {
        return try SwiftSoup.clean(bodyHtml, "", whitelist)
    } else {
        // Fallback on earlier versions
        return nil
    }
}


@available(iOS 9.0, *)
public func clean(_ bodyHtml: String, _ baseUri: String, _ whitelist: Whitelist, _ outputSettings: OutputSettings)throws->String? {
    let dirty: Document
    if #available(iOS 9.0, *) {
        dirty = try Parser.parseBodyFragment(bodyHtml, baseUri)
    } else {
        if #available(iOS 9.0, *) {
            let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
            dirty = try Parser.parseBodyFragment(bodyHtml, baseUri)
        } else {
            // Fallback on earlier versions
            fatalError("Parsing HTML body fragments is not supported on iOS versions earlier than 9.0.")
        }
    }
    let cleaner: Cleaner = Cleaner(whitelist)
    let clean: Document = try cleaner.clean(dirty)
    clean.outputSettings(outputSettings)
    return try clean.body()?.html()
}

@available(iOS 9.0, *)
public func isValid(_ bodyHtml: String, _ whitelist: Whitelist)throws->Bool {
    let dirty: Document // Define dirty in a common scope accessible to both if blocks

    if #available(iOS 9.0, *) {
        dirty = try parseBodyFragment(bodyHtml, "")
    } else {
        let parser = Parser(HtmlTreeBuilder()) // Instantiate Parser with appropriate TreeBuilder
        dirty = try Parser.parseBodyFragment(bodyHtml, "")
    }

    let cleaner = Cleaner(whitelist)
    return try cleaner.isValid(dirty)
}
