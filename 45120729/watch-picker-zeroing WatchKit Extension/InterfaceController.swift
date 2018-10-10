import WatchKit

class InterfaceController: WKInterfaceController {
    @IBOutlet var picker: WKInterfacePicker!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        let items = Array(1...100).map { (value) -> WKPickerItem in
            let item = WKPickerItem()
            item.title = String(format: "%d", value)
            return item
        }

        picker.setItems(items)
        picker.setSelectedItemIndex(50)

        // setTitle("Optional long interface controller title")
    }
}
