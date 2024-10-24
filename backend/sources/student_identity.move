module student_identity::nft {
    use std::error;
    use std::signer;
    use std::string;
    use aptos_framework::event;

    //:!:>resource
    struct StudentIdentity has key {
        name: string::String,
        student_id: string::String,
        course: string::String,
    }
    //<:!:resource

    #[event]
    struct IdentityChange has drop, store {
        account: address,
        from_identity: StudentIdentity,
        to_identity: StudentIdentity,
    }

    /// There is no identity present
    const ENO_IDENTITY: u64 = 0;

    #[view]
    public fun get_identity(addr: address): StudentIdentity acquires StudentIdentity {
        assert!(exists<StudentIdentity>(addr), error::not_found(ENO_IDENTITY));
        borrow_global<StudentIdentity>(addr)
    }

    public entry fun set_identity(account: signer, name: string::String, student_id: string::String, course: string::String)
    acquires StudentIdentity {
        let account_addr = signer::address_of(&account);
        if (!exists<StudentIdentity>(account_addr)) {
            move_to(&account, StudentIdentity {
                name,
                student_id,
                course,
            });
        } else {
            let old_identity_holder = borrow_global_mut<StudentIdentity>(account_addr);
            let from_identity = old_identity_holder;
            let new_identity = StudentIdentity {
                name,
                student_id,
                course,
            };
            event::emit(IdentityChange {
                account: account_addr,
                from_identity,
                to_identity: new_identity,
            });
            *old_identity_holder = new_identity;
        }
    }

    #[test(account = @0x1)]
    public entry fun sender_can_set_identity(account: signer) acquires StudentIdentity {
        let addr = signer::address_of(&account);
        aptos_framework::account::create_account_for_test(addr);
        set_identity(account, string::utf8(b"John Doe"), string::utf8(b"123456"), string::utf8(b"Computer Science"));

        let identity = get_identity(addr);
        assert!(identity.name == string::utf8(b"John Doe"), ENO_IDENTITY);
        assert!(identity.student_id == string::utf8(b"123456"), ENO_IDENTITY);
        assert!(identity.course == string::utf8(b"Computer Science"), ENO_IDENTITY);
    }
}