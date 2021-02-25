//
//  ViewController.swift
//  MusicApp
//
//  Created by kristaps.cikuts on 22/02/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var table: UITableView!

    var songs = [Song]()
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        setupView()
        table.delegate = self
        table.dataSource = self
    }

    func configureSongs() {
        songs.append(Song(name: "Break my heart",
                          albumName: "Future Nostalgia",
                          artistName: "Dua Lipa",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Relaxing music",
                          albumName: "Random",
                          artistName: "Unknown",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Memories",
                          albumName: "through 222",
                          artistName: "Maroon 5",
                          imageName: "cover3",
                          trackName: "song3"))
        songs.append(Song(name: "Break my heart",
                          albumName: "Future Nostalgia",
                          artistName: "Dua Lipa",
                          imageName: "cover1",
                          trackName: "song1"))
        songs.append(Song(name: "Relaxing music",
                          albumName: "Random",
                          artistName: "Unknown",
                          imageName: "cover2",
                          trackName: "song2"))
        songs.append(Song(name: "Memories",
                          albumName: "through 222",
                          artistName: "Maroon 5",
                          imageName: "cover3",
                          trackName: "song3"))
       
    }
    
    private func setupView(){
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
    }

    // Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.albumName
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        // present the player
        let position = indexPath.row
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
    
    private func setupNavigationBar(){
            
            if #available(iOS 13.0, *){
            let titleImage = UIImage(systemName: "music.note")
            let imageView = UIImageView(image: titleImage)
            self.navigationItem.titleView = imageView
            }
            
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
            
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.tintColor = .black
            
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoItemTapped))
        }
        
        @objc private func infoItemTapped() {
            print("Info tapped")
         basicAlert(title: "Info", message: "This App is made as final app for IOS Bootcamp!")
        }
    }

extension ViewController{
    private func basicAlert(title: String?, message: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}
