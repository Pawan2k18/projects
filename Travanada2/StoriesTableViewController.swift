import UIKit

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
}

class StoriesTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    var headlines = [
        Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque id ornare tortor, quis dictum enim. Morbi convallis tincidunt quam eget bibendum. Suspendisse malesuada maximus ante, at molestie massa fringilla id.", image: "Blueberry"),
        Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non, finibus et diam. Morbi et felis a lacus pharetra blandit.", image: "Banana"),
        Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc in ipsum vehicula accumsan quis sit amet quam. Sed vel feugiat eros.", image: "Apricot"),
        ]
    
    // MARK: - Table view data source
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return headlines.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
//
//        let headline = headlines[indexPath.row]
//        cell.textLabel?.text = headline.title
//        cell.detailTextLabel?.text = headline.text
//        cell.imageView?.image = UIImage(named: headline.image)
//
//        return cell
//    }
    
    
    
    
    // MARK: - Doing seconf time
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! TableViewCell
        
        let headline = headlines[indexPath.row]
        cell.nameLabel.text = headline.title
        cell.dobLabel.text = headline.text
        cell.imageView?.image = UIImage(named: headline.image)
        
//        let imgURL = NSURL(string: imgURLArray[indexPath.row])
//
//        if imgURL != nil {
//            let data = NSData(contentsOf: (imgURL as? URL)!)
//            cell.imgView.image = UIImage(data: data as! Data)
//        }
        
        return cell
    }
    
//    ///for showing next detailed screen with the downloaded info
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
//        vc.imageString = imgURLArray[indexPath.row]
//        vc.nameString = nameArray[indexPath.row]
//        vc.dobString = dobArray[indexPath.row]
//
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
    
    
    
    
}
