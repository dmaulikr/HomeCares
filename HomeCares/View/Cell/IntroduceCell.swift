//
//  IntroduceCell.swift
//  HomeCares
//
//  Created by Tuat Tran on 7/7/17.
//  Copyright © 2017 Tuat Tran. All rights reserved.
//

import UIKit

class IntroduceCell: UITableViewCell {

    // MARK: Property
    
    @IBOutlet weak var introduceLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    
    // MARK: Override method
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        introduceLabel.text = "Chúng tôi đến từ Homecares, một dự án chăm sóc sức khỏe tại nhà. Được thành lập bởi các bác sĩ, điều dưỡng, kỹ thuật viên xét nghiệm đến từ các bệnh viện công của Đà Nẵng."
        purposeLabel.text = "Sau khi chứng kiến những hình ảnh thân nhân và bệnh nhân chen chúc trong bệnh viện. Chúng tôi hi vọng Homecares sẽ giải quyết được được tình trạng bệnh viện quá tải, bệnh nhân không được cung cấp dịch vụ y tế chất lượng . Tại đây khi các bạn đăng kí khám chữa bệnh, các bạn sẽ được theo dõi sức khỏe miễn phí trên hệ thống phần mềm của Homecares.  Homecares sẽ lưu giữ hồ sơ sức khỏe của bạn và gia đình, sẵn sàng truy xuất hồ sơ khi cần thiết. Nhận khám kể cả trong giờ và ngoài giờ. Bác sĩ Homecares sẽ đến tận nhà phục vụ theo thời gian thích hợp nhất cho quý khách"
    }
    
    // MARK: Internal method
}
