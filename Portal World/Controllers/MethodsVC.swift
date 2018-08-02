////
////  MethodsVC.swift
////  Portal World
////
////  Created by يعرب المصطفى on 8/1/18.
////  Copyright © 2018 yarob. All rights reserved.
////
//
//import Foundation
//
//
//private func add2dView()
//{
//    
//    let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
//    //the label's dimensions
//    let labelXPos = 0
//    let labelYPos = 0
//    let labelCenterPoint = CGPoint(x: labelXPos, y: labelYPos)
//    let labelSize = CGSize(width: view.frame.width, height: view.frame.height)
//    let label = UILabel(frame: CGRect(origin: labelCenterPoint, size: labelSize))
//    label.backgroundColor = .red
//    label.text = "Hello World!"
//    label.font = UIFont(name: label.font.fontName, size: 10)
//    view.backgroundColor = UIColor.green
//    view.addSubview(label)
//    let plane = SCNPlane(width: 0.2, height: 0.2)
//    plane.firstMaterial?.diffuse.contents = view
//    let node = SCNNode(geometry: plane)
//    self.sceneView.scene.rootNode.addChildNode(node)
//    node.constraints = [SCNBillboardConstraint()]
//}
//
//
//private func addSpriteKitObject()
//{
//    let labelNode = SKLabelNode(text: "👾")
//    labelNode.horizontalAlignmentMode = .center
//    labelNode.verticalAlignmentMode = .center
//    
//    //creating the plane
//    let plane = SCNPlane(width: 0.2, height: 0.2)
//    plane.firstMaterial?.diffuse.contents = labelNode
//    let node = SCNNode(geometry: plane)
//    self.sceneView.scene.rootNode.addChildNode(node)
//    node.constraints = [SCNBillboardConstraint()]
//    
//}
//
//
//private func addImage()
//{
//    let text = "Hello, Stack Overflow."
//    let font = UIFont(name: "Arial", size: CGFloat(5))
//    let width = 128
//    let height = 128
//    
//    let fontAttrs: [NSAttributedStringKey: Any] =
//        [NSAttributedStringKey.font: font as! UIFont]
//    let renderer = UIGraphicsImageRenderer(size: CGSize(width: CGFloat(width), height: CGFloat(height)))
//    let image = renderer.image { context in
//        let color = UIColor.blue.withAlphaComponent(CGFloat(0.5))
//        let rect = CGRect(x: 0, y: 0, width: 10, height: 10)
//        
//        color.setFill()
//        context.fill(rect)
//        
//        text.draw(with: rect, options: .usesLineFragmentOrigin, attributes: fontAttrs, context: nil)
//    }
//    
//    let plane = SCNPlane(width: CGFloat(0.1), height: CGFloat(0.1))
//    plane.firstMaterial?.diffuse.contents = image
//    
//    let node = SCNNode(geometry: plane)
//    self.sceneView.scene.rootNode.addChildNode(node)
//}
//
//
//
//private func getViewFromXib()
//{
//    let rect = CGRect(x: 0, y: 0, width: 500, height: 100)
//    let view = PopupMessageView(frame: rect)
//    let plane = SCNPlane(width: 0.3, height: 0.1)
//    plane.firstMaterial?.diffuse.contents = view
//    plane.firstMaterial?.normal.contents = UIColor.clear
//    let node = SCNNode(geometry: plane)
//    node.position = SCNVector3(0,0,-0.25)
//    self.sceneView.scene.rootNode.addChildNode(node)
//    node.constraints = [SCNBillboardConstraint()]
//}
//
//
