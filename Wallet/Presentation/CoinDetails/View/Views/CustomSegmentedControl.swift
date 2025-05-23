//
//  CustomSegmentedControl.swift
//  Wallet
//
//  Created by Fedorova Maria on 22.05.2025.
//

import UIKit

final class CustomSegmentedControl: UIStackView {
    private var buttons = [UIButton]()
    
    private var selectionIndicatorLeadingConstraint: NSLayoutConstraint!
    private var selectionIndicatorWidthConstraint: NSLayoutConstraint!
    
    var onValueChanged: ((Int) -> Void)?
    var selectedIndex: Int = 0 {
        didSet {
            updateSelection()
        }
    }
    
    init(titles: [String]) {
        super.init(frame: .zero)
        setupButtons(with: titles)
        setupUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateSelection()
    }
    
    //    MARK: - Private
    private var selectionIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private var selectionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.semiBold.name, size: 14)
        label.textColor = .mirage
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupButtons(with titles: [String]) {
        axis = .horizontal
        distribution = .fillEqually
        spacing = 0
        
        buttons = titles.map { title in
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.setTitleColor(.manatee, for: .normal)
            button.setTitleColor(.mirage, for: .selected)
            button.titleLabel?.font = UIFont(name: Font.medium.name, size: 14)
            button.backgroundColor = .porcelain
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.addAction(UIAction { [weak self] _ in
                if let index = self?.buttons.firstIndex(of: button) {
                    self?.selectedIndex = index
                    self?.onValueChanged?(index)
                }
            }, for: .touchUpInside)
            return button
        }
        
        buttons.forEach(addArrangedSubview(_:))
    }
    
    private func setupUI() {
        backgroundColor = .porcelain
        layer.cornerRadius = 25
        clipsToBounds = true
        
        selectionIndicator.addSubview(selectionLabel)
        addSubview(selectionIndicator)
        
        selectionIndicatorWidthConstraint = selectionIndicator.widthAnchor.constraint(
            equalToConstant: bounds.width / CGFloat(buttons.count) - 8
        )
        selectionIndicatorLeadingConstraint = selectionIndicator.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4)
        
        NSLayoutConstraint.activate([
            selectionLabel.topAnchor.constraint(equalTo: selectionIndicator.topAnchor),
            selectionLabel.bottomAnchor.constraint(equalTo: selectionIndicator.bottomAnchor),
            selectionLabel.leadingAnchor.constraint(equalTo: selectionIndicator.leadingAnchor),
            selectionLabel.trailingAnchor.constraint(equalTo: selectionIndicator.trailingAnchor),
            
            selectionIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            selectionIndicator.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            selectionIndicatorLeadingConstraint,
            selectionIndicatorWidthConstraint
        ])
        
        selectedIndex = 0
    }
    
    private func updateSelection() {
        for (index, button) in buttons.enumerated() {
            button.isSelected = index == selectedIndex
        }
        
        guard let button = buttons[safe: selectedIndex] else { return }
        
        if let title = button.title(for: .selected) ?? button.title(for: .normal) {
            selectionLabel.text = title
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.selectionIndicatorLeadingConstraint.constant = button.frame.origin.x + 4
            self.selectionIndicatorWidthConstraint.constant = button.frame.width - 8
            self.layoutIfNeeded()
        }
    }
}
