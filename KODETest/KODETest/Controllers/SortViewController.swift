//
//  SortViewController.swift
//  KODETest
//
//  Created by Андрей Соколов on 11.03.2024.
//

import UIKit

protocol SortViewControllerDelegate: AnyObject {
   func didChooseSortType(_ sortType: SortType)
}

final class SortViewController: UIViewController {
    
    private lazy var sortView = SortView()
    var sortType: SortType
    
    weak var delegate: SortViewControllerDelegate?
    
    init(sortType: SortType) {
        self.sortType = sortType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = sortView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupButtons()
        setupSheetPresentationController()
    }
    
    private func setupNavBar() {
        navigationItem.title =  Constants.strings.sortNavBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.images.back , style: .plain, target: self, action: #selector(didTapBackButton))
        navigationItem.leftBarButtonItem?.tintColor = Constants.colors.black2
        if #available(iOS 16.0, *) {
            navigationItem.leftBarButtonItem?.isHidden = true
        } else {
            // Fallback on earlier versions
        }
        sheetPresentationController?.delegate = self
    }
    
    private func setupSheetPresentationController() {
        sheetPresentationController?.delegate = self
    }
    
    private func setupButtons() {
        let alphabetTap = UITapGestureRecognizer(target: self, action: #selector( didTapAlphabetView(_:)))
        let birthdayTap = UITapGestureRecognizer(target: self, action: #selector(didTapBirthdayButton(_:)))
        sortView.alphabetOptionView.addGestureRecognizer(alphabetTap)
        sortView.birthdayOptionView.addGestureRecognizer(birthdayTap)
        sortType == .alphabet ? sortView.alphabetOptionView.toSelectedState() : sortView.birthdayOptionView.toSelectedState()
    }
    
    @objc func didTapAlphabetView(_ sender: UITapGestureRecognizer) {
        sortView.alphabetOptionView.toSelectedState()
        sortView.birthdayOptionView.toNormalState()
        sortType = .alphabet
        delegate?.didChooseSortType(sortType)
        dismiss(animated: true)
    }
    
    @objc func didTapBirthdayButton(_ sender: UITapGestureRecognizer) {
        sortView.alphabetOptionView.toNormalState()
        sortView.birthdayOptionView.toSelectedState()
        sortType = .birthday
        delegate?.didChooseSortType(sortType)
        dismiss(animated: true)
    }
    
    @objc func didTapBackButton() {
        dismiss(animated: true)
    }
}

extension SortViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        if #available(iOS 16.0, *) {
            navigationItem.leftBarButtonItem?.isHidden = sheetPresentationController.selectedDetentIdentifier == .medium ? true : false
        } else {
            // Fallback on earlier versions
        }
        sheetPresentationController.prefersGrabberVisible = sheetPresentationController.selectedDetentIdentifier == .medium ? true : false
    }
}
