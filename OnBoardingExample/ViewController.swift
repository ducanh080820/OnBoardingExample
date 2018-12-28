//
//  ViewController.swift
//  OnBoardingExample
//
//  Created by Duc Anh on 12/28/18.
//  Copyright © 2018 Duc Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var slides: [Slide] = []
    
    @IBOutlet weak var myScrollView: UIScrollView!
    @IBOutlet weak var myPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        myScrollView.delegate = self
        
        slides = createSlide()
        setupSlideScrollView(slides: slides)
        
        myPageControl.numberOfPages = slides.count
        myPageControl.currentPage = 0
        view.bringSubviewToFront(myPageControl)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupSlideScrollView(slides: slides)
    }
    
    //default function called when view is scolled. In order to enable callback
    // when scrollview is scrolled, the below code needs to be called:
    // slideScrollView.delegate = self or
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        myPageControl.currentPage = Int(pageIndex)
        
        let maxiumHorizontalOffset: CGFloat = scrollView.contentSize.width - scrollView.frame.width
        let currentHorizontalOffset: CGFloat = scrollView.contentOffset.x
        
        //Vertical
        let maximumVerticalOffset: CGFloat = scrollView.contentSize.height - scrollView.frame.height
        let currentVerticalOffset: CGFloat = scrollView.contentOffset.y
        
        let percentageHorizontalOffset: CGFloat = currentHorizontalOffset / maxiumHorizontalOffset
        let percentageVerticalOffset: CGFloat = currentVerticalOffset / maximumVerticalOffset
        
        //below code changes the background color of view on paging the scrollview
        //self.scrollView(scrollView, didScrollToPercentageOffset: percentageHorizontalOffset)
        
        //below code scales the imageview on paging the scrollview
        let percentOffset: CGPoint = CGPoint(x: percentageHorizontalOffset, y: percentageVerticalOffset)
        
        if (percentOffset.x > 0 && percentOffset.x <= 0.25) {
            slides[0].myImage.transform = CGAffineTransform(scaleX: (0.25-percentOffset.x)/0.25, y: (0.25-percentOffset.x)/0.25)
            slides[1].myImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.25, y: percentOffset.x/0.25)
        } else if (percentOffset.x > 0.25 && percentOffset.x <= 0.50) {
            slides[1].myImage.transform = CGAffineTransform(scaleX: (0.50-percentOffset.x)/0.25, y: (0.50-percentOffset.x)/0.25)
            slides[2].myImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.50, y: percentOffset.x/0.50)
        } else if (percentOffset.x > 0.50 && percentOffset.x <= 0.75) {
            slides[2].myImage.transform = CGAffineTransform(scaleX: (0.75-percentOffset.x)/0.25, y: (0.75-percentOffset.x)/0.25)
            slides[3].myImage.transform = CGAffineTransform(scaleX: percentOffset.x/0.75, y: percentOffset.x/0.75)
        } else if (percentOffset.x > 0.75 && percentOffset.x <= 1) {
            slides[3].myImage.transform = CGAffineTransform(scaleX: (1-percentOffset.x)/0.25, y: (1-percentOffset.x)/0.25)
            slides[4].myImage.transform = CGAffineTransform(scaleX: percentOffset.x, y: percentOffset.x)
        }
        
        
    }
    
    func createSlide() -> [Slide] {
        let slide1: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide1.myImage.image = UIImage(named: "image1")
        slide1.labelTitle.text = "A real-life bear"
        slide1.labelDescription.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide2: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.myImage.image = UIImage(named: "image2")
        slide2.labelTitle.text = "A real-life bear"
        slide2.labelDescription.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide3: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide3.myImage.image = UIImage(named: "image3")
        slide3.labelTitle.text = "A real-life bear"
        slide3.labelDescription.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide4: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.myImage.image = UIImage(named: "image4")
        slide4.labelTitle.text = "A real-life bear"
        slide4.labelDescription.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        let slide5: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.myImage.image = UIImage(named: "image5")
        slide5.labelTitle.text = "A real-life bear"
        slide5.labelDescription.text = "Did you know that Winnie the chubby little cubby was based on a real, young bear in London"
        
        return [slide1, slide2, slide3, slide4, slide5]
    }

    func setupSlideScrollView(slides: [Slide]) {
        myScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        myScrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count), height: view.frame.height)
        myScrollView.isPagingEnabled = true
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            myScrollView.addSubview(slides[i])
        }
        
    }
    
//    func scrollView(_ scrollView: UIScrollView, didScrollToPercentageOffset percentageHorizontalOffset: CGFloat) {
//        if(myPageControl.currentPage == 0) {
//            //Change background color to toRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1
//            //Change pageControl selected color to toRed: 103/255, toGreen: 58/255, toBlue: 183/255, fromAlpha: 0.2
//            //Change pageControl unselected color to toRed: 255/255, toGreen: 255/255, toBlue: 255/255, fromAlpha: 1
//
//            let pageUnselectedColor: UIColor = fade(fromRed: 255/255, fromGreen: 255/255, fromBlue: 255/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            myPageControl.pageIndicatorTintColor = pageUnselectedColor
//
//
//            let bgColor: UIColor = fade(fromRed: 103/255, fromGreen: 58/255, fromBlue: 183/255, fromAlpha: 1, toRed: 255/255, toGreen: 255/255, toBlue: 255/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            slides[myPageControl.currentPage].backgroundColor = bgColor
//
//            let pageSelectedColor: UIColor = fade(fromRed: 81/255, fromGreen: 36/255, fromBlue: 152/255, fromAlpha: 1, toRed: 103/255, toGreen: 58/255, toBlue: 183/255, toAlpha: 1, withPercentage: percentageHorizontalOffset * 3)
//            myPageControl.currentPageIndicatorTintColor = pageSelectedColor
//        }
//    }
//
//
//    func fade(fromRed: CGFloat,
//              fromGreen: CGFloat,
//              fromBlue: CGFloat,
//              fromAlpha: CGFloat,
//              toRed: CGFloat,
//              toGreen: CGFloat,
//              toBlue: CGFloat,
//              toAlpha: CGFloat,
//              withPercentage percentage: CGFloat) -> UIColor {
//
//        let red: CGFloat = (toRed - fromRed) * percentage + fromRed
//        let green: CGFloat = (toGreen - fromGreen) * percentage + fromGreen
//        let blue: CGFloat = (toBlue - fromBlue) * percentage + fromBlue
//        let alpha: CGFloat = (toAlpha - fromAlpha) * percentage + fromAlpha
//
//        // return the fade colour
//        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
//    }
    
}

