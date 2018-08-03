//
//  ViewController.swift
//  Portal World
//
//  Created by يعرب المصطفى on 7/26/18.
//  Copyright © 2018 yarob. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var detectionLabel: UILabel!
    
    var counter = 0
    var success = false
    let regionRedius:Float = 0.3
    
    // MARK: ALL LOCATIONS
    var locations = [Location]()
    var locationNode:SCNNode!
    
    
    // MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locations = LocationsFiller.addLocations()
        
        
        //set up the debugging options
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        
        //horizontal detection
        // Set the view's delegate
        sceneView.delegate = self
        
        //enabling the lights..
        sceneView.automaticallyUpdatesLighting = true
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.sceneView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    // MARK: HANDLING THE TAP
    @objc func handleTap(sender:UITapGestureRecognizer)
    {
        if counter == 0{
            counter = counter+1
            addLocationsToTheScene()
            makeRegionSphere()
//            makeDistanceLabelOfLocatons()
            let scene = sender.view as! ARSCNView
            let location = sender.location(in: scene)
            let hitTest = scene.hitTest(location, types: .existingPlaneUsingExtent)
            if !hitTest.isEmpty
            {
                //addPortal(hitTest: hitTest.first!)
                
            }
        }else if counter == 1{
            replaceNodeWithSuccess()
            counter = 0
        }
        
    }
    
    
    // MARK: OTHER METHODS
    //fill the locations in the scene
    private func makeRegionSphere()
    {
        let sphere = SCNSphere(radius: CGFloat(regionRedius))
        sphere.firstMaterial?.diffuse.contents = UIColor.red
        let sphereNode = SCNNode(geometry: sphere)
        sphereNode.opacity = 0.16
        locationNode.addChildNode(sphereNode)
        sphereNode.position = SCNVector3(0,0,0)
    }
    
    private func addLocationsToTheScene()
    {
        for location in locations{
            let image = UIImage(named: (location.type?.rawValue)!)
            let plane = SCNPlane(width: 0.1, height: 0.1)
            plane.firstMaterial?.diffuse.contents = image
            locationNode = SCNNode(geometry: plane)
            locationNode.position = location.dimensions
            self.sceneView.scene.rootNode.addChildNode(locationNode)
            locationNode.constraints = [SCNBillboardConstraint()]
            addAnimation(node: locationNode)
            self.sceneView.scene.rootNode.addChildNode(locationNode)
            
        }
        
    }
    
    //fill the labels in the scene
    private func makeDistanceLabelOfLocatons()
    {
        
        let rect = CGRect(x: 0, y: 0, width: 500, height: 100)
        
        for location in locations
        {
            let view = PopupMessageView(frame: rect)
            let plane = SCNPlane(width: 0.07, height: 0.033)
            plane.firstMaterial?.diffuse.contents = view
            let node = SCNNode(geometry: plane)
            node.position = location.dimensions
            node.position.y = location.dimensions.y - 0.05
            node.constraints = [SCNBillboardConstraint()]
            self.sceneView.scene.rootNode.addChildNode(node)
        }
        
    }
    
    
    private func replaceNodeWithSuccess()
    {
        guard let _ = locationNode else {return}
        let dimensions = locationNode.position
        locationNode.removeFromParentNode()
        locationNode = nil
        makeSuccessNode(position: dimensions)
    }
    
    private func makeSuccessNode(position : SCNVector3)
    {
        let plane = SCNPlane(width: 0.07, height: 0.07)
        plane.firstMaterial?.diffuse.contents = UIImage(named: "checked")
        let node = SCNNode(geometry: plane)
        node.position = position
        node.geometry?.firstMaterial?.isDoubleSided = true
//        node.constraints = [SCNBillboardConstraint()]
        node.opacity = 0
        
        //enter
        let fadeInAction = SCNAction.fadeIn(duration: 0.5)
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.03, z: 0, duration: 0.6)
        let hoverAndFadeIn = SCNAction.group([fadeInAction,hoverUp])
        
        //exit
        let fadeOutAction = SCNAction.fadeOut(duration: 0.5)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.03, z: 0, duration: 0.6)
        let scale = SCNAction.scale(by: 1.5, duration: 0.6)
        let hoverAndFadeOut = SCNAction.group([fadeOutAction, hoverDown])
        let scaleAndFadeOut = SCNAction.group([fadeOutAction, scale])
        
        
        let rotationAction = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi), z: 0, duration: 1)
        let repeatRotation = SCNAction.repeat(rotationAction, count: 2)
        let actionSequence = SCNAction.sequence([hoverAndFadeIn, repeatRotation, scaleAndFadeOut])
        node.runAction(actionSequence)
        self.sceneView.scene.rootNode.addChildNode(node)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
           self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)

        }
        
    }
    
    /////////////
    func addAnimation(node: SCNNode) {
        let hoverUp = SCNAction.moveBy(x: 0, y: 0.03, z: 0, duration: 0.6)
        let hoverDown = SCNAction.moveBy(x: 0, y: -0.03, z: 0, duration: 0.6)
        let hoverSequence = SCNAction.sequence([hoverUp, hoverDown])
        let repeatForever = SCNAction.repeatForever(hoverSequence)
        node.runAction(repeatForever)
    }
    
    
    private func addPortal(hitTest:ARHitTestResult){
        //load the portal
        let portalScene = SCNScene(named: "art.scnassets/Portal3.scn")
        
        let portalNode = (portalScene?.rootNode.childNode(withName: "Portal", recursively: false))!
        
        //set the position to be in the tap position
        let transform = hitTest.worldTransform
        let xPosition = transform.columns.3.x
        let yPosition = transform.columns.3.y
        let zPosition = transform.columns.3.z
        portalNode.position = SCNVector3(xPosition, yPosition, zPosition)
        self.sceneView.scene.rootNode.addChildNode(portalNode)
       
        //then finally set the images to be the correct ones
        addPlaneImage(atNode: "floor", portal: portalNode, imageName: "MeccaBottomWall")
        addPlaneImage(atNode: "top", portal: portalNode, imageName: "MeccaTopWall")
        addPlaneImage(atNode: "rightWall", portal: portalNode, imageName: "MeccaRightWall")
        addPlaneImage(atNode: "leftWall", portal: portalNode, imageName: "MeccaLeftWall")
        addPlaneImage(atNode: "frontWall", portal: portalNode, imageName: "MeccaFrontWall")
        addPlaneImage(atNode: "leftSideWall", portal: portalNode, imageName: "sideDoorA")
        addPlaneImage(atNode: "rightSideWall", portal: portalNode, imageName: "MeccaBottomWall")
    }
    
    
    
    
    private func addPlaneImage(atNode nodeName : String, portal : SCNNode, imageName : String)
    {
        let child = portal.childNode(withName: nodeName, recursively: true)
        child?.geometry?.firstMaterial?.diffuse.contents = UIImage(named: imageName)
        
        /*
         - the default rendering order of any node = 0
         - the lower the rendering order of a node the earlier to be rendered
         - if the wall is rendered first and then the mask is rendered, that will make the wall mix it's color with the mask which makes it almost transparent
         */
        child?.renderingOrder = 200
        if let mask = child?.childNode(withName: "mask", recursively: false)
        {
            mask.geometry?.firstMaterial?.transparency = 0.0001
        }
    }
    
    
    
    private func sendArrivalRequest()
    {
        Service.arrival { (error) in
            print("done")
        }
    }
    
    
    
    
    
    
    // MARK: DELEGATED METHODS....
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
        
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let camera = sceneView.session.currentFrame?.camera else {return}
        let cameraXPosition = camera.transform.columns.3.x
        let cameraZPosition = camera.transform.columns.3.z
        guard let locationTransform = locationNode?.transform else {return}
        let nodeXPosition = locationNode.transform.m41
        let nodeZPosition = locationNode.transform.m43
        
        
        if abs(cameraXPosition - nodeXPosition) <= regionRedius && abs(cameraZPosition - nodeZPosition) <= regionRedius && success == false
        {
            success = true
            let dimensions = locationNode.position
            locationNode.removeFromParentNode()
            locationNode = nil
            sendArrivalRequest()
            makeSuccessNode(position: dimensions)
        }
    }
    

}
