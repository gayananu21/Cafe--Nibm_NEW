import UIKit
//importing firebase
import Firebase

class TestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldGenere: UITextField!
    
    @IBOutlet weak var errorMessage: UILabel!
   
    @IBOutlet weak var tableViewArtists: UITableView!
    
    
     var refArtists: DatabaseReference!
    
    //list to store all the artist
     var artistList = [ArtistModel]()
    
    

    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return artistList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "MY_CELL", for: indexPath) as! TestTableViewCell
        
        //the artist object
        let artist: ArtistModel
        
        //getting the artist of selected position
        artist = artistList[indexPath.row]
        
        //adding values to labels
        cell.aName.text = artist.name
        cell.aGenere.text = artist.genre
        
        //returning cell
        return cell
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
        
        tableViewArtists.delegate = self
        tableViewArtists.dataSource = self
        
        //getting a reference to the node artists
        refArtists = Database.database().reference().child("artists");
          
          //observing the data changes
               refArtists.observe(DataEventType.value, with: { (snapshot) in
                   
                   //if the reference have some values
                   if snapshot.childrenCount > 0 {
                       
                       //clearing the list
                       self.artistList.removeAll()
                       
                       //iterating through all the values
                       for artists in snapshot.children.allObjects as! [DataSnapshot] {
                           //getting values
                           let artistObject = artists.value as? [String: AnyObject]
                           let artistName  = artistObject?["artistName"]
                           let artistId  = artistObject?["id"]
                           let artistGenre = artistObject?["artistGenre"]
                           
                           //creating artist object with model and fetched values
                           let artist = ArtistModel(id: artistId as! String?, name: artistName as! String?, genre: artistGenre as! String?)
                           
                           //appending it to list
                           self.artistList.append(artist)
                       }
                       
                       //reloading the tableview
                       self.tableViewArtists.reloadData()
                   }
               })
               
           }
    
    @IBAction func buttonAddArtist(_ sender: Any) {
        
        
        addArtist()
    }
    
    
    func addArtist(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refArtists.childByAutoId().key
        
        //creating artist with the given values
        let artist = ["id":key,
                        "artistName": textFieldName.text! as String,
                        "artistGenre": textFieldGenere.text! as String
                        ]
    
        //adding the artist inside the generated unique key
        refArtists.child(key!).setValue(artist)
        
        //displaying message
        errorMessage.text = "Artist Added"
    }

    
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }


       }
