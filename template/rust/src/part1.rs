fn solution(path: &str) -> i32 {
    let path_obj = std::path::Path::new(path);

    if !path_obj.exists() {
        eprintln!("File not found: {path}");
        return 0;
    }

    // Import the data
    let data = std::fs::read_to_string(path_obj).expect("Failed to read file");
    0
}

pub fn print_solution(test_val: i32) {
    if solution("data/test1") != test_val {
        println!("Test failed");
    } else {
        println!("{}", solution("data/input"));
    }
}
