//
//  Extensions+UIView.swift
//  SlideOutMenuInProgress
//
//  Created by Brian Voong on 9/30/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

// Reference Video: https://youtu.be/iqpAP7s3b-8
extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
}

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        
        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        
        // Deactivate all constraints
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))
        
        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}


enum PaletteOption{
    case powder
    case houseParty
    case rainbow
}

class Palette{
    static let powder:[UIColor] = [.daisy, .powderBlue, .powderPink, .powderRose, .moonstone, .carnation]
    var colors:[UIColor]!
    
    init(_ option:PaletteOption){
        switch option{
        case .houseParty:
            colors = [.red, .blue,.green, .yellow]
            return
        case .rainbow:
            colors = [.red, .orange, .yellow, .green, .aqua, .ocean, .purple]
            return
        case .powder:
            colors = Palette.powder
            return
        }
    }
    convenience init()
    {
        self.init(.powder)
    }
    var cursor:Int = 0
    public func nextColor() -> UIColor {
        //might have reentry here? the following is trying to protect from overflow...
        if cursor >= colors.count {
            print("palette :\(cursor) % \(colors.count)")
            cursor = cursor % colors.count
        }
        let color = colors[cursor]
        cursor = cursor + 1
        if cursor == colors.count {
            cursor = 0
        }
        return color
    }
}

extension UIColor{
    static let blue     = #colorLiteral(red: 0, green: 0.3874890696, blue: 1, alpha: 1)
    static let yellow   = #colorLiteral(red: 1, green: 0.9226376385, blue: 0.02335676379, alpha: 1)
    static let green    = #colorLiteral(red: 0.01019298735, green: 1, blue: 0.1852172231, alpha: 1)
    static let red      = #colorLiteral(red: 1, green: 0.2050454388, blue: 0, alpha: 1)
    
    static let powderPink = #colorLiteral(red: 0.9948795438, green: 0.8357726932, blue: 0.8370730281, alpha: 1)
    static let powderRose = #colorLiteral(red: 0.9904679656, green: 0.6277672648, blue: 0.6798757911, alpha: 1)
    static let apricot   = #colorLiteral(red: 0.9771728516, green: 0.8985981102, blue: 0.9036098097, alpha: 1)
    static let beam      = #colorLiteral(red: 0.8784313725, green: 0.9098039216, blue: 0.9215686275, alpha: 1)
    static let columbia  = #colorLiteral(red: 0.6784313725, green: 0.7960784314, blue: 0.8392156863, alpha: 1)
    static let powderBlue = #colorLiteral(red: 0.8279750943, green: 0.9118388295, blue: 1, alpha: 1)
    static let moonstone = #colorLiteral(red: 0.4941176471, green: 0.6941176471, blue: 0.9137254902, alpha: 1)
    static let ceil      = #colorLiteral(red: 0.6784313725, green: 0.7019607843, blue: 0.6745098039, alpha: 1)
    static let pinkRose  = #colorLiteral(red: 0.9803921569, green: 0.8352941176, blue: 0.8745098039, alpha: 1)
    static let thulian   = #colorLiteral(red: 0.8470588235, green: 0.7333333333, blue: 0.768627451, alpha: 1)
    static let bronze    = #colorLiteral(red: 0.7490196078, green: 0.5647058824, blue: 0.3764705882, alpha: 1)
    static let daffodil  = #colorLiteral(red: 0.937254902, green: 0.9921568627, blue: 0.4823529412, alpha: 1)
    static let carrot    = #colorLiteral(red: 1, green: 0.7960784314, blue: 0.3921568627, alpha: 1)
    static let emerald   = #colorLiteral(red: 0.4274509804, green: 0.7411764706, blue: 0.5882352941, alpha: 1)
    static let citron    = #colorLiteral(red: 0.5411764706, green: 0.6392156863, blue: 0.3490196078, alpha: 1)
    static let calpoly   = #colorLiteral(red: 0.2156862745, green: 0.4117647059, blue: 0.3137254902, alpha: 1)
    static let navy      = #colorLiteral(red: 0.2320088329, green: 0.3193989656, blue: 0.4499584691, alpha: 1)
    static let sepia     = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
    static let russet    = #colorLiteral(red: 0.6299447139, green: 0.4034464731, blue: 0.1642781825, alpha: 1)
    static let bazantium = #colorLiteral(red: 0.5461227499, green: 0.3607718264, blue: 0.6429147593, alpha: 1)
    static let eton      = #colorLiteral(red: 0.6784313725, green: 0.7764705882, blue: 0.6784313725, alpha: 1)
    static let pansy     = #colorLiteral(red: 0.4901960784, green: 0.3215686275, blue: 0.3254901961, alpha: 1)
    static let tungsten  = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    static let iron      = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    static let steel     = #colorLiteral(red: 0.4756349325, green: 0.4756467342, blue: 0.4756404161, alpha: 1)
    static let aluminum  = #colorLiteral(red: 0.6642242074, green: 0.6642400622, blue: 0.6642315388, alpha: 1)
    static let silver    = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
    static let cayenne    = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
    static let mocha      = #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
    static let maraschino = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    static let salmon     = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
    static let tangerine  = #colorLiteral(red: 0.9098039216, green: 0.6549019608, blue: 0.4705882353, alpha: 1)
    static let asparagus = #colorLiteral(red: 0.5738074183, green: 0.5655357838, blue: 0, alpha: 1)
    static let fern      = #colorLiteral(red: 0.3084011078, green: 0.5618229508, blue: 0, alpha: 1)
    static let clover    = #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)
    static let moss      = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
    static let teal      = #colorLiteral(red: 0, green: 0.5690457821, blue: 0.5746168494, alpha: 1)
    static let ocean     = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    static let eggplant  = #colorLiteral(red: 0.3236978054, green: 0.1063579395, blue: 0.574860394, alpha: 1)
    static let plum     = #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
    static let maroon   = #colorLiteral(red: 0.5808190107, green: 0.0884276256, blue: 0.3186392188, alpha: 1)
  
    static let lemon    = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
    static let lime     = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1)
    static let seaform  = #colorLiteral(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1)
    static let turquiose = #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1)
    static let aqua     = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
    static let blueberry = #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
    static let grape =    #colorLiteral(red: 0.5818830132, green: 0.2156915367, blue: 1, alpha: 1)
    static let raspberry = #colorLiteral(red: 0.7223178148, green: 0.4098159969, blue: 0.5524566174, alpha: 1)
    static let strawberry = #colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1)
    
    static let cantaloupe = #colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)
    static let banana   = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    static let honeydew = #colorLiteral(red: 0.8321695924, green: 0.985483706, blue: 0.4733308554, alpha: 1)
    static let flora    = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
    static let spindrift = #colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)
    static let ice      = #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
    static let sky      = #colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1)
    static let orchid   = #colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)
    static let lavender = #colorLiteral(red: 0.8446564078, green: 0.5145705342, blue: 1, alpha: 1)
    static let bubblegum = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
    static let carnation = #colorLiteral(red: 1, green: 0.5409764051, blue: 0.8473142982, alpha: 1)
    static let mainPink  = #colorLiteral(red: 0.9098039269, green: 0.3918348439, blue: 0.7681612409, alpha: 1)
    static let ivory     = #colorLiteral(red: 1, green: 0.9652804248, blue: 0.9005014266, alpha: 1)
    static let sakura    = #colorLiteral(red: 0.9120692611, green: 0.6926058531, blue: 0.8034974933, alpha: 1)
    static let mist      = #colorLiteral(red: 0.9583352599, green: 0.9917766225, blue: 1, alpha: 1)
    static let frost     = #colorLiteral(red: 0.8816741756, green: 0.9693696056, blue: 1, alpha: 1)
    static let satin    = #colorLiteral(red: 0.870794191, green: 0.8652231062, blue: 1, alpha: 1)
    static let tea      = #colorLiteral(red: 0.8657763702, green: 1, blue: 0.7667039538, alpha: 1)
    static let snow     = #colorLiteral(red: 0.9618657231, green: 0.9961244464, blue: 0.9922079444, alpha: 1)
    static let porcelain = #colorLiteral(red: 0.9996616244, green: 0.9963043332, blue: 0.987546742, alpha: 1)
    static let powder   = #colorLiteral(red: 0.9841006398, green: 0.9886662364, blue: 0.967246592, alpha: 1)
    static let mercury  = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
    static let champagne = #colorLiteral(red: 0.9693065286, green: 0.9077809453, blue: 0.8081459403, alpha: 1)
    static let pearl    = #colorLiteral(red: 0.9816612601, green: 0.9391016364, blue: 0.839841783, alpha: 1)
    static let platinum = #colorLiteral(red: 0.8977114558, green: 0.8943374753, blue: 0.8855970502, alpha: 1)
    static let salt     = #colorLiteral(red: 0.9450812936, green: 0.9491452575, blue: 0.9447738528, alpha: 1)
    static let dove     = #colorLiteral(red: 0.8865637183, green: 0.9063408971, blue: 0.880910337, alpha: 1)
    static let lace     = #colorLiteral(red: 0.9903687835, green: 0.9619671702, blue: 0.9015548229, alpha: 1)
    static let daisy    = #colorLiteral(red: 0.9998918176, green: 1, blue: 0.9998809695, alpha: 1)
    static let timberwolf = #colorLiteral(red: 0.8579654098, green: 0.8436121345, blue: 0.8219086528, alpha: 1)
    static let eggShell  = #colorLiteral(red: 0.9394348264, green: 0.9191524982, blue: 0.8374637961, alpha: 1)
    static let bone     = #colorLiteral(red: 0.9731615186, green: 0.9241473079, blue: 0.7773621678, alpha: 1)
    static let blanched = #colorLiteral(red: 0.9961332679, green: 0.9198589921, blue: 0.8027213216, alpha: 1)
    static let antique  = #colorLiteral(red: 0.9813427329, green: 0.9231867194, blue: 0.8408043385, alpha: 1)
}

extension UIFont{
    static let bigfoot = UIFont(name:"PingFangTC-Medium", size: 80)
}

extension UILabel {
    func ColorChange (fullText : String , texts:[String], colors:[UIColor] ) {
        let strNumber: NSString = fullText as NSString
        
      
        let attribute = NSMutableAttributedString.init(string: fullText)
        var range:NSRange
        var i:Int = 0
        while i < texts.count && i < colors.count {
            range = (strNumber).range(of: texts[i])
            attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: colors[i] , range: range)
            i = i + 1
        }
        self.attributedText = attribute
    }
}
