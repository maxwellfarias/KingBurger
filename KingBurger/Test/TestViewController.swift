//
//  TestViewController.swift
//  KingBurger
//
//  Created by Maxwell Farias on 20/09/23.
//

import UIKit
import SwiftUI

class TestViewController: UIViewController {
    
    let progress: UIActivityIndicatorView = {
        let v = UIActivityIndicatorView()
        v.backgroundColor = .clear
        v.layer.zPosition = 2
        v.backgroundColor = .systemBackground
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let coverImg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "backgroundVegetable")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let profileImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "profileImg")
        img.layer.borderWidth = 3
        img.contentMode = .scaleAspectFill
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.white.cgColor
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let nameLb: UILabel = {
        let lb = UILabel()
        lb.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let idIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "idIcon")
        img.tintColor = .label
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let idLb: UILabel = {
        let lb = UILabel()
        lb.textColor = .label
        lb.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let mainContainer: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        v.layer.zPosition = 1
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    let emailIcon: UIImageView = {
        let img = UIImageView()
        img.tintColor = .label
        img.image = UIImage(named: "mailIcon")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let emailLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let documentIcon: UIImageView = {
        let img = UIImageView()
        img.tintColor = .label
        img.image = UIImage(named: "documentIcon")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let documentLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let dateOfBirthIcon: UIImageView = {
        let img = UIImageView()
        img.tintColor = .label
        img.image = UIImage(named: "cakeIcon")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    let dateOfBirthLb: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    //MARK: Properties
    var shape: CAShapeLayer?
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        shape?.removeFromSuperlayer()
        drawForm()
    }
    
    func drawForm (){
        let shapeLayer = CAShapeLayer()
        shapeLayer.position = CGPoint(x: self.mainContainer.frame.minX + 30, y: self.mainContainer.frame.minY + 50)
        shapeLayer.fillColor = KingBurgerColor.background?.cgColor
        
        let height = mainContainer.frame.height
        let width = mainContainer.frame.width
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: width - 60, y: -50))
        path.addCurve(to: CGPoint(x: width - 30, y: -20),
                      controlPoint1: CGPoint(x: width - 50, y: -50),
                      controlPoint2: CGPoint(x: width - 30, y: -40))
        path.addLine(to: CGPoint(x: width - 30, y: height - 50))
        path.addLine(to: CGPoint(x: -30, y: height - 50))
        path.addLine(to: CGPoint(x: -30, y: 30))
        path.addCurve(to: .zero,
                      controlPoint1: CGPoint(x: -30, y: 10),
                      controlPoint2: CGPoint(x: -10, y: 0))
        path.close()
        
        shapeLayer.path = path.cgPath
        self.view.layer.addSublayer(shapeLayer)
        self.shape = shapeLayer
    }
}

extension TestViewController: ViewCodeProtocol {
    func buildViewHierarchy() {
        view.addSubview(coverImg)
        view.addSubview(profileImg)
        view.addSubview(nameLb)
        view.addSubview(idIcon)
        view.addSubview(idLb)
        view.addSubview(mainContainer)
        view.addSubview(progress)
        mainContainer.addSubview(emailIcon)
        mainContainer.addSubview(emailLb)
        mainContainer.addSubview(documentIcon)
        mainContainer.addSubview(documentLb)
        mainContainer.addSubview(dateOfBirthIcon)
        mainContainer.addSubview(dateOfBirthLb)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            progress.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            progress.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            progress.topAnchor.constraint(equalTo: view.topAnchor),
            progress.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            coverImg.topAnchor.constraint(equalTo: view.topAnchor),
            coverImg.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            coverImg.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            coverImg.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        NSLayoutConstraint.activate([
            profileImg.centerYAnchor.constraint(equalTo: coverImg.centerYAnchor),
            profileImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            profileImg.heightAnchor.constraint(equalToConstant: 100),
            profileImg.widthAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: coverImg.bottomAnchor, constant: -80),
            mainContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLb.topAnchor.constraint(equalTo: profileImg.topAnchor, constant: 30),
            nameLb.leadingAnchor.constraint(equalTo: profileImg.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            idIcon.topAnchor.constraint(equalTo: nameLb.bottomAnchor, constant: 10),
            idIcon.leadingAnchor.constraint(equalTo: nameLb.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            idLb.centerYAnchor.constraint(equalTo: idIcon.centerYAnchor),
            idLb.leadingAnchor.constraint(equalTo: idIcon.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            emailIcon.topAnchor.constraint(equalTo: mainContainer.topAnchor, constant: 100),
            emailIcon.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            emailLb.centerYAnchor.constraint(equalTo: emailIcon.centerYAnchor),
            emailLb.leadingAnchor.constraint(equalTo: emailIcon.trailingAnchor, constant: 20)
        ])
        
        
        NSLayoutConstraint.activate([
            documentIcon.topAnchor.constraint(equalTo: emailIcon.bottomAnchor, constant: 20),
            documentIcon.leadingAnchor.constraint(equalTo: emailIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            documentLb.centerYAnchor.constraint(equalTo: documentIcon.centerYAnchor),
            documentLb.leadingAnchor.constraint(equalTo: documentIcon.trailingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            dateOfBirthIcon.topAnchor.constraint(equalTo: documentIcon.bottomAnchor, constant: 20),
            dateOfBirthIcon.leadingAnchor.constraint(equalTo: documentIcon.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateOfBirthLb.centerYAnchor.constraint(equalTo: dateOfBirthIcon.centerYAnchor),
            dateOfBirthLb.leadingAnchor.constraint(equalTo: documentLb.leadingAnchor)
        ])
    }
}


struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = TestViewController
    
    func makeUIViewController(context: Context) -> TestViewController {
        TestViewController()
    }
    
    func updateUIViewController(_ uiViewController: TestViewController, context: Context) {
        
    }
}



struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
