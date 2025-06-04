//
//  ListViewController.swift
//  iOSDemoProject
//
//  Created Vadym Mitin on 07.06.2023.
//  Copyright © 2023 BetterMe. All rights reserved.
//

import UIKit

#if DEBUG
import SwiftUI
#endif

final class ListViewController: UIViewController {
    struct Props: Equatable {
        struct ContentItem: Equatable {
            let name: String
            let durationHours: Int
            let onClick: Command
        }
        
        enum ContentState: Equatable {
            case loading
            case loaded([ContentItem])
        }
        
        let contentState: ContentState
        let onAppeared: Command
        let onDestroy: Command
        
        static let initial = Props(
            contentState: .loading,
            onAppeared: .nop,
            onDestroy: .nop
        )
    }
    
    private var willAppearObservers: [() -> Void] = []
    private var didDisappearObservers: [() -> Void] = []
    private var props = Props.initial
    
    private lazy var tableView = UITableView()
    
    private let loadingView = UIActivityIndicatorView()
    
    deinit {
        props.onDestroy.perform()
    }
    
    func render(props: Props) {
        guard self.props != props else { return }
        self.props = props
        
        tableView.reloadData()
        
        switch props.contentState {
        case .loading:
            loadingView.startAnimating()
        case .loaded:
            loadingView.stopAnimating()
        }
        
        view.setNeedsLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        willAppearObservers.forEach { $0() }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        didDisappearObservers.forEach { $0() }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        props.onAppeared.perform()
    }
    
    func addWillAppearObserver(_ block: @escaping () -> Void) {
        willAppearObservers.append(block)
    }

    func addDidDisappearObserver(_ block: @escaping () -> Void) {
        didDisappearObservers.append(block)
    }
}

// MARK: - Private methods
private extension ListViewController {
    func configureUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Fasting list"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.backgroundView = loadingView
    }
    
    func configureLayout() {
        [
            tableView,
        ].forEach(view.addSubview)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch props.contentState {
        case .loading: return 0
        case .loaded(let items): return items.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            case .loaded(let items) = props.contentState,
            let item = items[safe: indexPath.row]
        else { return UITableViewCell() }
        
        let cell: ListItemCell
        if let instance = tableView.dequeueReusableCell(withIdentifier: ListItemCell.reuseIdentifier()) as? ListItemCell {
            cell = instance
        } else {
            cell = ListItemCell(style: .default, reuseIdentifier: ListItemCell.reuseIdentifier())
        }
        
        cell.render(
            viewProps: ListItemCell.ViewProps(
                title: item.name,
                duration: item.durationHours
            )
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        
        guard
            case .loaded(let items) = props.contentState,
            let item = items[safe: indexPath.row]
        else { return }
        
        item.onClick.perform()
    }
}

#if DEBUG
struct ListViewController_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            ForEach(PreviewDeviceModifier.defaultDevices()) {
                UIViewControllerPreview {
                    let vc = ListViewController()
                    vc.render(
                        props: ListViewController.Props(
                            contentState: .loaded([
                                .init(name: "First", durationHours: 10, onClick: .nop),
                                .init(name: "Second", durationHours: 12, onClick: .nop)
                            ]),
                            onAppeared: .nop,
                            onDestroy: .nop
                        )
                    )
                    return UINavigationController(rootViewController: vc)
                }.modifier($0)
            }
        }
    }
}
#endif
