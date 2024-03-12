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
        sortView.sortAlphabetButton.addTarget(self, action: #selector(didTapAlphabetButton(_:)), for: .touchUpInside)
        sortView.sortBirthdayButton.addTarget(self, action: #selector(didTapBirthDayButton(_:)), for: .touchUpInside)
        sortView.sortAlphabetButton.isSelected = sortType == .alphabet ? true : false
        sortView.sortBirthdayButton.isSelected = sortType == .birthday ? true : false
    }
    
    @objc func didTapAlphabetButton(_ sender: SortButton) {
        sender.isSelected = true
        sortView.sortBirthdayButton.isSelected = false
        sortType = .alphabet
        delegate?.didChooseSortType(sortType)
        dismiss(animated: true)
    }
    
    @objc func didTapBirthDayButton(_ sender: SortButton) {
        sender.isSelected = true
        sortView.sortAlphabetButton.isSelected = false
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
