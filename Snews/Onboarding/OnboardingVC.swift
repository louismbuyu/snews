//
//  OnboardingVC.swift
//  Snews
//
//  Created by Louis Nelson Levoride on 03.08.18.
//  Copyright © 2018 LouisNelson. All rights reserved.
//

import Foundation
import UIKit

class OnboardingVC: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var generalIndex = 0
    let pages = [
        Page(image1: "sort1",image2: "vox",image3: "sort3", headerText: NSLocalizedString("SORT", comment: "--"), bodyText: NSLocalizedString("SORT_DESC", comment: "--")),
        Page(image1: "save1",image2: "recode",image3: "save3", headerText: NSLocalizedString("SAVE", comment: "--"), bodyText: NSLocalizedString("SAVE_DESC", comment: "--")),
        Page(image1: "share1",image2: "techc",image3: "share3", headerText: NSLocalizedString("SHARE", comment: "--"), bodyText: NSLocalizedString("SHARE_DESC", comment: "--")),
        ]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        var view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isPagingEnabled = true
        view.backgroundColor = .white
        view.delegate = self
        view.dataSource = self
        view.register(OnboardingCell.self, forCellWithReuseIdentifier: "OnboardingCell")
        return view
    }()
    
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("Next", comment: "--"), for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(BLUE, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        print(nextIndex)
        print(generalIndex)
        
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if nextIndex == 2 {
            self.nextButton.backgroundColor = BLUE
            self.nextButton.setTitleColor(.white, for: .normal)
            self.nextButton.setTitle(NSLocalizedString("JOINSNEWS", comment: "--"), for: .normal)
            self.nextButton.addTarget(self, action: #selector(joinAction), for: .touchUpInside)
            /*
             generalIndex = nextIndex
             */
        }
    }
    
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = BLUE
        pc.pageIndicatorTintColor = UIColor(red: 249/255, green: 207/255, blue: 224/255, alpha: 1)
        return pc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(nextButton)
        self.nextButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.nextButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        self.nextButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(pageControl)
        self.pageControl.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.pageControl.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.pageControl.bottomAnchor.constraint(equalTo: self.nextButton.topAnchor, constant: 0).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(collectionView)
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.pageControl.topAnchor, constant: 0).isActive = true
        
        //self.collectionView.isScrollEnabled = false
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCell
        
        let page = pages[indexPath.item]
        if indexPath.item == 2 && indexPath.row == 2 {
            //self.nextButton.addTarget(self, action: #selector(joinAction), for: .touchUpInside)
        }
        
        cell.image1.image = UIImage(named: page.image1)
        cell.image2.image = UIImage(named: page.image2)
        cell.image3.image = UIImage(named: page.image3)
        cell.headerText.text = page.headerText
        cell.infoText.text = page.bodyText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: self.collectionView.frame.height)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.collectionViewLayout.invalidateLayout()
            if self.pageControl.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            } else {
                let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }) { (_) in
            
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / self.collectionView.frame.width)
        generalIndex = Int(x / self.collectionView.frame.width)
        if Int(x / self.collectionView.frame.width) == 0 || Int(x / self.collectionView.frame.width) == 1 {
            self.nextButton.backgroundColor = .white
            self.nextButton.setTitleColor(BLUE, for: .normal)
            self.nextButton.setTitle(NSLocalizedString("Next", comment: "--"), for: .normal)
            self.nextButton.removeTarget(self, action: #selector(joinAction), for: .touchUpInside)
        }else{
            self.nextButton.backgroundColor = BLUE
            self.nextButton.setTitleColor(.white, for: .normal)
            self.nextButton.setTitle(NSLocalizedString("JOINSNEWS", comment: "--"), for: .normal)
            self.nextButton.addTarget(self, action: #selector(joinAction), for: .touchUpInside)
        }
    }
    
    @objc func joinAction(){
        self.present(IntroVC(), animated: true, completion: nil)
    }
}
