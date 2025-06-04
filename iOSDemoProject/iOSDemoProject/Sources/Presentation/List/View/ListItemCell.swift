//
//  ListItemCell.swift
//  iOSDemoProject
//
//  Created by Vadym Mitin on 09.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//


import UIKit

#if DEBUG
import SwiftUI
#endif

final class ListItemCell: UITableViewCell {
    struct ViewProps {
        let title: String
        let duration: Int
        
        static let initial = ListItemCell.ViewProps(
            title: "",
            duration: 0
        )
    }
    
    private var viewProps = ListItemCell.ViewProps.initial
    
    private let containerView = UIView()
    
    private let iconImageView = UIImageView()
    private let iconImageViewBackground = UIView()
    private let chevronImageView = UIImageView()
    
    private let titleLabel = UILabel()
    private let durationLabel = UILabel()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public func render(viewProps: ListItemCell.ViewProps) {
        self.viewProps = viewProps
        
        titleLabel.text = viewProps.title
        durationLabel.text = "\(viewProps.duration) hours"
        
        setNeedsLayout()
    }
}

private extension ListItemCell {
    func commonInit() {
        configureUI()
        configureLayout()
    }
    
    func configureUI() {
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor(hexString: "#F4F4F5").withAlphaComponent(0.2)
        
        containerView.backgroundColor = UIColor(hexString: "#F4F4F5")
        containerView.layer.cornerRadius = 12
        
        iconImageViewBackground.backgroundColor = UIColor(hexString: "#CDDC39")
        iconImageViewBackground.layer.cornerRadius = 20
        
        iconImageView.image = UIImage(named: "icon_clock")
        chevronImageView.image = UIImage(named: "icon_ chevron")
        
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        titleLabel.textColor = UIColor(hexString: "#8E8E93")
        titleLabel.numberOfLines = 1
        
        durationLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        durationLabel.textColor = .black
        durationLabel.numberOfLines = 1
    }
    
    func configureLayout() {
        contentView.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(6)
        }
        
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.spacing = 0
        [titleLabel, durationLabel].forEach(textStackView.addArrangedSubview)
        
        [
            iconImageViewBackground,
            textStackView,
            chevronImageView,
        ].forEach(containerView.addSubview)
        
        iconImageViewBackground.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        iconImageViewBackground.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(18)
            make.center.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
        
        textStackView.snp.makeConstraints { make in
            make.leading.equalTo(iconImageViewBackground.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.lessThanOrEqualTo(chevronImageView.snp.leading).offset(-16)
        }
    }
}

#if DEBUG
struct ListItemCell_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            UIViewPreview {
                let cell = ListItemCell()
                cell.render(
                    viewProps: ListItemCell.ViewProps(
                        title: "Circadian Rhythm TRF",
                        duration: 12
                    )
                )
                
                let view = UIView()
                view.backgroundColor = .white
                view.addSubview(cell)
                cell.snp.makeConstraints { make in
                    make.edges.equalToSuperview()
                }
                
                return view
            }.previewLayout(.fixed(width: 375, height: 80))
        }
    }
}
#endif
