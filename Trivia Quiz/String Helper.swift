//
//  String Helper.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/25/22.
//

import Foundation

func cleanString(_ string: String) -> String {
    var newString = string
    while newString.contains("&quot;") {
        if let range = newString.range(of: "&quot;") {
            newString.replaceSubrange(range, with: "'")
        }
    }
    while newString.contains("&lsquo;") {
        if let range = newString.range(of: "&lsquo;") {
            newString.replaceSubrange(range, with: "'")
        }
    }
    while newString.contains("&rsquo;") {
        if let range = newString.range(of: "&rsquo;") {
            newString.replaceSubrange(range, with: "'")
        }
    }
    while newString.contains("&eacute;") {
        if let range = newString.range(of: "&eacute;") {
            newString.replaceSubrange(range, with: "é")
        }
    }
    while newString.contains("&ldquo;") {
        if let range = newString.range(of: "&ldquo;") {
            newString.replaceSubrange(range, with: "\"")
        }
    }
    while newString.contains("&rdquo;") {
        if let range = newString.range(of: "&rdquo;") {
            newString.replaceSubrange(range, with: "\"")
        }
    }
    while newString.contains("&#039;") {
        if let range = newString.range(of: "&#039;") {
            newString.replaceSubrange(range, with: "'")
        }
    }
    while newString.contains("&pi;") {
        if let range = newString.range(of: "&pi;") {
            newString.replaceSubrange(range, with: "π")
        }
    }
    while newString.contains("&amp;") {
        if let range = newString.range(of: "&amp;") {
            newString.replaceSubrange(range, with: "&")
        }
    }
    while newString.contains("&euml;") {
        if let range = newString.range(of: "&euml;") {
            newString.replaceSubrange(range, with: "ë")
        }
    }
    while newString.contains("&oacute;") {
        if let range = newString.range(of: "&oacute;") {
            newString.replaceSubrange(range, with: "ó")
        }
    }
    while newString.contains("&iacute;") {
        if let range = newString.range(of: "&iacute;") {
            newString.replaceSubrange(range, with: "í")
        }
    }
    while newString.contains("&Aacute;") {
        if let range = newString.range(of: "&Aacute;") {
            newString.replaceSubrange(range, with: "Á")
        }
    }
    while newString.contains("&uuml;") {
        if let range = newString.range(of: "&uuml;") {
            newString.replaceSubrange(range, with: "ü")
        }
    }
    while newString.contains("&ouml;") {
        if let range = newString.range(of: "&ouml;") {
            newString.replaceSubrange(range, with: "ö")
        }
    }
    while newString.contains("&aring;") {
        if let range = newString.range(of: "&aring;") {
            newString.replaceSubrange(range, with: "å")
        }
    }
    while newString.contains("&auml;") {
        if let range = newString.range(of: "&auml;") {
            newString.replaceSubrange(range, with: "ä")
        }
    }
    while newString.contains("&Omicron;") {
        if let range = newString.range(of: "&Omicron;") {
            newString.replaceSubrange(range, with: "Ο")
        }
    }
    while newString.contains("&Nu;") {
        if let range = newString.range(of: "&Nu;") {
            newString.replaceSubrange(range, with: "Ν")
        }
    }
    while newString.contains("&Sigma;") {
        if let range = newString.range(of: "&Sigma;") {
            newString.replaceSubrange(range, with: "Σ")
        }
    }
    while newString.contains("&Pi;") {
        if let range = newString.range(of: "&Pi;") {
            newString.replaceSubrange(range, with: "Π")
        }
    }
    
    
    return newString
}
