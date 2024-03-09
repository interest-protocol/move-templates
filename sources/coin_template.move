module template::coin_template {
    use std::option;
    use sui::coin;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url::new_unsafe_from_bytes;

    /// The OTW for the Coin
    struct TEMPLATE has drop {}

    const DECIMALS: u8 = 6;
    const SYMBOL: vector<u8> = b"TMPL";
    const NAME: vector<u8> = b"Template Coin";
    const DESCRIPTION: vector<u8> = b"Template Coin Description";
    const URL: vector<u8> = b"url";
    const MINT_AMOUNT: u64 = 0;
    const TREASURY_CAP_RECIPIENT: address = @0x0;

    /// Init the Coin
    fun init(witness: TEMPLATE, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness, 
            DECIMALS, 
            SYMBOL, 
            NAME, 
            DESCRIPTION, 
            option::some(new_unsafe_from_bytes(URL)), 
            ctx
        );

        coin::mint_and_transfer(&mut treasury, MINT_AMOUNT, tx_context::sender(ctx), ctx);

        transfer::public_transfer(treasury, TREASURY_CAP_RECIPIENT);
        transfer::public_share_object(metadata);
    }
}