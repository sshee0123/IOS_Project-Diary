//
//  DiaryViewController.swift
//  iosproject-1891196
//
//  Created by 박세희 on 2021/05/25.
//

import UIKit

class DiaryViewController: UIViewController {
    @IBOutlet weak var diaryLabel: UILabel!
    @IBOutlet weak var diaryTitleTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var diaryContentTextView: UITextView!
    var selectday: String = "" //선택 날짜
    let imagePickerController = UIImagePickerController() //imagepickercontroller 생성
}

extension DiaryViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Diary"
        diaryLabel.text = selectday
        
        //데이터 저장
        self.diaryTitleTextField.text = UserDefaults.standard.string(forKey: "diaryTitle")
        if let diaryImageData = UserDefaults.standard.object(forKey:"diaryImage") as? NSData{
            if let diaryImage = UIImage(data: diaryImageData as Data){
                self.imageView.image = diaryImage
            }
        }
        self.diaryContentTextView.text = UserDefaults.standard.string(forKey: "diaryContent")
        
        imagePickerController.delegate = self //imagepickercontroller 대리자로 등록
       
    }
}

//diary 저장
extension DiaryViewController{
    @IBAction func saveBtn(_ sender: UIButton) {
        UserDefaults.standard.setValue(diaryTitleTextField.text, forKey: "diaryTitle")
        UserDefaults.standard.setValue(diaryContentTextView.text, forKey: "diaryContent")
        
    }
}

//imagepickerController
extension DiaryViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //imagepickercontroller 대리자로서 자격 취득
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        if let image = image{
            imageView.image = image //선택한 이미지
            
            let tmp_img = image.jpegData(compressionQuality: 0.1)
            UserDefaults.standard.set(tmp_img, forKey: "diaryImage")
            UserDefaults.standard.synchronize()
        }
    
        imagePickerController.dismiss(animated: true, completion: nil) //imagepickercontroller 죽이기
    }
}

//카메라 or 갤러리 연결
extension DiaryViewController{
    @IBAction func addImage(_ sender: UIBarButtonItem) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        }
        else{
            imagePickerController.sourceType = .photoLibrary
        }
        present(imagePickerController, animated: true, completion: nil)
    }
}

