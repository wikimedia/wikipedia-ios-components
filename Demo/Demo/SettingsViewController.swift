import UIKit

class SettingsViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupInitialViews()
        addThemeButtons()

        view.backgroundColor = .white
    }
    
    private func setupInitialViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: scrollView.frameLayoutGuide.topAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: scrollView.frameLayoutGuide.bottomAnchor),
            view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            scrollView.contentLayoutGuide.topAnchor.constraint(equalTo: stackView.topAnchor),
            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            scrollView.contentLayoutGuide.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            scrollView.contentLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
    }
    
    private func addThemeButtons() {
        
        let defaultButton = UIButton(type: .system)
        defaultButton.setTitle("Default", for: .normal)
        defaultButton.addTarget(self, action: #selector(tappedDefault), for: .touchUpInside)
        
        let lightButton = UIButton(type: .system)
        lightButton.setTitle("Light", for: .normal)
        lightButton.addTarget(self, action: #selector(tappedLight), for: .touchUpInside)
        
        let sepiaButton = UIButton(type: .system)
        sepiaButton.setTitle("Sepia", for: .normal)
        sepiaButton.addTarget(self, action: #selector(tappedSepia), for: .touchUpInside)
        
        let darkButton = UIButton(type: .system)
        darkButton.setTitle("Dark", for: .normal)
        darkButton.addTarget(self, action: #selector(tappedDark), for: .touchUpInside)
        
        let blackButton = UIButton(type: .system)
        blackButton.setTitle("Black", for: .normal)
        blackButton.addTarget(self, action: #selector(tappedBlack), for: .touchUpInside)
        
        stackView.addArrangedSubview(defaultButton)
        stackView.addArrangedSubview(lightButton)
        stackView.addArrangedSubview(sepiaButton)
        stackView.addArrangedSubview(darkButton)
        stackView.addArrangedSubview(blackButton)
    }
            
    @objc private func tappedDefault() {
        
    }
    
    @objc private func tappedLight() {
        
    }
    
    @objc private func tappedSepia() {
        
    }
    
    @objc private func tappedDark() {
        
    }
    
    @objc private func tappedBlack() {
        
    }
}

