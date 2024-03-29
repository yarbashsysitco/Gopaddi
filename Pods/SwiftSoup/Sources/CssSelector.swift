//
//  CssSelector.swift
//  SwiftSoup
//
//  Created by Nabil Chatbi on 21/10/16.
//  Copyright © 2016 Nabil Chatbi.. All rights reserved.
//

import Foundation

/**
 * CSS-like element selector, that finds elements matching a query.
 *
 * <h2>CssSelector syntax</h2>
 * <p>
 * A selector is a chain of simple selectors, separated by combinators. Selectors are <b>case insensitive</b> (including against
 * elements, attributes, and attribute values).
 * </p>
 * <p>
 * The universal selector (*) is implicit when no element selector is supplied (i.e. {@code *.header} and {@code .header}
 * is equivalent).
 * </p>
 * <table summary="">
 * <tr><th align="left">Pattern</th><th align="left">Matches</th><th align="left">Example</th></tr>
 * <!-- other rows omitted for brevity -->
 * </table>
 *
 * @see Element#select(String)
 */
@available(*, deprecated, renamed: "CssSelector")
//typealias Selector = CssSelector

@available(iOS 9.0, *)
open class CssSelector {
    private let evaluator: Evaluator
    private let root: Element

    private init(_ query: String, _ root: Element)throws {
        let query = query.trim()
        try Validate.notEmpty(string: query)

        self.evaluator = try QueryParser.parse(query)

        self.root = root
    }

    private init(_ evaluator: Evaluator, _ root: Element) {
        self.evaluator = evaluator
        self.root = root
    }

    /**
     * Find elements matching selector.
     *
     * @param query CSS selector
     * @param root  root element to descend into
     * @return matching elements, empty if none
     * @throws CssSelector.SelectorParseException (unchecked) on an invalid CSS query.
     */
    public static func select(_ query: String, _ root: Element)throws->Elements {
        return try CssSelector(query, root).select()
    }

    /**
     * Find elements matching selector.
     *
     * @param evaluator CSS selector
     * @param root root element to descend into
     * @return matching elements, empty if none
     */
    public static func select(_ evaluator: Evaluator, _ root: Element)throws->Elements {
        return try CssSelector(evaluator, root).select()
    }

    /**
     * Find elements matching selector.
     *
     * @param query CSS selector
     * @param roots root elements to descend into
     * @return matching elements, empty if none
     */
    public static func select(_ query: String, _ roots: Array<Element>)throws->Elements {
        try Validate.notEmpty(string: query)
        let evaluator: Evaluator = try QueryParser.parse(query)
        var elements: Array<Element> = Array<Element>()
        var seenElements: Array<Element> = Array<Element>()
        // dedupe elements by identity, not equality

        for root: Element in roots {
            let found: Elements = try select(evaluator, root)
            for  el: Element in found.array() {
                if (!seenElements.contains(el)) {
                    elements.append(el)
                    seenElements.append(el)
                }
            }
        }
        return Elements(elements)
    }

    private func select()throws->Elements {
        return try Collector.collect(evaluator, root)
    }

    // exclude set. package open so that Elements can implement .not() selector.
    static func filterOut(_ elements: Array<Element>, _ outs: Array<Element>) -> Elements {
        let output: Elements = Elements()
        for el: Element in elements {
            var found: Bool = false
            for out: Element in outs {
                if (el.equals(out)) {
                    found = true
                    break
                }
            }
            if (!found) {
                output.add(el)
            }
        }
        return output
    }
}
