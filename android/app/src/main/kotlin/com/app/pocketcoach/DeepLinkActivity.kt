package com.app.pocketcoach
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import io.branch.referral.Branch

class DeepLinkActivity : Activity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        // Initialize Branch session
        Branch.sessionBuilder(this).withCallback { referringParams, error ->
            if (error == null) {
                println("Branch Deep Link Data: $referringParams")
                val userId = referringParams?.get("userId");
                println("User ID from Branch link: $userId")
            } else {
                println("Branch error: ${error.message}")
            }
        }.init()

        // Redirect to MainActivity or any other activity
        val mainIntent = Intent(this, MainActivity::class.java)
        startActivity(mainIntent)
        finish() // Close DeepLinkActivity after processing the deep link
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        Branch.sessionBuilder(this).withCallback { referringParams, error ->
            if (error == null) {
                println("Branch Deep Link Data (New Intent): $referringParams")
            }
        }.reInit()
    }
}