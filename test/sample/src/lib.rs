pub fn needeless_range_loop() {
    let arr = [0; 10];

    for i in 0..10 {
        println!("{}", arr[i]);
    }
}

pub fn mut_mut() {
    let a = &mut &mut 10;
}
