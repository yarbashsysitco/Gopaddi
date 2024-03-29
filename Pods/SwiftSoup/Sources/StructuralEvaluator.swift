//
//  StructuralEvaluator.swift
//  SwiftSoup
//
//  Created by Nabil Chatbi on 23/10/16.
//  Copyright © 2016 Nabil Chatbi.. All rights reserved.
//

import Foundation

/**
 * Base structural evaluator.
 */
@available(iOS 9.0, *)
public class StructuralEvaluator: Evaluator {
    let evaluator: Evaluator

    public init(_ evaluator: Evaluator) {
        self.evaluator = evaluator
    }

    @available(iOS 9.0, *)
    public class Root: Evaluator {
        public override func matches(_ root: Element, _ element: Element) -> Bool {
            return root === element
        }
    }

    @available(iOS 9.0, *)
    public class Has: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ element: Element)throws->Bool {
            for e in try element.getAllElements().array() {
                do {
                    if(e != element) {
                        if ((try evaluator.matches(root, e))) {
                            return true
                        }
                    }
                } catch {}
            }

            return false
        }

        public override func toString() -> String {
            return ":has(\(evaluator.toString()))"
        }
    }

    @available(iOS 9.0, *)
    public class Not: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ node: Element) -> Bool {
            do {
                return try !evaluator.matches(root, node)
            } catch {}
            return false
        }

        public override func toString() -> String {
            return ":not\(evaluator.toString())"
        }
    }

    @available(iOS 9.0, *)
    public class Parent: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ element: Element) -> Bool {
            if (root == element) {
                return false
            }

            var parent = element.parent()
            while (true) {
                do {
                    if let p = parent, try evaluator.matches(root, p) {
                        return true
                    }
                } catch {}

                if (parent == root) {
                    break
                }
                parent = parent?.parent()
            }
            return false
        }

        public override func toString() -> String {
            return ":parent\(evaluator.toString())"
        }
    }

    @available(iOS 9.0, *)
    public class ImmediateParent: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ element: Element) -> Bool {
            if (root == element) {
                return false
            }

            if let parent = element.parent() {
                do {
                    return try evaluator.matches(root, parent)
                } catch {}
            }

            return false
        }

        public override func toString() -> String {
            return ":ImmediateParent\(evaluator.toString())"
        }
    }

    @available(iOS 9.0, *)
    public class PreviousSibling: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ element: Element)throws->Bool {
            if (root == element) {
            return false
            }

            var prev = try element.previousElementSibling()

            while (prev != nil) {
                do {
                if (try evaluator.matches(root, prev!)) {
                    return true
                }
                } catch {}

                prev = try prev!.previousElementSibling()
            }
            return false
        }

        public override func toString() -> String {
            return ":prev*\(evaluator.toString())"
        }
    }

    @available(iOS 9.0, *)
    class ImmediatePreviousSibling: StructuralEvaluator {
        public override init(_ evaluator: Evaluator) {
            super.init(evaluator)
        }

        public override func matches(_ root: Element, _ element: Element)throws->Bool {
            if (root == element) {
                return false
            }

            if let prev = try element.previousElementSibling() {
                do {
                    return try evaluator.matches(root, prev)
                } catch {}
            }
            return false
        }

        public override func toString() -> String {
            return ":prev\(evaluator.toString())"
        }
    }
}
