//
//  ViewController.swift
//  A4_TicTacToeApp
//
//  Created by Dipak on 30/04/1943 Saka.
//
//
import UIKit

class ViewController: UIViewController
{
    
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private var winningCombinations = [[0,1,2,3],[4,5,6,7],[8,9,10,11],[12,13,14,15],[0,4,8,12],[1,5,9,13],[2,6,10,14],[3,7,11,15],[0,5,10,15],[3,6,9,12]]
    
    private var zeroFlag = false
    
    private let myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 200, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .yellow
        return collectionView
    }()

    private let mylabel:UILabel = {
        let lb=UILabel()
        lb.text="Tic Tac Toe"
        lb.backgroundColor = .systemPink
        lb.textColor = .white
        lb.textAlignment = .center
        return lb
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.addSubview(mylabel)
        title = "TicTacToe"
        view.addSubview(myCollectionView)
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        myCollectionView.frame = view.bounds
        mylabel.frame = CGRect(x: 10, y: view.safeAreaInsets.top+100, width: view.width, height: 50)
    }
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        myCollectionView.register(T4Cell.self, forCellWithReuseIdentifier: "t4cell")
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "t4cell", for: indexPath) as! T4Cell
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                state.insert(0, at: indexPath.row)
            } else {
                state.insert(1, at: indexPath.row)
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    private func checkWinner() {
        
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations {
            if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[0] ] != 2 {
                announceWinner(player: state[ i[0] ] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func resetState() {
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        zeroFlag = false
        myCollectionView.reloadData()
    }
}


