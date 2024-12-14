extern crate cxx;

#[cxx::bridge]
mod ffi {
    #[namespace = "rust"]
    extern "Rust" {
        fn rust_echo(val: i32) -> i32;
    }
}

fn rust_echo(val: i32) -> i32 {
    val
}

